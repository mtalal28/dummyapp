// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:developer';

import 'package:easyrsv/features/concierge/authenction/controller/update_controller.dart';
import 'package:easyrsv/features/concierge/authenction/view/EditProfilePage.dart';
import 'package:easyrsv/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewConciergeDetailsPage extends StatefulWidget {
  final int conciergeId;
  // final Map<String, dynamic> concierge;

  const ViewConciergeDetailsPage({Key? key, required this.conciergeId})
      : super(key: key);

  @override
  State<ViewConciergeDetailsPage> createState() =>
      _ViewConciergeDetailsPageState();
}

class _ViewConciergeDetailsPageState extends State<ViewConciergeDetailsPage> {
  final TextEditingController _commissionController = TextEditingController();
  final UpdateController updateController = Get.put(UpdateController());

  bool isActive = false;
   Map<String, dynamic> concierge = {};
   bool isLoading = false;

  
  @override
  void initState() {
    super.initState();
    getConciergeDetails();
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        getConciergeDetails();
     },);
  }
   
  Future<void> getConciergeDetails() async {
  int? id = widget.conciergeId;
    // try {
      setState(() {
        isLoading = true;
      });
      
      final response = await ApiService.getconciergedetails(id);
      
     
      // final details = jsonDecode(response.data);
      
      log("details::::: ${response.data}");
   
      setState(() {
        isLoading = false;
        concierge = response.data; 
        isActive = concierge['user']['is_active'] == 1;
      });
    // } catch (e) {
      
    //   print('Error fetching concierge details: $e');
    // }
}

  

  @override
  void dispose() {
    _commissionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int? id = concierge['user']['id'];

    double commissionPercentage = 1;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    

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
                            int? id = concierge['id'];

                            final updatedConcierge =
                                await Get.to(() => EditProfilePage(
                                      concierge: concierge,
                                      userId: id,
                                    ));

                            if (updatedConcierge != null) {
                              setState(() {
                                concierge = updatedConcierge;
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
                    concierge['profile_picture'] != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                concierge['user']['profile_picture']),
                          )
                        : const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person,
                                color: Colors.white, size: 40),
                          ),
                    const SizedBox(height: 12),
                    Text(
                      '${concierge['user']['first_name']} ${concierge['user']['last_name']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(concierge['user']['email'] ?? 'N/A',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                   
                        buildActiveInactiveToggle()
                    
                  
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
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
                      Text(concierge['user']['business_name'] ?? 'No business',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(width: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Full Name:',
                          style: TextStyle(color: Colors.grey)),
                      Text(
                          '${concierge['user']['first_name']} ${concierge['user']['last_name'] ?? 'N/A'}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mobile:',
                          style: TextStyle(color: Colors.white70)),
                      Text(
                          '+${concierge['user']['mobile_code'] ?? 'N/A'}-${concierge['user']['mobile_number'] ?? 'N/A'}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 90),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date of Birth:',
                          style: TextStyle(color: Colors.white70)),
                      Text(concierge['user']['dob'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Email:',
                          style: TextStyle(
                            color: Colors.white70,
                          )),
                      Text(concierge['user']['email'] ?? 'N/A',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 45),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Joining Date:',
                          style: TextStyle(color: Colors.white70)),
                      Text(concierge['user']['dob'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            const Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Payment Method:',
                          style: TextStyle(color: Colors.white70)),
                      Text(concierge['user']['payment_method'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bank Name:',
                      style: TextStyle(color: Colors.white70)),
                  Text(concierge['user']['bank_name'] ?? 'N/A',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Account IBAN:',
                          style: TextStyle(color: Colors.white70)),
                      Text(concierge['user']['account_iban'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(width: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Account Title:',
                          style: TextStyle(color: Colors.white70)),
                      Text(concierge['user']['account_title'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Commission Structure',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
            Transform.translate(
              offset: const Offset(5, -4),
              child: Container(
                height: 150,
                width: 400,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${concierge['user']['business_name'] ?? 'N/A'}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Commission percentage',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(11.0),
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
                                    horizontal: 20.0, vertical: 2.0),
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 0),
            Center(
              child: Obx(() => ElevatedButton(
                    onPressed: updateController.isLoading.value
                        ? null
                        : () async {
                            int? id = concierge['user']['id'];
                            if (id != null) {
                              double commissionPercentage =
                                  double.tryParse(_commissionController.text) ??
                                      1.0;
                              updateController
                                  .approveUser(id, commissionPercentage);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6B560),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 130, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: updateController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text(
                            'Update',
                            style: TextStyle(color: Colors.black),
                          ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

Widget buildActiveInactiveToggle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(width: 10),
      Switch(
        value: isActive,
        onChanged: (bool value) {
          if (isActive != value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 48, 43, 43),
                  content: const Text(
                    "Are you sure you want to de-activate this?",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {

                            Get.back();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFD6B560),
                            side: const BorderSide(color: Color(0xFFD6B560)),
                            minimumSize: const Size(100, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("No"),
                        ),
                        const SizedBox(width: 10), 
                        TextButton(
                          onPressed: () async{
                            await ApiService.toggleUserCall(concierge['user']['id']);

                              getConciergeDetails();
                            // setState(() {
                         
                            //   isActive = value;
                                 
                            // });
                            Get.back();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFD6B560),
                            foregroundColor: Colors.black,
                            minimumSize: const Size(100, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else {
            getConciergeDetails().then((_) {
              setState(() {
                isActive = value; 
              });
            }).catchError((error) {
             
              log('Error fetching concierge details: $error');
            });
          }
        },
        activeTrackColor: Colors.grey[900],
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey[900],
      ),
    ],
  );
}
}
