// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:easyrsv/appFeatures/widget.dart/text_field_with_label.dart';
import 'package:easyrsv/features/Restaurant/authentication/signUp/controller/business_controller.dart';
import 'package:easyrsv/features/Restaurant/authentication/signUp/model/business_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// // Custom TextField with Label and Hint styled like the image
// class TextFieldWithLabel extends StatelessWidget {
//   final String label;
//   final String hint;
//   final bool isMandatory;
//   final ValueChanged<String> onChanged;
//   final bool obscureText;
//   final TextEditingController controller;
//   final TextInputType keyboardType;

//   const TextFieldWithLabel({
//     Key? key,
//     required this.label,
//     required this.hint,
//     required this.onChanged,
//     this.isMandatory = false,
//     this.obscureText = false,
//     required this.controller,
//     required this.keyboardType,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label + (isMandatory ? ' *' : ''),
//           style: const TextStyle(color: Colors.white, fontSize: 10),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           keyboardType: keyboardType,
//           onChanged: onChanged,
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
//             filled: true,
//             fillColor: const Color(0xFF2A2A2A),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide.none,
//             ),
//           ),
//           style: const TextStyle(color: Colors.grey),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

// class DropdownTextField<T> extends StatelessWidget {
//   final T? value;
//   final String label;
//   final String hint;
//   final List<T> items;
//   final ValueChanged<T?>? onChanged;
//   final Color fillColor;
//   final TextStyle textStyle;

//   const DropdownTextField({
//     Key? key,
//     required this.value,
//     required this.label,
//     required this.hint,
//     required this.items,
//     this.onChanged,
//     this.fillColor = const Color(0xFF2A2A2A),
//     this.textStyle = const TextStyle(color: Colors.white),
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: label,
//             style: const TextStyle(fontSize: 12, color: Colors.grey),
//             children: const [
//               TextSpan(
//                 text: ' *',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 4),
//         InputDecorator(
//           decoration: InputDecoration(
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
//             hintText: hint,
//             filled: true,
//             fillColor: fillColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide.none,
//             ),
//             suffixIcon:
//                 const Icon(Icons.arrow_drop_down, color: Colors.white60),
//           ),
//           child: DropdownButtonHideUnderline(
//               child: DropdownButton<T>(
//             value: value,
//             onChanged: onChanged,
//             items: items
//                 .map((item) => DropdownMenuItem<T>(
//                       value: item,
//                       child: Text(
//                         item.toString(),
//                         style: textStyle,
//                       ),
//                     ))
//                 .toList(),
//             isExpanded: true,
//             iconEnabledColor: Colors.transparent,
//           )),
//         ),
//       ],
//     );
//   }
// }

class BusinessSignUpPage extends StatefulWidget {

  const BusinessSignUpPage({super.key});

  @override
  State<BusinessSignUpPage> createState() => _BusinessSignUpPageState();
}

