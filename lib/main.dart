import 'package:easyrsv/login/confirmation.dart';
import 'package:easyrsv/view/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easyrsv/concierge/OtpVerification.dart';
import 'package:easyrsv/view/Reset.dart';
import 'package:easyrsv/concierge/SignUpPage2.dart';
import 'package:easyrsv/view/SplashScreen.dart';
import 'package:easyrsv/concierge/conciergePage.dart';
import 'package:easyrsv/controller/signin%20_controller.dart';
import 'login/SignInPage.dart';

void main() async {
  // Ensures that Firebase is initialized correctly
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDfKiW9-yY6_0g96GdYZilV45x0NK8tSwc",
       appId: "1:324883046691:android:4c698785002e902b1fec96",
        messagingSenderId: "324883046691",
         projectId: "easyrsv-a11f9"
         )
  ); 

  Get.put(SignInController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     theme: ThemeData(
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          // dayStyle: TextStyle(color: Colors.white), 
          // headerHelpStyle: TextStyle(color: Colors.white), 
        
          // yearStyle: TextStyle(color: Colors.white), 
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'first',
      routes: {
        'first': (context) => const SplashScreen(),
        'signIn': (context) => const SignInPage(),
        '/signup': (context) => Signup(),
        'resetpass': (context) => const ResetPasswordPage(),
        'conciergePage': (context) => ConciergePage(),
        '/SignUpPage2': (context) => SignUpPage2(phoneNo: '',email: '',),
        '/OtpVerification': (context) =>
            OtpVerificationPage(verificationId: '', phoneNo: '', email:''),
         '/confirmation':(context) => const ConfirmationPage(), 
      },
    );
  }
}
