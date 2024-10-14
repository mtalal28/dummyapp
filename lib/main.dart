import 'package:easyrsv/view/forgetpassword/PasswordConfirmationPage.dart';
import 'package:easyrsv/view/forgetpassword/forget_password.dart';
import 'package:easyrsv/view/login/AdminDashboardPage.dart';
import 'package:easyrsv/view/login/confirmation.dart';
import 'package:easyrsv/view/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easyrsv/view/otp_vertication/OtpVerification.dart';
import 'package:easyrsv/view/forgetpassword/Reset.dart';
import 'package:easyrsv/view/concierge/SignUpPage2.dart';
import 'package:easyrsv/view/SplashScreen.dart';
import 'package:easyrsv/view/concierge/conciergePage.dart';
import 'package:easyrsv/controller/signin%20_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/login/SignInPage.dart';

void main() async {

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
 SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('user_token');

  
  String initialRoute = (token != null && token.isNotEmpty) ? 'admin' : 'first';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        'first': (context) => const SplashScreen(),
        'signIn': (context) => const SignInPage(),
        '/signup': (context) => Signup(),
         'forgot':(context)=> const ForgetPasswordPage(),
        'resetpass': (context) => const ResetPasswordPage(),
        'conciergePage': (context) => const ConciergePage(),
        '/SignUpPage2': (context) => SignUpPage2(phoneNo: '', email: '',),
        '/OtpVerification': (context) =>
            OtpVerificationPage(verificationId: '', phoneNo: '', email:''),
         '/confirmation':(context) => const ConfirmationPage(), 
         'passConfirm':(context)=> const PasswordConfirmationPage(),
         'admin': (context) => const AdminDashboardPage(),
         
       
      },
    );
  }
}