class _BusinessSignUpPageState extends State<BusinessSignUpPage> {
  final BusinessController controller = Get.put(BusinessController());
 String? uploadedFilePath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        uploadedFilePath = result.files.single.path; // Store the file path
      });
      log('Selected file: $uploadedFilePath');
    } else {
      log('No file selected.');
    }
  }

  void _removeFile() {
    setState(() {
      uploadedFilePath = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Sign up', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              controller:
                  TextEditingController(text: controller.businessName.value),
              label: 'Business Name',
              hint: 'Enter business name',
              isMandatory: true,
              onChanged: (value) => controller.businessName.value = value,
              keyboardType: TextInputType.text,
            ),
            // DropdownTextField<String>(
            //   value: controller.category.value.isNotEmpty
            //       ? controller.category.value
            //       : null,
            //   label: 'Select Category',
            //   hint: 'Please select a category',
            //   items: ['Category 1', 'Category 2', 'Category 3'],
            //   onChanged: (value) {
            //     if (value != null) {
            //       controller.category.value = value;
            //     }
            //   },
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Select an Category ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: null,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF2A2A2A),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: Colors.grey[800],
                  hint: const Text(
                    "Select your category",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  items: List.generate(
                    3,
                    (index) => DropdownMenuItem(
                      value: index,
                      child: Text(
                        "$index value",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            TextFieldWithLabel(
              controller: TextEditingController(
                  text: controller.contactPerson.value.name),
              label: 'Contact Person',
              hint: 'Enter contact person',
              isMandatory: true,
              onChanged: (value) => controller.contactPerson.update((val) {
                val?.name = value;
              }),
              keyboardType: TextInputType.number,
            ),

            TextFieldWithLabel(
              controller: TextEditingController(
                  text: controller.contactPerson.value.mainPointOfContact),
              label: 'Main Point of Contact',
              hint: 'Main point of contact',
              isMandatory: true,
              onChanged: (value) => controller.contactPerson.update((val) {
                val?.mainPointOfContact = value;
              }),
              keyboardType: TextInputType.text,
            ),

            TextFieldWithLabel(
              controller:
                  TextEditingController(text: controller.emailAddress.value),
              label: 'Email Address',
              hint: 'Enter your email address',
              isMandatory: true,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => controller.emailAddress.value = value,
            ),

            TextFieldWithLabel(
              controller:
                  TextEditingController(text: controller.phone.value.number),
              label: 'Phone Number',
              hint: 'Enter your phone number',
              isMandatory: true,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                controller.phone.update((val) {
                  if (val != null) {
                    controller.phone.value = val.copyWith(number: value);
                  }
                });
              },
            ),

            TextFieldWithLabel(
              controller:
                  TextEditingController(text: controller.mobile.value.number),
              label: 'Mobile Number',
              hint: 'Enter mobile number',
              isMandatory: true,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                controller.mobile.update((val) {
                  if (val != null) {
                    controller.mobile.value = val.copyWith(number: value);
                  }
                });
              },
            ),

            TextFieldWithLabel(
              controller: TextEditingController(
                  text: controller.address.value.toString()),
              label: 'Address',
              hint: 'Please choose address',
              isMandatory: true,
              onChanged: (value) =>
                  controller.address.value = value as AddressModel,
              keyboardType: TextInputType.text,
            ),

            Obx(() => TextFieldWithLabel(
                  controller:
                      TextEditingController(text: controller.password.value),
                  label: 'Password',
                  hint: 'Enter your password',
                  isMandatory: true,
                  onChanged: (value) => controller.password.value = value,
                  keyboardType: TextInputType.text,
                )),
            const SizedBox(height: 1),

            Obx(() => TextFieldWithLabel(
                  controller: TextEditingController(
                      text: controller.confirmPassword.value),
                  label: 'Confirm Password',
                  hint: 'Enter your confirm password',
                  isMandatory: true,
                  onChanged: (value) =>
                      controller.confirmPassword.value = value,
                  keyboardType: TextInputType.text,
                )),
            const SizedBox(height: 1),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: const [
                    Text(
                      'Trade License',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                ElevatedButton.icon(
              onPressed: _pickFile, // Use the _pickFile method
              icon: const Icon(Icons.attach_file, color: Color(0xFFD6B560)),
              label: const Text('Attach File', style: TextStyle(color: Color(0xFFD6B560))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Color(0xFFD6B560), width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 130),
              ),
            ),
            const SizedBox(height: 8),

          
            if (uploadedFilePath != null) ...[
              TextField(
                controller: TextEditingController(
                  text: uploadedFilePath!.split('/').last,
                ),
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  hintText: 'Uploaded File',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: _removeFile,
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 12),
                cursorColor: const Color(0xFFD6B560),
                textAlignVertical: TextAlignVertical.center,
              ),
            ],
              ],
            ),

            const SizedBox(height: 8),

            TextFieldWithLabel(
              controller:
                  TextEditingController(text: controller.referralCode.value),
              label: 'Referral Code',
              hint: 'Enter Referral Code',
              onChanged: (value) => controller.referralCode.value = value,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 5),

            ElevatedButton(
              onPressed: () {
                if (controller.validateForm()) {
                  Get.snackbar('Success', 'Business signed up successfully!',
                      snackPosition: SnackPosition.TOP);
                } else {
                  Get.snackbar('Error', 'Please fill all required fields',
                      snackPosition: SnackPosition.TOP);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD6B560),
                minimumSize: const Size.fromHeight(40),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Sign up',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(height: 16),

            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white),
                  children: <TextSpan>[
                    const TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: 'Log In',
                      style: const TextStyle(
                        color: Color(0xFFD6B560),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed('signIn');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
