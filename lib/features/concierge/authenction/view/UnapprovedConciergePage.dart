import 'package:easyrsv/features/admin/contoller/admin_dashboard_controller.dart';

import 'package:easyrsv/features/concierge/authenction/view/ConciergeDetailsPage.dart';
import 'package:easyrsv/features/admin/view/AdminDashboardPage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnapprovedConciergePage extends StatefulWidget {
  // final List<dynamic> unapprovedConcierges;

  const UnapprovedConciergePage({Key? key}) : super(key: key);

  @override
  State<UnapprovedConciergePage> createState() =>
      _UnapprovedConciergePageState();
}

class _UnapprovedConciergePageState extends State<UnapprovedConciergePage> {
  // bool isLoading = true;
  final AdminDashboardController adminDashboardController =
      Get.put(AdminDashboardController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        adminDashboardController.fetchUnapprovedConcierges();
      },
    );
  }

  Widget buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[500]!,
      child: Card(
        color: Colors.grey[850],
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 150,
                      height: 10,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 80,
                      height: 10,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                Get.off(const AdminDashboardPage());
              },
            ),
          ),
        ),
        title: const Text(
          'Unapproved Concierges',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (adminDashboardController.unapprovedConciergeLoading.value) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => buildShimmerItem(),
          );
        } else if (!adminDashboardController.unapprovedConciergeLoading.value) {
          return ListView.builder(
            itemCount: adminDashboardController.unapprovedConcierges.length,
            itemBuilder: (context, index) {
              var concierge =
                  adminDashboardController.unapprovedConcierges[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ConciergeDetailsPage(concierge: concierge));
                },
                child: Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 14.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        concierge['profile_picture'] != null
                            ? CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(concierge['profile_picture']),
                              )
                            : const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 20),
                              ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${concierge['first_name']} ${concierge['last_name']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 0.5),
                              Text(
                                concierge['mobile_number'] ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 0.5),
                              Row(
                                children: [
                                  const Icon(Icons.business,
                                      color: Color(0xFFD6B560), size: 14),
                                  const SizedBox(width: 1),
                                  Text(
                                    concierge['business_name'] ?? 'No business',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 0.5),
                              Text(
                                'Created at: ${concierge['created_at']}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            buildConciergeStatusWidget(
                                concierge['is_approved']),
                            const SizedBox(height: 15),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              'No Unapproved Concierges Found',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      }),
    );
  }

  Widget buildConciergeStatusWidget(int status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: status == 0 ? const Color(0xFFD6B560) : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: status == 0 ? const Color(0xFFD6B560) : Colors.red,
        ),
      ),
      child: Text(
        status == 0 ? "Pending" : "Rejected",
        style: TextStyle(
          color: status == 0 ? Colors.black : Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
