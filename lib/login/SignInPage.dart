
import 'package:easyrsv/controller/signin%20_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find();

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
                      width: 150,
                      height: 150,
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Email TextField
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) => controller.email.value = value,
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
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Text(
                          'Password ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 127, 126, 126),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Password TextField
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => TextField(
                              onChanged: (value) => controller.password.value = value,
                              obscureText: controller.obscureText.value,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 127, 126, 126),
                                    fontFamily: 'Inter'),
                                filled: true,
                                fillColor: const Color(0xFF4e4e4e),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.obscureText.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xFFD6B560),
                                  ),
                                  onPressed: controller.toggleObscureText,
                                ),
                              ),
                              cursorColor: Colors.white,
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
                            Get.toNamed('resetpass');
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Color(0xFFD6B560),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.signIn, // Trigger the sign-in action
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6B560),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 90),
              // "Don't have an account?" RichText
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
