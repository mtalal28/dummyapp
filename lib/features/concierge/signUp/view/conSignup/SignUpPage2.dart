// ignore_for_file: file_names

import 'dart:developer';

import 'package:easyrsv/services/ApiService.dart';
import 'package:easyrsv/features/concierge/authenction/controller/concierge_form.dart';
import 'package:easyrsv/appfeature/widget.dart/text_field_with_label.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage2 extends StatelessWidget {

  final ConciergeFormController controller = Get.find<ConciergeFormController>();

  final emailController = TextEditingController();

  final String phoneNo;
  final String email;

  SignUpPage2({super.key, required this.phoneNo, required this.email});

  final TextEditingController passwordController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController ConfirmpassController = TextEditingController();
  final TextEditingController banknameController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController cardholderController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance; 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            floating: true,
            pinned: true,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  // Password Field
                  TextFieldWithLabel(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter your Password',
                    isMandatory: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next, 
                    onChanged: (value) {
                      controller.password.value = value;
                    }, inputFormatters: const [],
                  ),

                  // Confirm Password Field
                  TextFieldWithLabel(
                    controller: ConfirmpassController,
                    label: 'Confirm Password',
                    hint: 'Enter your Confirm Password',
                    isMandatory: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next, 
                    onChanged: (value) =>
                        controller.confirmPassword.value = value, inputFormatters:const  [],
                  ),

                  const SizedBox(height: 30),

                  // Payment Preference Section
                  const Text(
                    'Payment Preference',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.selectedPayment.value = 'cash';
                        },
                        child: Obx(() => PaymentOption(
                              icon: Icons.money,
                              label: 'Cash',
                              isSelected:
                                  controller.selectedPayment.value == 'cash',
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectedPayment.value = 'Bank Transfer';
                        },
                        child: Obx(() => PaymentOption(
                              icon: Icons.credit_card,
                              label: 'Bank Transfer',
                              isSelected: controller.selectedPayment.value ==
                                  'Bank Transfer',
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Obx(() {
                    if (controller.selectedPayment.value == 'Bank Transfer') {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldWithLabel(
                            controller: banknameController,
                            label: 'Bank Name',
                            hint: 'Enter Your Bank Name',
                            isMandatory: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next, 
                            onChanged: (value) => controller.bank.value = value, 
                            inputFormatters: const [],
                          ),
                          TextFieldWithLabel(
                            controller: accountController,
                            label: 'Account / IBAN Number',
                            hint: 'Enter Your Account/IBAN Number',
                            isMandatory: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next, 
                            onChanged: (value) =>
                                controller.account.value = value, inputFormatters: const [],
                          ),
                          TextFieldWithLabel(
                            controller: cardholderController,
                            label: 'Card Holder Name',
                            hint: 'Enter the Card Holder Name',
                            isMandatory: true,
                            textInputAction: TextInputAction.next, 
                            keyboardType: TextInputType.text,
                            onChanged: (value) =>
                                controller.cardHolder.value = value, inputFormatters: const [],
                          ),
                          const SizedBox(height: 30),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  }),

                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                      
                        if (controller.isLoading.value) {
                          return const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFD6B560)),
                          );
                        } else {
                          return ElevatedButton(
                            onPressed: () {
                              _validateAndSubmitForm(); 
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD6B560),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 150),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Submit',
                                style: TextStyle(color: Colors.black)),
                          );
                        }
                      }),
                    ],
                  ),

                  const SizedBox(height: 30), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 
 Future<void> _validateAndSubmitForm() async {
    // Same validation logic as before
    String password = controller.password.value.trim();
    String confirmPassword = controller.confirmPassword.value.trim();
    String selectedPayment = controller.selectedPayment.value;

    if (password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both password and confirm password.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      return;
    } else if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      return;
    }

    if (selectedPayment.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a payment method.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      return;
    }

    if (selectedPayment == 'Bank Transfer') {
      String bank = controller.bank.value.trim();
      String account = controller.account.value.trim();
      String cardHolder = controller.cardHolder.value.trim();

      if (bank.isEmpty || account.isEmpty || cardHolder.isEmpty) {
        Get.snackbar(
          'Error',
          'Please fill in all bank-related fields.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
        return;
      }
    }

    controller.isLoading.value = true;

    var ctrl = Get.find<ConciergeFormController>();
    await ctrl.registerUser();


    await _sendEmailOTP();


    // Send OTP to phone number
    await _sendOTP();

  
  }

  Future<void> _sendOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          controller.isLoading.value = false;
        },
        verificationFailed: (FirebaseAuthException e) {
          controller.isLoading.value = false;
          Get.snackbar(
            'Error',
            'OTP verification failed: ${e.message}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
          );
        },
        
        codeSent: (String verificationId, int? resendToken) {
          log('vvvvvvvvvvvvv $verificationId');
          controller.isLoading.value = false;
          Get.toNamed('/OtpVerification', arguments: {
            'phoneNumber': phoneNo,
            'verificationId': verificationId,
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          controller.isLoading.value = false;
        },
      );
    } catch (e) {
      controller.isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to send OTP: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

 Future<void> _sendEmailOTP() async {
  try {
    final response = await ApiService.sendEmailOTP(email);
    if (response.success) {
      controller.isLoading.value = false;
      Get.toNamed('/OtpVerification', arguments: {'email': email});
    } else {
      controller.isLoading.value = false;
   
      if (response.message.contains("Account doesn't exist")) {
        Get.snackbar(
          'Error',
          'This email is not registered. Please check the email or register.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to send OTP to email: ${response.message}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
      log('${response.message} hehehe');
    }
  } catch (e) {
    controller.isLoading.value = false;
    Get.snackbar(
      'Error',
      'Failed to send OTP: $e',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
    );
    log('$e');
  }
}

}


// PaymentOption Widget
class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const PaymentOption({super.key, 
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[800] : Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? const Color(0xFFD6B560) : Colors.grey[700]!,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFD6B560),
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: const Color(0xFFD6B560),
          ),
        ],
      ),
    );
  }
}
