import 'package:http/http.dart' as http;
import 'dart:convert'; 



class ApiService {
  static const String baseUrl = 'https://conciergebooking.tijarah.ae/api/'; 
  static const String resendOtpUrl = '${baseUrl}user/resend/otp';
  static const String verifyOtpUrl = '${baseUrl}user/verify/email';
  static const String verifyOtpUrlForgotPassword = '${baseUrl}user/verify/code';

  static Future<ApiResponse> sendEmailOTP(String email) async {
    final response = await http.post(
      Uri.parse(resendOtpUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'type': 'email',
        'email': email,
        
      }),
    );

    try {
      if (response.statusCode == 200) {
        return ApiResponse(success: true, message: 'OTP sent successfully');
      } else {
        print('Response body:llllllllll ${response.body}');
        return ApiResponse(success: false, message: 'Failed to send OTP');
      }
    } catch (e) {
      print('Error while parsing response: $e');
      return ApiResponse(success: false, message: 'An error occurred');
    }
  }

  

  //  static Future<ApiResponse> verifyOtpForgotPassword(String email, String otp) async {
  //   final response = await http.post(
  //     Uri.parse(verifyOtpUrlForgotPassword),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode({
  //       'type':"email",
  //       'email': email,
  //       'otp': otp,
  //     }),
  //   );

  //   try {
  //     if (response.statusCode == 200) {
  //       return ApiResponse(success: true, message: 'OTP verified successfully');
  //     } else {
  //       print('Response body:hehehehe ${response.body}');
  //       return ApiResponse(success: false, message: 'Failed to verify OTP');
  //     }
  //   } catch (e) {
  //     print('Error while parsing response: $e');
  //     return ApiResponse(success: false, message: 'An error occurred');
  //   }
  // }

  
static Future<ApiResponse> verifyEmailOTP(String email, String otp) async {
  var client = http.Client();
  try {
    final request = http.Request(
      'POST',
      Uri.parse('https://conciergebooking.tijarah.ae/api/user/verify/email'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
    });
    request.body = jsonEncode({
      'type': 'email',
      'email': email,
      'otp': otp,
    });

    final response = await client.send(request);

    // Check if the response is a redirect (3xx status codes)
    if (response.isRedirect) {
      print('Redirect found, handling...');
      return ApiResponse(success: false, message: 'Redirect error during email OTP verification');
    }

    final responseBody = await http.Response.fromStream(response);

    print('Status code: ${responseBody.statusCode}');
    print('Response body: ${responseBody.body}');

    if (responseBody.statusCode >= 200 && responseBody.statusCode < 300) {
      return ApiResponse(success: true, message: 'Email OTP verified successfully');
    } else if (responseBody.statusCode == 403) {
      return ApiResponse(success: false, message: 'Account created but pending approval');
    } else {
      return ApiResponse(success: false, message: 'Failed to verify email OTP');
    }
  } catch (e) {
    print('Error while parsing response: $e');
    return ApiResponse(success: false, message: 'An error occurred during email OTP verification');
  } finally {
    client.close();
  }
}


}

class ApiResponse {
  final bool success;
  final String message;

  ApiResponse({required this.success, required this.message});

  get body => null;

  get statusCode => null;
}

//   static Future<ApiResponse> sendEmailOTP(String email) async {
//   final response = await http.post(
//     Uri.parse(resendOtpUrl),
//     headers: {
//       'Content-Type': 'application/json', // Ensure the server knows you're sending JSON
//     },
//     body: jsonEncode({
//       'type': 'email',
//       'email': email,
//     }),
//   );

//   // Check if the response is in JSON format
//   try {
//     if (response.statusCode == 200) {
//       return ApiResponse(success: true, message: 'OTP sent successfully');
//     } else {
//       // Log the response body for debugging
//       print('Response body: ${response.body}');
//       return ApiResponse(success: false, message: 'Failed to send OTP');
//     }
//   } catch (e) {
//     print('Error while parsing response: $e');
//     return ApiResponse(success: false, message: 'An error occurred');
//   }
// }


//   static Future<ApiResponse> verifyEmailOTP(String email, String otp) async {
//     final response = await http.post(
//       Uri.parse(verifyOtpUrl),
//       body: {
//         'email': email,
//         'otp': otp,
//       },
//     );

//     // Check if the response is in JSON format
//     try {
//       if (response.statusCode == 200) {
//         return ApiResponse(success: true, message: 'OTP verified successfully');
//       } else {
//         // Log the response body for debugging
//         print('Response body: ${response.body}');
//         return ApiResponse(success: false, message: 'Failed to verify OTP');
//       }
//     } catch (e) {
//       print('Error while parsing response: $e');
//       return ApiResponse(success: false, message: 'An error occurred');
//     }
//   }
// }


// class ApiResponse {
//   final bool success;
//   final String message;

//   ApiResponse({required this.success, required this.message});
// }
