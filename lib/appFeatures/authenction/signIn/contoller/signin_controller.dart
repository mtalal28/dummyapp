// import 'dart:developer';

// import 'package:easyrsv/services/ApiService.dart';
// import 'package:get/get.dart';


// class SignInController extends GetxController {
//   var isLoading = false.obs;
//   var obscureText = true.obs;

//   void toggleObscureText() {
//     obscureText.value = !obscureText.value;
//   }

//   Future<void> signIn(String email, String password) async {
//     isLoading.value = true;

    
//     final response = await ApiService.loginemail(email, password);

//     if (response.success) {
      
//       log('User ID: ${response.id}');
//       log('Token: ${response.token}');

//       Get.offNamed('admin');
//     } else {
     
//       Get.snackbar('Login Failed', response.message);
//     }

//     isLoading.value = false;
//   }
// }



import 'dart:developer';

import 'package:easyrsv/services/ApiService.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  RxBool isLoading = false.obs;
  var obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;

    final response = await ApiService.loginemail(email, password);

    if (response.success) {
      log('User ID: ${response.id}');
      log('Token: ${response.token}');

      
      SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setString('user_token', response.token ?? '');
      
      Get.offNamed('admin');
      log('Authorization Token: ${response.token}');

    } else {
      Get.snackbar('Login Failed', response.message);
    }

    isLoading.value = false;
  }
}


