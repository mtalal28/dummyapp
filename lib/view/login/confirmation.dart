import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
         
          Padding(
            padding: const EdgeInsets.only(top: 200), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/confirmation.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Congratulations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your account has been \n successfully created!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
         
          Padding(
            padding: const EdgeInsets.only(bottom: 30), 
            child: Center( 
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('signIn'); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6B560),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 130),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Login Now',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
