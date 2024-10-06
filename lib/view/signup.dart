import 'package:easyrsv/controller/signup_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX


class Signup extends StatelessWidget {
  Signup({super.key});
  final SignupController controller = Get.put(SignupController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF282828),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Center(
                      child: Text(
                        'Select Your Role',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Center(
                      child: Text(
                        'Are You A Hotel Manager or \nRestaurant Owner',
                        style: TextStyle(
                            color: Color.fromARGB(255, 190, 188, 188)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: controller.selectOption1,
                          child: Obx(() => Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4e4e4e),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.isOption1Selected.value
                                        ? const Color(0xFFD6B560)
                                        : Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/Mask group.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Restaurant',
                                      style: TextStyle(
                                        color: controller.isOption1Selected
                                                .value
                                            ? const Color(0xFFD6B560)
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: controller.selectOption2,
                          child: Obx(() => Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4e4e4e),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: controller.isOption2Selected.value
                                        ? const Color(0xFFD6B560)
                                        : Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/Mask group Con.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Concierge',
                                      style: TextStyle(
                                        color: controller.isOption2Selected
                                                .value
                                            ? const Color(0xFFD6B560)
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.isOption1Selected.value) {
                            Get.toNamed('restaurantPage');
                          } else if (controller.isOption2Selected.value) {
                            Get.toNamed('conciergePage');
                          } else {
                            Get.snackbar(
                              'Error',
                              'Please select a role before proceeding.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6B560),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Next',
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
              const SizedBox(height: 120),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "Already have an account? ",
                      ),
                      TextSpan(
                        text: 'Log In',
                        style: const TextStyle(
                          color: Color(0xFFD6B560),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed('signIn');
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
