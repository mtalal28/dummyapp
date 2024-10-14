// ignore_for_file: file_names

import 'dart:developer';

import 'package:easyrsv/services/ApiService.dart';
import 'package:easyrsv/view/concierge/ApprovedConcigerges.dart';
import 'package:easyrsv/view/concierge/UnapprovedConciergePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 0;
  static const Color customGoldColor = Color(0xFFD6B560);

  Future<void> showLogoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Colors.grey[900], // Set the background color for the dialog
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                await logout();
                Get.toNamed('signIn');
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Color(0xFFD6B560)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_token');
  Get.offAllNamed('signIn'); 
}


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/Mask group Con.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12, // Smaller and unbold
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12, // Smaller and bold
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () {
              showLogoutDialog(context);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            height: 0.3,
            color: Colors.grey,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(
                      color: Color(0xFFD6B560),
                      width: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Select date',
                        style: TextStyle(color: Color(0xFFD6B560)),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.calendar_today, color: Color(0xFFD6B560)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // GridView for statistics
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 10.0), // Adjusted padding
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 9.0,
              childAspectRatio: 1.3,
              children: [
                _buildStatCard(
                    'Concierges \nStatistics', Icons.person, Colors.teal,
                    onTap: () {}),
                _buildStatCard(
                    'Restaurants \nStatistics', Icons.store, Colors.blue,
                    onTap: () {}),
                _buildStatCard(
                  'Total \nConcierges',
                  Icons.people,
                  Colors.orange,
                  onTap: () async {
                    print("Fetching approved concierges...");

                    ApiResponse response =
                        await ApiService.getApprovedConcierges();

                    print("Response data: ${response.data}");

                    if (response.success) {
                      var approvedConcierges = response.data['concierges'];

                      print("Approved Concierges List: $approvedConcierges");

                      if (approvedConcierges != null &&
                          approvedConcierges is List &&
                          approvedConcierges.isNotEmpty) {
                        Get.to(() => ApprovedConciergePage(
                              approvedConcierges: approvedConcierges,
                            ));
                      } else {
                        Get.snackbar(
                          'No Data',
                          'No approved concierges found.',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.yellow,
                          colorText: Colors.black,
                        );
                      }
                    } else {
                      // Handle the case when the API call fails
                      Get.snackbar(
                        'Error',
                        response.message,
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
                _buildStatCard('Unapproved \nConcierges', Icons.person_off,
                    Colors.lightBlueAccent, onTap: () async {
                  print("unapproved tapped");
                  ApiResponse response =
                      await ApiService.unapprovedConcierges();
                  log("response status ::: ${response.data}");

                  if (response.success) {
                    var unapprovedConcierges = response.data['concierges'];
                    print("Unapproved Concierges List: $unapprovedConcierges");

                    if (unapprovedConcierges != null &&
                        unapprovedConcierges is List &&
                        unapprovedConcierges.isNotEmpty) {
                      Get.to(() => UnapprovedConciergePage(
                          unapprovedConcierges: unapprovedConcierges));
                    } else {
                      Get.snackbar(
                        'No Data',
                        'No unapproved concierges found.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.yellow,
                        colorText: Colors.black,
                      );
                    }
                  } else {
                    Get.snackbar(
                      'Error',
                      response.message,
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                }),
                _buildStatCard('Total \nRestaurants', Icons.store, Colors.green,
                    onTap: () {}),
                _buildStatCard(
                    'Unapproved \nRestaurants', Icons.store, Colors.amber,
                    onTap: () {}),
                _buildStatCard(
                    'Pending Receivables', Icons.payment, Colors.amber,
                    onTap: () {}),
                _buildStatCard(
                    'Pending Payable', Icons.payment_outlined, Colors.amber,
                    onTap: () {}),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              border: const Border(
                top: BorderSide(color: customGoldColor, width: 2.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home, 'Home', 0),
                _buildBottomNavItem(Icons.store, 'Restaurants', 1),
                _buildBottomNavItem(Icons.people, 'Concierges', 2),
                _buildBottomNavItem(Icons.favorite, 'Wishlist', 3),
                _buildBottomNavItem(Icons.more_horiz, 'More', 4),
              ],
            ),
          ),
          Positioned(
            bottom: 69,
            left: (_selectedIndex * (MediaQuery.of(context).size.width / 5)) +
                ((MediaQuery.of(context).size.width / 5 - 18) / 3),
            child: CustomPaint(
              size: const Size(18, 10),
              painter: UpwardArrowPainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: _selectedIndex == index ? customGoldColor : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index
                  ? customGoldColor
                  : Colors.grey, // Set text color to grey
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, IconData icon, Color color,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Icon(icon, size: 25, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class UpwardArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFFD6B560);

    Path path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
