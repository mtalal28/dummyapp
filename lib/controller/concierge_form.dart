// // import 'package:get/get.dart';

// // class ConciergeFormController extends GetxController {
// //   var firstName = ''.obs;
// //   var familyName = ''.obs;
// //   var businessName = ''.obs;
// //   var emailAddress = ''.obs;
// //   var mobileNumber = ''.obs;
// //   var address = ''.obs;
// //   var referralCode = ''.obs;
// //   var selectedDate = ''.obs;

// //   void updateDate(String date) {
// //     selectedDate.value = date;
// //   }
// // }

// import 'package:get/get.dart';

// class ConciergeFormController extends GetxController {
//   var firstName = ''.obs;
//   var familyName = ''.obs;
//   var businessName = ''.obs;
//   var email = ''.obs;
//   var mobileNumber = ''.obs;
//   var address = ''.obs;
//   var referralCode = ''.obs;
//   var dateOfBirth = ''.obs;
//   var mobileCode =''.obs;
//    var Password =''.obs;
//    var ConfirmPassword =''.obs;
//    var selectedPayment = 'bank'.obs;
//    var Bank = ''.obs;
//    var Account = ''.obs;
//    var CradHolder = ''.obs;
//    var Country = ''.obs;
//    var Phoneno = ''.obs;
//    var location = ''.obs;
//    var City = ''.obs;
//    var State = ''.obs;

//   // Method to clear the form
//   void clearForm() {
//     firstName.value = '';
//     familyName.value = '';
//     businessName.value = '';
//     email.value = '';
//     mobileNumber.value = '';
//     address.value = '';
//     referralCode.value = '';
//     dateOfBirth.value = '';
//     selectedPayment.value = '';
//     Bank.value = ''.obs as String;
//     mobileCode.value='';
//     Password.value='';
//     ConfirmPassword.value='';
//      Country.value = ''.obs as String;
//    Phoneno.value = ''.obs as String;
//    location.value = ''.obs as String;
//     City.value = ''.obs as String;
//    State.value = ''.obs as String;

//   }
// }

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConciergeFormController extends GetxController {
  var isLoading = false.obs;

  var firstName = ''.obs;
  var lastName = ''.obs;
  var familyName = ''.obs;
  var businessName = ''.obs;
  var email = ''.obs;
  var mobileNumber = ''.obs;
  var address = ''.obs;
  var referralCode = ''.obs;
  var dob = ''.obs;
  var mobileCode = ''.obs;
  var type = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var selectedPayment = 'cash'.obs;
  var bank = ''.obs;
  var account = ''.obs;
  var cardHolder = ''.obs;
  var country = ''.obs;
  var phoneNo = ''.obs;
  var location_coordinates = ''.obs;
  var city = ''.obs;
  var state = ''.obs;

  final String apiUrl = 'http://conciergebooking.tijarah.ae/api/user/register';

  Future<void> registerUser() async {
    try {
      print('First Name: ${firstName.value}');
      print('First Name: ${lastName.value}');
      print('Family Name: ${familyName.value}');
      print('business name: ${businessName.value}');
      print('Email: ${email.value}');
      print('phone no: ${phoneNo.value}');
      print('mobile no: ${mobileNumber.value}');
      print('mobile code: ${mobileCode.value}');
      print('type : ${type.value}');
      print('dob: ${dob.value}');
      print('address: ${address.value}');
      print('referral code: ${referralCode.value}');
      print('country: ${country.value}');
      print('state: ${state.value}');
      print('city: ${city.value}');
      print('loaction: ${location_coordinates.value}');
      print('password: ${password.value}');
      print('confirm password: ${confirmPassword.value}');
      // print('bank name : ${bank.value}');
      print('account: ${account.value}');
      print('card holder: ${cardHolder.value}');
      print('select payment method: ${selectedPayment.value}');

      final response = await http.post(
        Uri.parse(apiUrl),
        body:
        {
    "first_name": firstName.value,
    "last_name": lastName.value,
    "family_name": familyName.value,
    "business_name": businessName.value,
    "email": email.value,
    "mobile_number": mobileNumber.value,
    "address": address.value,
    // "referral_code": "YourReferralCode",
    "dob": dob.value,
    "mobile_code": mobileCode.value,
    "type": type.value,
    "password": password.value,
    "password_confirmation": confirmPassword.value,
    "country": country.value,
    "phone_no": phoneNo.value,
    "location_coordinates": location_coordinates.value,
    "city": city.value,
    "state": state.value,
    // "bank": bank.value,
    // "account": account.value,
    // "cardholder": cardHolder.value,
    "payment_method": selectedPayment.value,
} 
        // {
        //   "first_name": firstName.value,
        //   "family_name": familyName.value,
        //   "business_name": businessName.value,
        //   "email": email.value,
        //   "mobile_number": mobileNumber.value,
        //   "address": address.value,
        //   "referral_code": referralCode.value,
        //   "date_of_birth": dateOfBirth.value,
        //   "mobile_code": mobileCode.value,
        //   "type": type.value,
        //   "password": password.value,
        //   "confirm_password": confirmPassword.value,
        //   "country": country.value,
        //   "phone_no": phoneNo.value,
        //   "location": location.value,
        //   "city": city.value,
        //   "state": state.value,
        //   "bank": bank.value,
        //   "account": account.value,
        //   "cardholder": cardHolder.value,
        // },
      );
    print('Response Status Code: ${response.statusCode}'); 
    print('Response Body: ${response.body}'); 

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == true) {
        Get.snackbar("Success", "Registration Successful!");
        clearForm();
      } else {
        Get.snackbar("Error", jsonResponse['message']);
      }
    } else {
      Get.snackbar("Error", "Failed to register. Status code: ${response.statusCode}, Response: ${response.body}");
    }
  } catch (error) {
    print('Error occurred: $error'); // Log the error
    Get.snackbar("Error", "An error occurred. Please try again.");
  }
}

  void clearForm() {
    firstName.value = '';
    familyName.value = '';
    businessName.value = '';
    email.value = '';
    mobileNumber.value = '';
    address.value = '';
    referralCode.value = '';
    dob.value = '';
    mobileCode.value = '';
    password.value = '';
    confirmPassword.value = '';
    country.value = '';
    phoneNo.value = '';
    location_coordinates.value = '';
    city.value = '';
    state.value = '';
  }
}
