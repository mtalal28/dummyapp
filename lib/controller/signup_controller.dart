import 'package:get/get.dart';

class SignupController extends GetxController {
  var isOption1Selected = false.obs; // Observable for Option 1
  var isOption2Selected = false.obs; // Observable for Option 2

  void selectOption1() {
    isOption1Selected.value = true;
    isOption2Selected.value = false;
  }

  void selectOption2() {
    isOption1Selected.value = false;
    isOption2Selected.value = true;
  }
}