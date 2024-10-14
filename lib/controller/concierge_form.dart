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

// import 'dart:math';

import 'dart:developer';

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
  // ignore: non_constant_identifier_names
  var location_coordinates = ''.obs;
  var city = ''.obs;
  var state = ''.obs;

  final String apiUrl = 'http://conciergebooking.tijarah.ae/api/user/register';

  Future<void> registerUser() async {
    try {
      log('First Name: ${firstName.value}');
      log('Last Name: ${lastName.value}');
      log('Family Name: ${familyName.value}');
      log('Business Name: ${businessName.value}');
      log('Email: ${email.value}');
      log('Phone No: ${phoneNo.value}');
      log('Mobile No: ${mobileNumber.value}');
      log('Mobile Code: ${mobileCode.value}');
      log('Type: ${type.value}');
      log('DOB: ${dob.value}');
      log('Address: ${address.value}');
      log('Referral Code: ${referralCode.value}');
      log('Country: ${country.value}');
      log('State: ${state.value}');
      log('City: ${city.value}');
      log('Location: ${location_coordinates.value}');
      log('Password: ${password.value}');
      log('Confirm Password: ${confirmPassword.value}');
// log('Bank Name: ${bank.value}');
      log('Account: ${account.value}');
      log('Card Holder: ${cardHolder.value}');
      log('Selected Payment Method: ${selectedPayment.value}');

      final response = await http.post(Uri.parse(apiUrl), body: {
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
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          Get.snackbar("Success", "Registration Successful!");
          clearForm();
        } else {
          Get.snackbar("Error", jsonResponse['message']);
        }
      } else {
        Get.snackbar("Error",
            "Failed to register. Status code: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (error) {
      log('Error occurred: $error'); // Log the error
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
