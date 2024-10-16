// ignore_for_file: must_be_immutable, library_private_types_in_public_api, file_names

import 'dart:developer';

import 'package:easyrsv/features/concierge/authenction/view/confirmation.dart';
import 'package:easyrsv/services/api_routes.dart';
import 'package:easyrsv/services/api_service.dart';
import 'package:easyrsv/appFeatures/widget.dart/text_field_with_label.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNo;
  String verificationId;
  final String email;

  OtpVerificationPage({
    super.key,
    required this.phoneNo,
    required this.verificationId,
    required this.email,
  });

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController phoneOtpController = TextEditingController();
  final TextEditingController otpController =
      TextEditingController(); // For email OTP
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    log("argssssssss : $arguments");
    if (arguments != null) {
      // widget.verificationId = arguments['verificationId'];
      // log('Received Verification ID: ${widget.verificationId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'OTP Verification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter the OTP sent to \n+92 3314317076',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Phone OTP Input Field
              // Assuming you have controllers for the OTP fields
              TextFieldWithLabel(
                controller: phoneOtpController,
                label: 'Phone OTP',
                hint: 'Enter 6-digit OTP',
                isMandatory: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                onChanged: (value) {},
              ),

              const SizedBox(height: 20),

              TextFieldWithLabel(
                controller: otpController,
                label: 'Email OTP',
                hint: 'Enter 4-digit OTP',
                isMandatory: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: (value) {},
              ),

              const SizedBox(height: 10),

              // Resend Phone OTP Button
              TextButton(
                onPressed: () {
                  _resendPhoneOTP();
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Didn\'t receive the phone code? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Resend Phone OTP',
                        style: TextStyle(
                          color: Color(0xFFD6B560),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Resend Email OTP Button
              TextButton(
                onPressed: () {
                  _resendEmailOTP();
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Didn\'t receive the email code? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Resend Email OTP',
                        style: TextStyle(
                          color: Color(0xFFD6B560),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              isLoading
                  ? const CircularProgressIndicator(
                      color: Color(0xFFD6B560),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        _verifyBothOTPs();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD6B560),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to verify both Phone and Email OTPs
  Future<void> _verifyBothOTPs() async {
    // String phoneOtp = phoneOtpController.text.trim();
    String otp = otpController.text.trim();
    // bool phoneOtpVerified = false;
    // ignore: unused_local_variable
    bool otpVerified = false;

    // Validate Phone OTP
    // if (phoneOtp.isEmpty || phoneOtp.length != 6) {
    //   Get.snackbar(
    //     'Error',
    //     'Please enter a valid 6-digit phone OTP.',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.red,
    //   );
    //   return;
    // }

    // Validate Email OTP
    if (otp.isEmpty || otp.length != 4) {
      Get.snackbar(
        'Error',
        'Please enter a valid 4-digit email OTP.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Verify Phone OTP
    try {
      // final credential = PhoneAuthProvider.credential(
      //   verificationId: widget.verificationId,
      //   smsCode: phoneOtp,
      // );

      // final userCredential = await _auth.signInWithCredential(
      //   credential,
      // );

      // phoneOtpVerified = userCredential.user != null;
      // if (userCredential.user == null) {
      //   throw "Error Not Logged in user";
      // }
      // userCredential.user?.updatePhoneNumber(credential);
    } catch (e) {
      if (e is FirebaseAuthException) {
        log('Error during phone OTP verification: ${e.code} - ${e.message}');
      } else {
        log('General error during phone OTP verification: $e');
      }
      Get.snackbar(
        'Error',
        'Failed to verify phone OTP: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }

    // Verify Email OTP for login (Replace with appropriate API for login OTP verification)
    try {
      // final response = await ApiService.verifyEmailOTP(widget.email, otp);
      // otpVerified = response.success;

      // if (!otpVerified) {
      //   Get.snackbar(
      //     'Error',
      //     'Failed to verify email OTP: ${response.message}',
      //     snackPosition: SnackPosition.TOP,
      //     backgroundColor: Colors.red,
      //   );
      // }

      final response = await ApiService.sendRequest(ApiRoutes.verifyOtpUrl, {
        "email": Get.arguments['email'],
        "type": "email",
        "otp": otp,
      });

      log("Response: han han theek hai $response");
      if (response['status'] != 200) {
        Get.to(() => const ConfirmationPage());
        Get.snackbar(
          'successfully',
          'Your Email Otp verified but: $response',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
        );
        throw response['body'];
      }
    } catch (e) {
      log('Error during email OTP verification: approved karwa bhai  $e');
      Get.snackbar(
        'erro',
        'Failed to verify email OTP: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }

    // if (phoneOtpVerified) {
    //   // If phone OTP is verified, move to the next page for email OTP verification
    //   Get.to(() => const ConfirmationPage());
    // } else if (otpVerified) {
    //   // If email OTP is verified but phone OTP is not, display an error
    //   Get.snackbar(
    //     'Error',
    //     'Phone OTP verification is required.',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.red,
    //   );
    // } else {
    //   // If both OTPs are not verified, display an error
    //   Get.snackbar(
    //     'Error',
    //     'Both Phone and Email OTPs must be verified to proceed.',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.red,
    //   );
    // }


  // Check if either OTP is verified
    // if (phoneOtpVerified || emailOtpVerified) {
    //   Get.toNamed('/confirmation');
    // } else {
    //   Get.snackbar(
    //     'Error',
    //     'Both OTP verifications failed. Please try again.',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.red,
    //   );


   

    setState(() {
      isLoading = false;
    });
  }

  // Function to resend Phone OTP
  void _resendPhoneOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(
            'Error',
            'Failed to resend phone OTP: ${e.message}',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.snackbar(
            'Success',
            'Phone OTP resent successfully!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
          );

          setState(() {
            widget.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend phone OTP: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  // Function to resend Email OTP
  void _resendEmailOTP() async {
    try {
      final response = await ApiService.sendRequest(ApiRoutes.resendOtpUrl, {
        'email': Get.arguments['email'],
        'type': 'email',
      });

      if (response['status'] == 200) {
        Get.snackbar(
          'Success',
          'Email OTP resent successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          'Error',
          response['body'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend email OTP: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }
}



















// // ignore_for_file: must_be_immutable, library_private_types_in_public_api

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class OtpVerificationPage extends StatefulWidget {
//   final String phoneNo;
//   String verificationId;
//   final String email;

//   OtpVerificationPage({super.key, required this.phoneNo, required this.verificationId, required this.email});

//   @override
//   _OtpVerificationPageState createState() => _OtpVerificationPageState();
// }

// class _OtpVerificationPageState extends State<OtpVerificationPage> {
//   final TextEditingController otpController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     final arguments = Get.arguments;
//     if (arguments != null) {
//       widget.verificationId = arguments['verificationId'];
//       log('Received Verification ID: ${widget.verificationId}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         automaticallyImplyLeading: false,
//         // centerTitle: false,
//         title: const Text(
//           'OTP Verification',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 'Enter the OTP sent to \n+92 3314317076',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),

//               // OTP Input Field
//               TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                   LengthLimitingTextInputFormatter(6),
//                 ],
//                 decoration: InputDecoration(
//                   labelText: 'OTP',
//                   labelStyle: const TextStyle(color: Colors.white),
//                   hintText: 'Enter 6-digit OTP',
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[800],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 style: const TextStyle(color: Colors.white),
//               ),

//               const SizedBox(height: 10),

//               TextButton(
//                 onPressed: () {
//                   _resendOTP();
//                 },
//                 child: RichText(
//                   text: const TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Didn\'t receive the code? ',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Resend OTP',
//                         style: TextStyle(
//                           color: Color(0xFFD6B560),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               isLoading
//                   ? const CircularProgressIndicator(
//                       color: Color(0xFFD6B560),
//                     )
//                   : ElevatedButton(
//                       onPressed: () {
//                         _verifyOTP();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFD6B560),
//                         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Continue',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w900),
//                       ),
//                     ),

//               const SizedBox(height: 20),

//               const Text(
//                 'Try another way',
//                 style: TextStyle(
//                   color: Color(0xFFD6B560),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _verifyOTP() async {
//     String otp = otpController.text.trim();

//     if (otp.isEmpty || otp.length != 6) {
//       Get.snackbar(
//         'Error',
//         'Please enter a valid 6-digit OTP.',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red,
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       log('Verification ID: ${widget.verificationId}');
//       log('OTP Entered: $otp');

//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId,
//         smsCode: otp,
//       );

//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       log('User signed in: ${userCredential.user}');

//       if (userCredential.user != null) {
//         Get.snackbar(
//           'Success',
//           'Phone number verified successfully!',
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.green,
//         );
//         Get.toNamed('/confirmation');
//       }
//     } catch (e) {
//       log('Error during OTP verification: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to verify OTP: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void _resendOTP() async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: widget.phoneNo,
//         verificationCompleted: (PhoneAuthCredential credential) {

//         },
//         verificationFailed: (FirebaseAuthException e) {
//           Get.snackbar(
//             'Error',
//             'Failed to resend OTP: ${e.message}',
//             snackPosition: SnackPosition.TOP,
//             backgroundColor: Colors.red,
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Get.snackbar(
//             'Success',
//             'OTP resent successfully!',
//             snackPosition: SnackPosition.TOP,
//             backgroundColor: Colors.green,
//           );

//           setState(() {
//             widget.verificationId = verificationId;
//           });
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {

//         },
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to resend OTP: $e',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red,
//       );
//     }
//   }
// }
