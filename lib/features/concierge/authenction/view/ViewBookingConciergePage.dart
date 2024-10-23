// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ViewBookingConciergePage extends StatelessWidget {
//   const ViewBookingConciergePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[800],
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               color: Colors.white,
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//           ),
//         ),
//         title: const Text(
//           'Concierge Details',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(3.0),
//           child: Container(
//             color: Colors.grey,
//             height: 1.0,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SizedBox(
//           height: 420.0,
//           child: Container(
//             padding: const EdgeInsets.all(12.0),
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(10.0),
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 0.5,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.grey[700],
//                       radius: 28,
//                       child: const Icon(
//                         Icons.person,
//                         color: Colors.white,
//                         size: 26,
//                       ),
//                     ),
//                     const SizedBox(width: 12.0),
//                     const Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Ahsan Ali',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             '+971-3064085496',
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             'Plot 302, Mehran Block Allama Iqbal Town, Lahore, Punjab, Pakistan',
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0,
//                         vertical: 5.0,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       child: const Text(
//                         'Active',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.0,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     _buildStatColumnWithIcon(Icons.business, 'Total Bookings', '0'),
//                     Container(
//                       height: 60,
//                       child: const VerticalDivider(
//                         color: Colors.grey,
//                         thickness: 1,
//                         width: 20,
//                       ),
//                     ),
//                     _buildStatColumnWithIcon(Icons.account_balance_wallet_outlined, 'Total Earned', '0.00'),
//                     Container(
//                       height: 60,
//                       child: const VerticalDivider(
//                         color: Colors.grey,
//                         thickness: 1,
//                         width: 20,
//                       ),
//                     ),
//                     _buildStatColumnWithIcon(Icons.document_scanner_outlined, 'Total Due', '0.00'),
//                   ],
//                 ),
//                 const SizedBox(height: 30.0),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 10.0,
//                     horizontal: 14.0,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[800],
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Unpaid Bookings',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       Text(
//                         '0',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: _buildStatColumn('Commission', '5.00 %'),
//                     ),
//                     Container(
//                       height: 40,
//                       child: const VerticalDivider(
//                         color: Colors.grey,
//                         thickness: 1,
//                         width: 20,
//                       ),
//                     ),
//                     Expanded(
//                       child: _buildStatColumn('Total Commission', '0.00 AED'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

 
//   Widget _buildStatColumnWithIcon(IconData icon, String label, String value) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           icon,
//           color: const Color(0xFFD6B560),
//           size: 24,
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white70, fontSize: 12),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatColumn(String label, String value) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white70, fontSize: 12),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:easyrsv/features/concierge/authenction/model/booking_model.dart';
import 'package:easyrsv/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewBookingConciergePage extends StatefulWidget {

  final int conciergeId;

  const ViewBookingConciergePage({super.key,  required this.conciergeId});

  

  @override
  _ViewBookingConciergePageState createState() => _ViewBookingConciergePageState();
}

class _ViewBookingConciergePageState extends State<ViewBookingConciergePage> {
  
  Booking? booking;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchBookingDetails(widget.conciergeId, 1);
  }

  Future<void> fetchBookingDetails(int userId, int page) async {
    setState(() {
      isLoading = true; 
    });

    try {
      List<Booking> result = await ApiService.getBookingsById(userId, page);
      setState(() {
        List<Booking> bookings= result as List<Booking>;
        booking = bookings[0];
        isLoading = false;
      });
    } catch (error) {
      log('Error fetching booking details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }


//  Future<void> fetchBookingDetails(int userId) async {
//   log('fetchBookingDetails called with userId: $userId');
//   setState(() {
//     isLoading = true; 
//   });
  
//   // try {
//     final result = await ApiService.getBookingDetails(userId);
//     setState(() {
//       booking = result;
//       isLoading = false;
//     });
//   // } catch (error) {
//   //   log('Error fetching booking details: $error');
//   //   setState(() {
//   //     isLoading = false;
//   //   });
//   // }
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        title: const Text(
          'Concierge Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : booking != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 420.0,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[700],
                                radius: 28,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          booking!.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                         Text(
                                      booking!.lname,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                      ],
                                    ),
                                   
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          booking!.mobilecode,
                                          style: const TextStyle(color: Colors.white70),
                                        ),
                                         const SizedBox(width: 3),
                                        Text(
                                      booking!.mobilenumber,
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                      ],
                                    ),
                                   
                                    
                                    const SizedBox(height: 4),
                                    Text(
                                      booking!.address,
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Text(
                                  'Active',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildStatColumnWithIcon(
                                  Icons.business, 'Total Bookings', booking!.totalBookings),
                              Container(
                                height: 60,
                                child: const VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                  width: 20,
                                ),
                              ),
                              _buildStatColumnWithIcon(Icons.account_balance_wallet_outlined, 'Total Earned',
                                  booking!.totalEarned),
                              Container(
                                height: 60,
                                child: const VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                  width: 20,
                                ),
                              ),
                              _buildStatColumnWithIcon(
                                  Icons.document_scanner_outlined, 'Total Due', booking!.totalDue),
                            ],
                          ),
                          const SizedBox(height: 30.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 14.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Unpaid Bookings',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  booking!.unpaidBookings,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildStatColumn('Commission', '${booking!.commissionPercentage}%'),
                              ),
                              Container(
                                height: 40,
                                child: const VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1,
                                  width: 20,
                                ),
                              ),
                              Expanded(
                                child: _buildStatColumn('Total Commission', '${booking!.totalCommission} AED'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(child: Text('No data found')),
    );
  }

  Widget _buildStatColumnWithIcon(IconData icon, String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: const Color(0xFFD6B560),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
