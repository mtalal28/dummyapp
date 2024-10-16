import 'package:get/get.dart';

class SignupController extends GetxController {
  var isOption1Selected = false.obs; 
  var isOption2Selected = false.obs; 

  void selectOption1() {
    isOption1Selected.value = true;
    isOption2Selected.value = false;
  }

  void selectOption2() {
    isOption1Selected.value = false;
    isOption2Selected.value = true;
  }
}