import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, 'signIn');
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
              padding: EdgeInsets.only(top: 50),
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
                    'EASYRSV', // Replace with your desired text
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFFD6B560),
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
