// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:easyrsv/services/ApiService.dart';
import 'package:easyrsv/view/concierge/ConciergeConfirmationPage.dart';
import 'package:easyrsv/view/concierge/EditProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConciergeDetailsPage extends StatefulWidget {
  dynamic concierge;

  ConciergeDetailsPage({Key? key, required this.concierge}) : super(key: key);

  @override
  _ConciergeDetailsPageState createState() => _ConciergeDetailsPageState();
}

class _ConciergeDetailsPageState extends State<ConciergeDetailsPage> {
  final TextEditingController _commissionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _approveConcierge() async {
    setState(() {
      _isLoading = true;
    });

    int? id = widget.concierge['id'];

    print('User ID: $id');
    if (id == null) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID is missing! Cannot approve.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double commissionPercentage =
        double.tryParse(_commissionController.text) ?? 0.0;

    ApiResponse response =
        await ApiService.approveConcierges(id, commissionPercentage, widget);

    print('API Response: ${response.toJson()}');

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message),
        backgroundColor: response.success ? Colors.green : Colors.red,
      ),
    );

    if (response.success) {
      Get.to(() => const ConciergeConfirmationPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Concierge Data: ${widget.concierge}');
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD6B560),
                            side:
                                const BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            int? id = widget.concierge['id'];

                            final updatedConcierge =
                                await Get.to(() => EditProfilePage(
                                      concierge: widget.concierge,
                                      userId: id,
                                    ));

                            if (updatedConcierge != null) {
                              setState(() {
                                widget.concierge = updatedConcierge;
                              });
                            }
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit, color: Colors.black),
                              SizedBox(width: 4),
                              Text(
                                'Edit',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    widget.concierge['profile_picture'] != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                widget.concierge['profile_picture']),
                          )
                        : const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person,
                                color: Colors.white, size: 40),
                          ),
                    const SizedBox(height: 12),
                    Text(
                      '${widget.concierge['first_name']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 2),

            // User Details
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Business Name:',
                          style: TextStyle(color: Colors.grey)),
                      Text(widget.concierge['business_name'] ?? 'No business',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(width: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Family Name:',
                          style: TextStyle(color: Colors.grey)),
                      Text('${widget.concierge['last_name'] ?? 'N/A'}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date of Birth:',
                          style: TextStyle(color: Colors.grey)),
                      Text('${widget.concierge['dob'] ?? 'N/A'}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email:', style: TextStyle(color: Colors.grey)),
                  Text(widget.concierge['email'] ?? 'N/A',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Address:', style: TextStyle(color: Colors.grey)),
                  Text(widget.concierge['address'] ?? 'N/A',
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Payment Preference:',
                      style: TextStyle(color: Colors.grey)),
                  Text('${widget.concierge['payment_method'] ?? 'N/A'}',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),

            const SizedBox(height: 2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Commission Structure',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add commission percentage',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  '%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _commissionController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter commission percentage',
                                    hintStyle:
                                        const TextStyle(color: Colors.white54),
                                    filled: true,
                                    fillColor: Colors.grey[850],
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 2.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle reject action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side:
                                    const BorderSide(color: Color(0xFFD6B560)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Reject Submission',
                                style: TextStyle(
                                  color: Color(0xFFD6B560),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _approveConcierge,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD6B560),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.black)
                                  : const Text(
                                      'Accept Submission',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
