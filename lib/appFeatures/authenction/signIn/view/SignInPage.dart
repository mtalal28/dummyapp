
import 'package:easyrsv/appFeatures/authenction/signIn/contoller/signin_controller.dart';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signinpage extends StatelessWidget {
  const Signinpage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Get.put(SignInController());

   
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo vector 2.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      'EASYRSV',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFD6B560),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 90),
              // Sign In Container
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF282828),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Text(
                          'Email Address ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 146, 143, 143),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    // Email TextField
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: const Color(0xFFD6B560),
                            decoration: InputDecoration(
                              hintText: 'Enter your email address',
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 146, 143, 143),
                              ),
                              filled: true,
                              fillColor: const Color(0xFF4e4e4e),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          'Password ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 127, 126, 126),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    // Password TextField
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => TextField(
                              controller: passwordController,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: const Color(0xFFD6B560),
                              obscureText: signInController.obscureText
                                  .value, // Updates based on obscureText
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 127, 126, 126),
                                  fontFamily: 'Inter',
                                ),
                                filled: true,
                                fillColor: const Color(0xFF4e4e4e),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    signInController.obscureText.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xFFD6B560),
                                  ),
                                  onPressed: signInController
                                      .toggleObscureText, // Toggles obscureText
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Get.toNamed('forgot');
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Color(0xFFD6B560),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        return ElevatedButton(
                          onPressed: signInController.isLoading.value
                              ? null 
                              : () {
                                  signInController.signIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD6B560),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: signInController.isLoading.value
                              ? const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFFD6B560)),
                                    strokeWidth: 3.0,
                                  ),
                                )
                              : const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 90),
            
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white),
                    children: <TextSpan>[
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Color(0xFFD6B560),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed('/signup');
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
