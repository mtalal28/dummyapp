import 'dart:developer';

import 'package:easyrsv/features/admin/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxService {
  final user = Rx<UserModel?>(null);

  void setUser(UserModel newUser) {
    log(newUser.toString());

    if (newUser != user.value) {
      return;
    }
    user.value = newUser;
  }
}
