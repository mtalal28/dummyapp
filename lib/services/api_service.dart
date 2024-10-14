import 'dart:convert' show jsonEncode;
import 'dart:async' show TimeoutException;
import 'package:http/http.dart' as http;

class ApiService {

  
  static const Duration _defaultTimeout = Duration(seconds: 10);
    
    


  static Map<String, String> _defaultHeaders() {
    return {'Content-Type': 'application/json; charset=UTF-8'};
  }

  static Future<Map<String, dynamic>> _handleRequest(
    Future<Map<String, dynamic>> Function() requestFunction,
  ) async {
    try {
      return await requestFunction();
    } on TimeoutException catch (_) {
      return _handleError(message: "Request Timeout");
    } on http.ClientException catch (e) {
      return _handleError(message: e.message);
    } on FormatException catch (e) {
      return _handleError(message: e.message);
    } catch (e) {
      return _handleError(message: e.toString());
    }
  }

  static Map<String, dynamic> _handleError({required String message}) {
    return {
      'status': 500,
      'body': jsonEncode({'error': message}),
    };
  }

  static Future<Map<String, dynamic>> sendRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    return _handleRequest(() async {
      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: _defaultHeaders(),
          )
          .timeout(_defaultTimeout);

      return {'status': response.statusCode, 'body': response.body};
    });
  }

  static Future<Map<String, dynamic>> sendGetRequest(
    String url, {
    String params = "",
  }) async {
    return _handleRequest(() async {
      final uri = Uri.parse('$url/$params'.trim());
      final response = await http
          .get(
            uri,
            headers: _defaultHeaders(),
          )
          .timeout(_defaultTimeout);

      return {'status': response.statusCode, 'body': response.body};
    });
  }

  static Future<Map<String, dynamic>> sendFormDataRequest(
    String url,
    Map<String, dynamic> formData,
  ) async {
    return _handleRequest(() async {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      var response = await request.send().timeout(_defaultTimeout);
      var responseBody = await response.stream.bytesToString();

      return {'status': response.statusCode, 'body': responseBody};
    });
  }

  // static Future<String> uploadFile({
  //   required String filePath,
  //   required String url,
  //   required String uid,
  // }) async {
  //   final uri = Uri.parse(url);
  //   final request = http.MultipartRequest('POST', uri);

  //   request.headers['Content-Type'] = "multipart/form-data";
  //   request.fields['user_id'] = uid;

  //   final file = File(filePath);
  //   final fileName = file.path.split('/').last;
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'file',
  //     file.path,
  //     filename: fileName,
  //   ));

  //   try {
  //     final response = await request.send();
  //     String responseBody = await response.stream.bytesToString();

  //     if (response.statusCode == 200) {
  //       return jsonDecode(responseBody)['file_url'] as String;
  //     } else {
  //       throw Exception('Failed to upload profile');
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

     

}
