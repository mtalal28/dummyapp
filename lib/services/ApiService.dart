// ignore_for_file: file_names

import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://conciergebooking.tijarah.ae/api/';
  static const String login = '${baseUrl}user/login';
  static const String resendOtpUrl = '${baseUrl}user/resend/otp';
  static const String verifyOtpUrl = '${baseUrl}user/verify/email';
  static const String sendOtpForgotPassword= '${baseUrl}user/forgot/password';
  static const String verifyOtpUrlForgotPassword = '${baseUrl}user/verify/code';
  static const String getUnapprovedConcierges = '${baseUrl}requested/concierges';
  static const String approveConcierge = '${baseUrl}approve/user';
  static const String allapprovedConcierge = '${baseUrl}concierges';
  static const String updateprofile = '${baseUrl}update-profile';

static Future<ApiResponse> loginemail(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('https://conciergebooking.tijarah.ae/api/user/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'type': 'email',
        'email': email,
        'password': password,
      }),
    );

    log('Response body: ${response.body}');
    log('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      log('Decoded response: $jsonResponse');

      if (jsonResponse.containsKey('error')) {
        return ApiResponse(success: false, message: jsonResponse['error']);
      } else {
        // Check if token and id exist and handle nullability
        String? token = jsonResponse['token'] as String?; 
        int? id = jsonResponse['user']['id'] as int?;

        log('User ID: $id');
        log('Token: $token');

        // Return ApiResponse
        return ApiResponse(
          success: true, 
          message: jsonResponse['message'], 
          token: token ?? '', // Provide a fallback value for nullable types
          id: id ?? 0, // Provide a fallback value for nullable types
        );
      }
    } else {
      return ApiResponse(success: false, message: 'Failed to login');
    }
  } catch (e) {
    log('Error while processing login: $e');
    return ApiResponse(success: false, message: 'An error occurred');
  }
}


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
        log('Response body:llllllllll ${response.body}');
        return ApiResponse(success: false, message: 'Failed to send OTP');
      }
    } catch (e) {
      log('Error while parsing response: $e');
      return ApiResponse(success: false, message: 'An error occurred');
    }
  }


 static Future<ApiResponse> sendOtpForForgotPassword(String email) async {
  const url = sendOtpForgotPassword; 
  log('Sending OTP request to: $url'); 
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      
    },
    body: jsonEncode({
      'type': "email",
      'email': email,
     
    }),
  );

  try {
    if (response.statusCode == 200) {
      log('OTP sent successfully: ${response.body}');
      return ApiResponse(success: true, message: 'OTP sent successfully');
    } else {
      log('Failed to send OTP: Status Code: ${response.statusCode}');
      log('Response body: ${response.body}');
      return ApiResponse(success: false, message: 'Failed to send OTP');
    }
  } catch (e) {
    log('Error while sending OTP: $e');
    return ApiResponse(success: false, message: 'An error occurred');
  }
}



   static Future<ApiResponse> verifyOtpForgotPassword(String email, String otp) async {
    final response = await http.post(
      Uri.parse(verifyOtpUrlForgotPassword),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'type':"email",
        'email':  email,
        'otp': otp,
      }),
    );

    try {
      if (response.statusCode == 200) {
        return ApiResponse(success: true, message: 'OTP verified successfully');
      } else {
        log('Response body:hehehehe ${response.body}');
        return ApiResponse(success: false, message: 'Failed to verify OTP');
      }
    } catch (e) {
      log('Error while parsing response: $e');
      return ApiResponse(success: false, message: 'An error occurred');
    }
  }

 
  static Future<ApiResponse> verifyEmailOTP(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('https://conciergebooking.tijarah.ae/api/user/verify/email'),
        body: jsonEncode({
          "type": "email",
          "email": Get.arguments['email'],
          "otp": "123123"
        }),
      );
      log(response.toString());
    } catch (e) {
      log("Error in verifying email: $e");
    }
    return ApiResponse(message: "Verifying", success: false);



    
  }

static Future<ApiResponse> unapprovedConcierges({
  String sortBy = 'joining_date',
  String sortOrder = 'desc',
  String searchText = '',
}) async {
  final Uri apiUrl = Uri.parse('https://conciergebooking.tijarah.ae/api/requested/concierges').replace(
    queryParameters: {
      'sort_by': sortBy,
      'sort_order': sortOrder,
      'search_text': searchText,
    },
  );

  final response = await http.get(
    apiUrl,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 1337|x40UJD2c1rmU1Bu59Jwv6EqjrfgY1tno5g61q7Pn95d7d8b4',
    },
  );
  
  try {
    // log('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('Decoded data: ${response.statusCode}');
      return ApiResponse(success: true, message: 'Fetched unapproved concierges successfully', data: data);
    } else {
      log('Response body: ${response.statusCode}');
      return ApiResponse(success: false, message: 'Failed to fetch unapproved concierges');
    }
  } catch (e) {
    log('Error while parsing response: $e');
    return ApiResponse(success: false, message: 'An error occurred');
  }
}

