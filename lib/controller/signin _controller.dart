// sign_in_controller.dart

import 'package:get/get.dart';

class SignInController extends GetxController {
  // Observables
  var email = ''.obs;
  var password = ''.obs;
  var obscureText = true.obs; // To manage password visibility

  // Toggle password visibility
  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  // Function for signing in (Add actual logic)
  void signIn() {
    // Perform sign-in operation here, using email.value and password.value
    print('Email: ${email.value}, Password: ${password.value}');
  }
}
