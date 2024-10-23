import 'package:easyrsv/services/ApiService.dart';
import 'package:get/get.dart';


class UpdateController extends GetxController {
  RxBool isLoading = false.obs;
  

  
  Future<void> approveUser(int userId, double commissionPercentage) async {
    isLoading.value = true;

    
    ApiResponse apiResponse = await ApiService.approveuser(userId, commissionPercentage);

    isLoading.value = false;

    if (apiResponse.success) {
      Get.snackbar('Success', apiResponse.message);
    } else {
      Get.snackbar('Error', apiResponse.message);
    }
  }
}
