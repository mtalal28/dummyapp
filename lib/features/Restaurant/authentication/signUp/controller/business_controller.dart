import 'package:easyrsv/features/Restaurant/authentication/signUp/model/business_model.dart';
import 'package:get/get.dart';


class BusinessController extends GetxController {
  
  var address = const AddressModel(
    country: '',
    state: '',
    city: '',
    location: '',
    address: '',
  ).obs;
  
  var businessName = ''.obs;
  var category = ''.obs;
  var contactPerson =  ContactPersonModel(name: '', mainPointOfContact: '').obs;
  var emailAddress = ''.obs;
  var phone = const PhoneModel(number: '', code: '').obs;
  var mobile = const PhoneModel(number: '', code: '').obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var tradeLicenseFile = ''.obs;
  var referralCode = ''.obs;

   var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  void setBusinessData({
    required AddressModel address,
    required String businessName,
    required String category,
    required ContactPersonModel contactPerson,
    required String emailAddress,
    required PhoneModel phone,
    required PhoneModel mobile,
    required String password,
    required String confirmPassword,
    required String tradeLicenseFile,
    String? referralCode,
  }) {
    this.address.value = address;
    this.businessName.value = businessName;
    this.category.value = category;
    this.contactPerson.value = contactPerson;
    this.emailAddress.value = emailAddress;
    this.phone.value = phone;
    this.mobile.value = mobile;
    this.password.value = password;
    this.confirmPassword.value = confirmPassword;
    this.tradeLicenseFile.value = tradeLicenseFile;
    this.referralCode.value = referralCode ?? '';
  }

 
  bool validateForm() {
    if (businessName.value.isEmpty ||
        category.value.isEmpty ||
        contactPerson.value.name.isEmpty ||
        emailAddress.value.isEmpty ||
        phone.value.number.isEmpty ||
        mobile.value.number.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty ||
        tradeLicenseFile.value.isEmpty) {
      return false;
    }
    return true;
  }
}