static Future<ApiResponse> approveConcierges(int id, double commissionPercentage, dynamic widget, ) async {
    try {
      final response = await http.post(
        Uri.parse('https://conciergebooking.tijarah.ae/api/approve/user'),
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Authorization" : " Bearer 1381|Rod2mLe4UlGaZr8mfWzvveKySUrQ4mAfo1dqhLOcec4309e0"
        },
        body: jsonEncode({
          "user_id": widget.concierge[id].toString(),
          "commission_percentage": "$commissionPercentage",
        
        }),
      );

      // log(response.toString()); 
      log("response ::::::::: ${response.body}");

      if (response.statusCode == 200) {
    
        return ApiResponse(
          message: "Concierge approved successfully",
          success: true,
        );
      } else {
       
        return ApiResponse(
          message: "Failed to approve concierge: ${response.body}",
          success: false,
        );
      }
    } catch (e) {
      log("Error in approving concierge: $e");
      return ApiResponse(
        message: "Error occurred while approving concierge",
        success: false,
      );
    }
  }

    static Future<ApiResponse> getApprovedConcierges({
    String sortBy = 'name',  
    String sortOrder = 'asc',       
    String searchText = '',          
  }) async {
    try {
      final uri = Uri.https(
        'conciergebooking.tijarah.ae', 
        '/api/concierges',
        {
          'sort_by': sortBy,
          'sort_order': sortOrder,
          'search_text': searchText,
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer 1392|kL1S3uKteS033PkkhaHIMhrXEEN21BhqOZFpI0baa94e0010',
        },
      );

      log("response ===== ${response.body}");

      if (response.statusCode == 200) {
       
        final data = jsonDecode(response.body);
        return ApiResponse(
          message: "Concierges fetched successfully",
          success: true,
          data: data, 
        );
      } else {
        // Handle error response
        return ApiResponse(
          message: "Failed to fetch concierges: ${response.body}",
          success: false,
        );
      }
    } catch (e) {
      log("Error in fetching approved concierges: $e");
      return ApiResponse(
        message: "Error occurred while fetching concierges",
        success: false,
      );
    }
  }


static Future<ApiResponse> updateProfile({
  required String id, 
  required String firstName,
  required String lastName,
  // required String email,
  required String waCode,
  required String waNumber,
  required String dob,
  required String paymentMethod,
  required String businessName,
  required String mobileCode,
  required String mobileNumber,
  required String whatsappNumber,
  required String bankName,
  required String accountNumber,
  required String cardHolderName,
  required String paymentPreference,
  String? partnershipAgreement,
  bool isEmailChanged = true,
}) async {
  try {
    Map<String, dynamic> body = {
      "id": id, 
      "first_name": firstName,
      "last_name": lastName,
      // if (isEmailChanged) "email": email,
      "wa_code": waCode,
      "wa_number": waNumber,
      "dob": dob,
      "payment_method": paymentMethod,
      "business_name": businessName,
      "mobile_code": mobileCode,
      "mobile_number": mobileNumber,
      "bank_name": bankName,
      "account_number": accountNumber,
      "card_holder_name": cardHolderName,
      "payment_preference": paymentPreference,
    };

    final response = await http.post(
      Uri.parse('https://conciergebooking.tijarah.ae/api/update-profile'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1591|UjPPkU3yq0XRa9MxYQCS13klTLjk5P5AnpdNgqJs481829eb',
      },
      body: jsonEncode(body),
    );

    log("Response: ${response.body}");

    if (response.statusCode == 200) {
      return ApiResponse(
        message: "Profile updated successfully",
        success: true,
      );
    } else {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      log("Error updating profile: ${errorResponse["message"]}");
      return ApiResponse(
        message: errorResponse["message"] ?? "Failed to update profile",
        success: false,
      );
    }
  } catch (e) {
    log("Error in updating profile: $e");
    return ApiResponse(
      message: "An error occurred while updating profile",
      success: false,
    );
  }
}


}







class ApiResponse {
  final bool success;
  final String message;
  final dynamic data; 
  final String? token; 
  final int? id;

  ApiResponse({required this.success, required this.message, this.data, this.token, this.id});

  
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'token': token,
      'userId':id
    };
  }
}






// var client = http.Client();
    // try {
    //   final request = http.Request(
    //     'POST',
    //     Uri.parse('https://conciergebooking.tijarah.ae/api/user/verify/email'),
    //   );
    //   request.headers.addAll({
    //     'Content-Type': 'application/json',
    //   });
    //   request.body = jsonEncode({
    // 'type': 'email',
    // 'email': email,
    // 'otp': otp,
    //   });

    //   final response = await client.send(request);

    //   // Check if the response is a redirect (3xx status codes)
    //   if (response.isRedirect) {
    //     print('Redirect found, handling...');
    //     return ApiResponse(success: false, message: 'Redirect error during email OTP verification');
    //   }

    //   final responseBody = await http.Response.fromStream(response);

    //   print('Status code: ${responseBody.statusCode}');
    //   print('Response body: ${responseBody.body}');

    //   if (responseBody.statusCode >= 200 && responseBody.statusCode < 300) {
    //     return ApiResponse(success: true, message: 'Email OTP verified successfully');
    //   } else if (responseBody.statusCode == 403) {
    //     return ApiResponse(success: false, message: 'Account created but pending approval');
    //   } else {
    //     return ApiResponse(success: false, message: 'Failed to verify email OTP');
    //   }
    // } catch (e) {
    //   print('Error while parsing response: $e');
    //   return ApiResponse(success: false, message: 'An error occurred during email OTP verification');
    // } finally {
    //   client.close();
    // }




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

/**
 * UserModel {
 * name,
 * email,
 * dob,
 * AddressModel address,
 * PhoneModel phone,
 * }
 * 
 * AddressModel {
 * country,
 * state,
 * houseNo,
 * postalCode,
 * }
 * 
 * PhoneModel {
 * countryCode,
 * phoneNumber,
 * coutryName,
 * }
 * 
 */