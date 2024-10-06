import 'dart:core';

import 'package:easyrsv/concierge/SignUpPage2.dart';
import 'package:easyrsv/controller/concierge_form.dart';
import 'package:easyrsv/widget.dart/autospacing.dart';
import 'package:easyrsv/widget.dart/text_field_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

// import 'package:firebase_auth/firebase_auth.dart';
class ConciergePage extends StatefulWidget {
  const ConciergePage({super.key});

  @override
  State<ConciergePage> createState() => _ConciergePageState();
}

class _ConciergePageState extends State<ConciergePage> {
  final ConciergeFormController controller = Get.put(ConciergeFormController());

  final TextEditingController fnameController = TextEditingController();

  final TextEditingController lnameController = TextEditingController();

  final TextEditingController familyController = TextEditingController();

  final TextEditingController businessController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController typeController = TextEditingController();

  final TextEditingController mobilecodeController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController referralController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController location_coordinatesController = TextEditingController();

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            floating: true,
            pinned: true,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Input fields with their respective controllers
                  TextFieldWithLabel(
                    controller: fnameController,
                    label: 'First Name',
                    hint: 'Enter your first name',
                    isMandatory: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.firstName.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: lnameController,
                    label: 'last Name',
                    hint: 'Enter your last name',
                    isMandatory: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.lastName.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: familyController,
                    label: 'Family Name',
                    hint: 'Enter your family name',
                    isMandatory: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.familyName.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: businessController,
                    label: 'Business Name',
                    hint: 'Enter your business name',
                    isMandatory: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.businessName.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: emailController,
                    label: 'Email Address',
                    hint: 'Enter your email address',
                    isMandatory: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => controller.email.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: phoneController,
                    label: 'Phone',
                    hint: '+92xxxxxxxxxx',
                    isMandatory: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      AutoSpacingPhoneNumberFormatter(),  
                    ],
                    onChanged: (value) => controller.phoneNo.value = value,
                  ),

                  TextFieldWithLabel(
                    controller: mobileNumberController,
                    label: 'Mobile Number',
                    hint: '+92xxxxxxxxxx',
                    isMandatory: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      AutoSpacingPhoneNumberFormatter(),  
                    ],
                    onChanged: (value) => controller.mobileNumber.value = value,
                  ),

                  TextFieldWithLabel(
                    controller: mobilecodeController,
                    label: 'Mobile Code',
                    hint: 'Enter your Mobile Code',
                    isMandatory: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => controller.mobileCode.value = value,
                  ),

                  TextFieldWithLabel(
                    controller: typeController,
                    label: 'Type 0 for con 1 for res',
                    hint: 'Enter your Type',
                    isMandatory: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => controller.type.value = value,
                  ),
                  DateFieldWithIcon(
                    controller: dobController,
                    label: 'Date of Birth',
                    hint: 'Select your date of birth',
                    isMandatory: true,
                    onDateSelected: (date) {
                      controller.dob.value = date.toString();
                    },
                    onChanged: (value) => controller.dob.value = value,
                  ),
                  TextFieldWithLabel(
                    controller: addressController,
                    label: 'Address',
                    hint: 'Enter your address',
                    isMandatory: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.address.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: referralController,
                    label: 'Referral Code',
                    hint: 'Enter your referral code',
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.referralCode.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: countryController,
                    label: 'Country',
                    hint: 'Enter your Country',
                    textInputAction: TextInputAction.next,
                    isMandatory: true,
                    onChanged: (value) => controller.country.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: stateController,
                    label: 'State',
                    hint: 'Enter your State name',
                    textInputAction: TextInputAction.next,
                    isMandatory: true,
                    onChanged: (value) => controller.state.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: cityController,
                    label: 'City Name',
                    hint: 'Enter your City name',
                    isMandatory: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.city.value = value,
                    inputFormatters: [],
                  ),
                  TextFieldWithLabel(
                    controller: location_coordinatesController,
                    label: 'Location',
                    hint: 'Enter your location',
                    isMandatory: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.location_coordinates.value = value,
                    inputFormatters: [],
                  ),

                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateFields()) {
                          Get.to(() =>
                              SignUpPage2(phoneNo: controller.phoneNo.value, email:controller.email.value));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD6B560),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 160),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Validation method for mandatory fields and format checks
  bool _validateFields() {

    if (controller.firstName.value.isEmpty ||
         controller.lastName.value.isEmpty ||
        controller.familyName.value.isEmpty ||
        controller.businessName.value.isEmpty ||
        controller.email.value.isEmpty ||
        controller.mobileNumber.value.isEmpty ||
        controller.mobileCode.value.isEmpty ||
        controller.referralCode.value.isEmpty ||
        controller.type.value.isEmpty ||
        controller.dob.value.isEmpty ||
        controller.address.value.isEmpty ||
        controller.country.value.isEmpty ||
        controller.state.value.isEmpty ||
        controller.city.value.isEmpty ||
        controller.location_coordinates.value.isEmpty ||
        controller.phoneNo.value.isEmpty) {
      Get.snackbar('Error', 'Please fill in all mandatory fields.',
          backgroundColor: Colors.red);
      return false;
    }

    // Validate email format
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(emailPattern).hasMatch(controller.email.value)) {
      Get.snackbar('Error', 'Please enter a valid email address.',
          backgroundColor: Colors.red);
      return false;
    }


    if (!RegExp(r'^\+92 \d{3} \d{3} \d{4}$')
        .hasMatch(controller.mobileNumber.value)) {
      Get.snackbar(
        'Error',
        'Mobile Number must be in the format +92 XXX XXX XXXX (16 characters total including spaces).',
        backgroundColor: Colors.red,
      );
      return false;
    }


    if (!RegExp(r'^\+92 \d{3} \d{3} \d{4}$')
        .hasMatch(controller.phoneNo.value)) {
      Get.snackbar(
        'Error',
        'Phone Number must be in the format +92 XXX XXX XXXX (16 characters total including spaces).',
        backgroundColor: Colors.red,
      );
      return false;
    }

    try {
      final dob = DateTime.parse(controller.dob.value);
      final now = DateTime.now();
      final age = now.year - dob.year;
      if (age < 18 ||
          (age == 18 && now.isBefore(dob.add(Duration(days: age * 365))))) {
        Get.snackbar('Error', 'You must be at least 18 years old.',
            backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Please enter a valid date of birth.',
          backgroundColor: Colors.red);
      return false;
    }

    return true;
  }
}

