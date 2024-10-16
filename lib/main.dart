import 'package:easyrsv/features/concierge/signUp/view/forgetpassword/PasswordConfirmationPage.dart';
import 'package:easyrsv/features/concierge/signUp/view/forgetpassword/forget_password.dart';
import 'package:easyrsv/features/admin/view/AdminDashboardPage.dart';
import 'package:easyrsv/features/concierge/authenction/view/confirmation.dart';
import 'package:easyrsv/appfeature/Authentication/signUp/view/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easyrsv/features/concierge/signUp/view/otp_vertication/OtpVerification.dart';
import 'package:easyrsv/features/concierge/signUp/view/forgetpassword/Reset.dart';
import 'package:easyrsv/features/concierge/signUp/view/conSignup/SignUpPage2.dart';
import 'package:easyrsv/appfeature/SplashScreen.dart';
import 'package:easyrsv/features/concierge/signUp/view/conSignup/conciergePage.dart';
import 'package:easyrsv/appfeature/Authentication/signIn/controller/signin_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appfeature/Authentication/signIn/view/SignInPage.dart';

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
