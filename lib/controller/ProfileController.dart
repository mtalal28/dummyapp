import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var isLoading = false.obs;

  // Observable variables for profile information
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var mobileNumber = ''.obs;
  var dob = ''.obs;
  var mobileCode = ''.obs;
  var businessName = ''.obs;
  var bank = ''.obs;
  var account = ''.obs;
  var cardHolder = ''.obs;

  
  final String apiUrl = 'https://conciergebooking.tijarah.ae/api/update-profile';

  Future<void> updateProfile() async {
    try {
     
      final payload = {
        "first_name": firstName.value,
        "last_name": lastName.value,
        "email": email.value,
        "mobile_number": mobileNumber.value,
        
        "dob": dob.value,
        "mobile_code": mobileCode.value,
       
        "business_name": businessName.value,
        "bank_name": bank.value,
        "account": account.value,
        "card_holder_name": cardHolder.value,
        
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN', // Replace with your actual token
        },
        body: jsonEncode(payload),
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == true) {
          Get.snackbar("Success", "Profile updated successfully!");
          clearForm(); // Clear the form after successful update
        } else {
          Get.snackbar("Error", jsonResponse['message']);
        }
      } else {
        Get.snackbar("Error",
            "Failed to update profile. Status code: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (error) {
      log('Error occurred: $error'); // Log the error
      Get.snackbar("Error", "An error occurred. Please try again.");
    }
  }

  // Method to clear the form
  void clearForm() {
    firstName.value = '';
    lastName.value = '';
    email.value = '';
    mobileNumber.value = '';
    
    dob.value = '';
    mobileCode.value = '';
    businessName.value = '';
    bank.value = '';
    account.value = '';
    cardHolder.value = '';
  }
}
