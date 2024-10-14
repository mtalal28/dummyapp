import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewConciergeDetailsPage extends StatefulWidget {
  final Map<String, dynamic> concierge;

  const ViewConciergeDetailsPage({Key? key, required this.concierge})
      : super(key: key);

  @override
  State<ViewConciergeDetailsPage> createState() =>
      _ViewConciergeDetailsPageState();
}

class _ViewConciergeDetailsPageState extends State<ViewConciergeDetailsPage> {
  final TextEditingController _commissionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commissionController.dispose();
    super.dispose();
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
                    const SizedBox(height: 16),
                    widget.concierge['profile_picture'] != null
                        ? Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(
                                    0xFFD6B560), // Golden border color
                                width: 5, // Border width
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.5), // Shadow color
                                  blurRadius: 10, // How soft the shadow is
                                  spreadRadius: 2, // Spread of the shadow
                                  offset: const Offset(
                                      0, 4), // Position of the shadow
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  widget.concierge['profile_picture']),
                            ),
                          )
                        : Container(
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
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[800],
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                    const SizedBox(height: 12),
                    Text(
                      '${widget.concierge['first_name']} ${widget.concierge['last_name']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                      Text(widget.concierge['email'] ?? 'N/A',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12, fontWeight:FontWeight.w700)),
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
                      Text(widget.concierge['business_name'] ?? 'No business',
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
                          '${widget.concierge['first_name']} ${widget.concierge['last_name'] ?? 'N/A'}',
                          style: const TextStyle(color: Colors.white)),
                          
                    ],
                    
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),

            // Mobile and Date of Birth Section
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
                          '+${widget.concierge['mobile_code'] ?? 'N/A'}-${widget.concierge['mobile_number'] ?? 'N/A'}',
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
                      Text(widget.concierge['dob'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),

            // Email and Joining Date Section
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
                      Text(widget.concierge['email'] ?? 'N/A',
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
                      Text(widget.concierge['dob'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            const Divider(color: Colors.grey),

            // Payment and Bank Information Section
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
                      Text(widget.concierge['payment_method'] ?? 'N/A',
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
                  Text(widget.concierge['bank_name'] ?? 'N/A',
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
                      Text(widget.concierge['account_iban'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(width: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Account Title:',
                          style: TextStyle(color: Colors.white70)),
                      Text(widget.concierge['account_title'] ?? 'N/A',
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
                      '${widget.concierge['business_name'] ?? 'N/A'}',
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

            // Update Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Update logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6B560),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    const Text('Update', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