// bool _validateFields() {
//   // Check for required fields
//   if (controller.firstName.value.isEmpty ||
//       controller.familyName.value.isEmpty ||
//       controller.businessName.value.isEmpty ||
//       controller.email.value.isEmpty ||
//       controller.mobileNumber.value.isEmpty ||
//       controller.mobileCode.value.isEmpty ||
//       controller.type.value.isEmpty ||
//       controller.dateOfBirth.value.isEmpty ||
//       controller.address.value.isEmpty ||
//       controller.country.value.isEmpty ||
//       controller.state.value.isEmpty ||
//       controller.city.value.isEmpty ||
//       controller.location.value.isEmpty ||
//       controller.phoneNo.value.isEmpty) {
//     Get.snackbar('Error', 'Please fill in all mandatory fields.', backgroundColor: Colors.red);
//     return false;
//   }

//   // Validate email format
//   if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(controller.email.value)) {
//     Get.snackbar('Error', 'Please enter a valid email address.', backgroundColor: Colors.red);
//     return false;
//   }

//   // Validate mobile number (must be 11 digits)
//   if (controller.mobileNumber.value.length != 11) {
//     Get.snackbar('Error', 'Mobile Number must be exactly 11 digits.', backgroundColor: Colors.red);
//     return false;
//   }

//   // Validate phone number (must be 11 digits)
//   if (controller.phoneNo.value.length != 11) {
//     Get.snackbar('Error', 'Phone Number must be exactly 11 digits.', backgroundColor: Colors.red);
//     return false;
//   }

//   return true;
// }


class DateFieldWithIcon extends StatefulWidget {
  final String label;
  final String hint;
  final bool isMandatory;
  final Function(DateTime) onDateSelected;
  final void Function(String)? onChanged;

  const DateFieldWithIcon({
    Key? key,
    required this.label,
    required this.hint,
    this.isMandatory = false,
    required this.onDateSelected,
    this.onChanged,
    required TextEditingController controller,
  }) : super(key: key);

  @override
  _DateFieldWithIconState createState() => _DateFieldWithIconState();
}

class _DateFieldWithIconState extends State<DateFieldWithIcon> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: const TextStyle(color: Colors.white),
            ),
            if (widget.isMandatory)
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(() {
                selectedDate = date; 
              });
              widget.onDateSelected(date); 
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : widget.hint,
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
