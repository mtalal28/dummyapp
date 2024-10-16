import 'dart:developer';

import 'package:easyrsv/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AdminDashboardController extends GetxController {
  var approvedConcierges = [].obs; 
  var unapprovedConcierges =  <dynamic>[].obs;  
  RxBool isLoading = false.obs; 

  @override
  void onInit() {
    super.onInit();
    fetchApprovedConcierges();
    fetchUnapprovedConcierges();
  }

  
  Future<void> fetchApprovedConcierges() async {
    isLoading.value = true;
    ApiResponse response = await ApiService.getApprovedConcierges();
    
    if (response.success) {
      approvedConcierges.value = response.data['concierges'] ?? [];
    } else {
      Get.snackbar('Error', response.message, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
    }
    isLoading.value = false;
  }

//  Future<void> fetchUnapprovedConcierges() async {
//     try {
//       final response = await http.get(Uri.parse('https://conciergebooking.tijarah.ae/api/requested/concierges'));

//       if (response.statusCode == 200) {

       
//         final Map<String, dynamic> data = json.decode(response.body);
        
        
//         if (data['concierges'] != null && data['concierges'] is List) {
//           unapprovedConcierges.value = data['concierges']; 
//         } else {
          
//           print("No unapproved concierges found or wrong data type.");
//           unapprovedConcierges.value = []; 
//         }
//       } else {
//         print('Error: ${response.statusCode}');
//         unapprovedConcierges.value = []; 
//       }
//     } catch (e) {
//       print('Failed to fetch unapproved concierges: $e');
//       unapprovedConcierges.value = []; 
//     } finally {
//       isLoading.value = false; 
//     }
 

 RxBool unapprovedConciergeLoading = false.obs;

  Future<void> fetchUnapprovedConcierges() async {
  try {
    unapprovedConciergeLoading.value = true;
   SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  
  print("method unapproved called");
    final response = await http.get(Uri.parse('https://conciergebooking.tijarah.ae/api/requested/concierges'),headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    log('Response status code: ${response.statusCode}');
    log('Response body: ${response.body}'); 
    unapprovedConciergeLoading.value = false;
  
    if (response.statusCode == 200) {
      
      
      List<dynamic> data = jsonDecode(response.body)['concierges'];
        unapprovedConcierges.assignAll(data);
          log('Decoded data: $data'); 
      log('Fetched unapproved concierges: $data');
       
    } else {
      log('Error fetching unapproved concierges: ${response.statusCode}'); 
      unapprovedConcierges.clear(); 
    }
  } catch (error) {
    unapprovedConciergeLoading.value = false;
    log('Failed to fetch unapproved concierges: $error'); 
    unapprovedConcierges.clear(); 
  } finally {
    isLoading.value = false;
  }
}



}