// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easyrsv/features/admin/models/Profile_model.dart.dart';
import 'package:easyrsv/services/ApiService.dart';
import 'package:easyrsv/appfeature/utils/autospacing.dart';
import 'package:easyrsv/appfeature/widget.dart/text_field_with_label.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> concierge;
  final int? userId;

  const EditProfilePage({Key? key, required this.concierge, this.userId})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileCodeController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final PaymentController controller = Get.put(PaymentController());
  final TextEditingController banknameController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController cardholderController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  String? uploadedFilePath;
  String selectedCountryCode = '+92';
  Profile? profile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      setState(() {
        uploadedFilePath = filePath;
      });
      log('Selected file: $filePath' as num);
    } else {
      log('No file selected.' as num);
    }
  }

  void _removeFile() {
    setState(() {
      uploadedFilePath = null;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Convert pickedFile to File
      });

      // TODO: Upload the image to the server or perform any action after picking the image.
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    profile = Profile.fromJson(widget.concierge);

    _firstNameController.text = profile?.firstName ?? '';
    _lastNameController.text = profile?.lastName ?? '';
    _businessNameController.text = profile?.businessName ?? '';
    _emailController.text = profile?.email ?? '';
    _mobileCodeController.text = profile?.mobileCode ?? '';
    _mobileController.text = profile?.mobileNumber ?? '';
    _dobController.text = profile?.dob ?? '';
  }

  Future<void> _saveProfile() async {
    try {
      int? id = widget.concierge['id'];

      print('User ID: $id');

      if (id == null) {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User ID is missing! Cannot update profile.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // String currentEmail = _emailController.text;

      final response = await ApiService.updateProfile(
        id: id.toString(),
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        // email: currentEmail,
        waCode: selectedCountryCode,
        waNumber: _whatsappController.text,
        dob: _dobController.text,
        paymentMethod: controller.selectedPayment.value,
        businessName: _businessNameController.text,
        mobileCode: _mobileCodeController.text,
        mobileNumber: _mobileController.text,
        whatsappNumber: _whatsappController.text,
        bankName: banknameController.text,
        accountNumber: accountController.text,
        cardHolderName: cardholderController.text,
        paymentPreference: '',
        partnershipAgreement: uploadedFilePath,
      );

      if (response.success) {
        Get.back();
      } else {
        if (response.message.contains("The email has already been taken.")) {
          Get.snackbar('Info',
              'Your email is already in use, but other details were updated.',
              snackPosition: SnackPosition.TOP);
        } else {
          print("Error updating profile: ${response.message}");

          Get.snackbar('Error', response.message,
              snackPosition: SnackPosition.TOP);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while updating profile',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6B560),
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[850],
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 16,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _pickImage, // Trigger image picker when clicked
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFD6B560),
                            width: 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: _image != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(
                                    _image!), // Display the picked image
                              )
                            : widget.concierge['profile_picture'] != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        widget.concierge['profile_picture']),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[800],
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name Field
                    const Row(
                      children: [
                        Text(
                          'First Name',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      cursorColor: const Color(0xFFD6B560),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(height: 2),

                    // Last Name Field
                    const Row(
                      children: [
                        Text(
                          'Last Name',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      cursorColor: const Color(0xFFD6B560),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(height: 2),

                    // Business Name Field
                    const Row(
                      children: [
                        Text(
                          'Business Name',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      controller: _businessNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      cursorColor: const Color(0xFFD6B560),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(height: 2),

                    // Email Field
                    const Row(
                      children: [
                        Text(
                          'Email Address',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      controller: _emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                      ),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      cursorColor: const Color(0xFFD6B560),
                      textAlignVertical: TextAlignVertical.center,
                    ),

                    const SizedBox(height: 2),

                    const Row(
                      children: [
                        Text(
                          'Mobile Number',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _mobileCodeController,
                              inputFormatters: [
                                AutoSpacingPhoneNumberFormatter(),
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[600],
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(15)),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 18),
                              ),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              cursorColor: const Color(0xFFD6B560),
                              textAlignVertical: TextAlignVertical.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: 0),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _mobileController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[850],
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                            cursorColor: const Color(0xFFD6B560),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Text(
                          'Date of Birth',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today,
                              color: Colors.white),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      cursorColor: const Color(0xFFD6B560),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Text(
                          'WhatsApp Number',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                              ),
                            ),
                            child: CountryCodePicker(
                              onChanged: (countryCode) {
                                setState(() {
                                  selectedCountryCode = countryCode.dialCode!;
                                });
                              },
                              initialSelection: 'PK',
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              favorite: const ['+92'],
                              showFlag: false,
                              padding: EdgeInsets.zero,
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 0),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _whatsappController,
                            inputFormatters: [
                              AutoSpacingPhoneNumberFormatter(),
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[850],
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(15)),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                            cursorColor: const Color(0xFFD6B560),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 2),

                    const Row(
                      children: [
                        Text(
                          'Partnership Agreement',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add, color: Color(0xFFD6B560)),
                          onPressed: _pickFile,
                        ),
                        hintText: 'Partnership Agreement ',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: const Icon(Icons.assignment,
                            color: Color(0xFFD6B560)),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      cursorColor: const Color(0xFFD6B560),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    const SizedBox(height: 10),

                    if (uploadedFilePath != null) ...[
                      TextField(
                        controller: TextEditingController(
                          text: uploadedFilePath!.split('/').last,
                        ),
                        readOnly: true, // Make it read-only
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          hintText: 'Uploaded File',
                          hintStyle: TextStyle(
                              color:
                                  Colors.grey[400]), // Change hint text color
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: _removeFile,
                          ),
                        ),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                        cursorColor: const Color(0xFFD6B560),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ],

                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Text(
                          'Paymnet Preference',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.selectedPayment.value = 'cash';
                          },
                          child: Obx(() => PaymentOption(
                                icon: Icons.money,
                                label: 'Cash',
                                isSelected:
                                    controller.selectedPayment.value == 'cash',
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.selectedPayment.value = 'Bank Transfer';
                          },
                          child: Obx(() => PaymentOption(
                                icon: Icons.credit_card,
                                label: 'Bank Transfer',
                                isSelected: controller.selectedPayment.value ==
                                    'Bank Transfer',
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    Obx(() {
                      if (controller.selectedPayment.value == 'Bank Transfer') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldWithLabel(
                              controller: banknameController,
                              label: 'Bank Name',
                              hint: 'Enter Your Bank Name',
                              isMandatory: true,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) =>
                                  controller.bank.value = value,
                              inputFormatters: const [],
                            ),
                            TextFieldWithLabel(
                              controller: accountController,
                              label: 'Account / IBAN Number',
                              hint: 'Enter Your Account/IBAN Number',
                              isMandatory: true,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) =>
                                  controller.account.value = value,
                              inputFormatters: const [],
                            ),
                            TextFieldWithLabel(
                              controller: cardholderController,
                              label: 'Card Holder Name',
                              hint: 'Enter the Card Holder Name',
                              isMandatory: true,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              onChanged: (value) =>
                                  controller.cardHolder.value = value,
                              inputFormatters: const [],
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    const SizedBox(height: 1),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6B560),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentController extends GetxController {
  var selectedPayment = ''.obs;
  RxString bank = ''.obs;
  RxString account = ''.obs;
  RxString cardHolder = ''.obs;
}

class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const PaymentOption({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[800] : Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? const Color(0xFFD6B560) : Colors.grey[700]!,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFD6B560),
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: const Color(0xFFD6B560),
          ),
        ],
      ),
    );
  }
}
