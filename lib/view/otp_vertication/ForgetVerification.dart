// ignore_for_file: file_names

import 'package:easyrsv/view/forgetpassword/Reset.dart';
import 'package:easyrsv/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetOtpVerificationPage extends StatelessWidget {
  final String email;
  final TextEditingController otpController = TextEditingController();

  ForgetOtpVerificationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.black,
        title: const Text('Verify OTP', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox()), 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter the OTP sent to your email',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: otpController,
                  maxLength: 4, 
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
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
                    counterText: "",
                  ),
                  cursorColor: const Color(0xFFD6B560), 
                ),
              ],
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()), // Spacer after the input field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: ElevatedButton(
              onPressed: () async {
                String otp = otpController.text.trim();
                if (otp.isEmpty || otp.length != 4) {
                  Get.snackbar(
                    'Error',
                    'Please enter a 4-digit OTP.',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.black,
                  );
                } else {
                  // Call API to verify OTP
                  final response = await ApiService.verifyOtpForgotPassword(email, otp);
                  
                  if (response.success) {
                    Get.snackbar(
                      'Success', 
                      response.message,
                      snackPosition: SnackPosition.TOP, 
                      backgroundColor: Colors.green, 
                      colorText: Colors.white,
                    );
                    // Navigate to Reset Password page
                    Get.to(() => const ResetPasswordPage());
                  } else {
                    Get.snackbar(
                      'Error', 
                      response.message,
                      snackPosition: SnackPosition.TOP, 
                      backgroundColor: Colors.red, 
                      colorText: Colors.white,
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color(0xFFD6B560),
                padding: const EdgeInsets.symmetric(vertical: 5.0), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
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
