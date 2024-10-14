// ignore_for_file: library_private_types_in_public_api

import 'package:easyrsv/controller/Forget_password_controller.dart';
import 'package:easyrsv/view/otp_vertication/ForgetVerification.dart';
import 'package:easyrsv/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final ForgetPasswordController controller = Get.put(ForgetPasswordController());
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false; // Track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30.0),
                const Row(
                  children: [
                    Text(
                      'Email Address ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 127, 126, 126),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '*', // Asterisk indicating required field
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ), // Red color for the asterisk
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  cursorColor: const Color(0xFFD6B560),
                  obscureText: false,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    controller.email.value = value;
                  },
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: isLoading ? null : () async { // Disable button while loading
                setState(() {
                  isLoading = true; // Show loader
                });

                String email = controller.email.value.trim();

                if (email.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please enter your email address.',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.black,
                    margin: const EdgeInsets.all(10),
                  );
                  setState(() {
                    isLoading = false; // Hide loader
                  });
                } else if (!GetUtils.isEmail(email)) {
                  Get.snackbar(
                    'Error',
                    'Please enter a valid email address.',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.black,
                    margin: const EdgeInsets.all(10),
                  );
                  setState(() {
                    isLoading = false; // Hide loader
                  });
                } else {
                  // Call API to send OTP for forgot password
                  final response = await ApiService.sendOtpForForgotPassword(email);

                  setState(() {
                    isLoading = false; // Hide loader
                  });

                  if (response.success) {
                    Get.snackbar(
                      'Success',
                      response.message,
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(10),
                    );
                    // Navigate to OTP Verification page
                    Get.to(() => ForgetOtpVerificationPage(email: email));
                  } else {
                    Get.snackbar(
                      'Error',
                      response.message,
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.black,
                      margin: const EdgeInsets.all(10),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD6B560),
                padding: const EdgeInsets.symmetric(
                  horizontal: 150.0,
                  vertical: 8.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black, // Color for the loader
                      ),
                    )
                  : const Text(
                      'Continue',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}



 
 
 
 
 // Verify Email OTP for password reset
    // try {
    //   final response = await ApiService.verifyOtpForgotPassword(widget.email, emailOtp);
    //   emailOtpVerified = response.success;

    //   if (emailOtpVerified) {
    //     Get.snackbar(
    //       'Success',
    //       'Email verified successfully! You can reset your password now.',
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: Colors.green,
    //     );
    //     // Navigate to password reset page
    //     Get.toNamed('/resetPassword', arguments: {'email': widget.email});
    //   } else {
    //     Get.snackbar(
    //       'Error',
    //       response.message,
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: Colors.red,
    //     );
    //   }
    // } catch (e) {
    //   log('Error during email OTP verification: $e');
    //   Get.snackbar(
    //     'Error',
    //     'Failed to verify email OTP: $e',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red,
    //   );
    // }

    
    // }
