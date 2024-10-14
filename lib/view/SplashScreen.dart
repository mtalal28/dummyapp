
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Using GetX for navigation
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed('signIn'); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      color:  Color(0xFFD6B560),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
