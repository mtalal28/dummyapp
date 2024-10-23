class Booking {
  final String name;
  final String lname; 
  final String mobilecode;
  final String mobilenumber;
  final String address;
  final String totalBookings;
  final String totalEarned;
  final String totalDue;
  final String unpaidBookings;
  final String commissionPercentage;
  final String totalCommission;

  Booking({
    required this.name,
    required this.lname,
    required this.mobilecode,
    required this.mobilenumber,
    required this.address,
    required this.totalBookings,
    required this.totalEarned,
    required this.totalDue,
    required this.unpaidBookings,
    required this.commissionPercentage,
    required this.totalCommission,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      name: json['user']['first_name' ] ?? 'Unknown',
      lname: json['user']['last_name' ] ?? 'Unknown',
      mobilecode: json['user']['mobile_code'] ?? 'N/A',
      mobilenumber: json['user']['mobile_number']??'N/A',
      address: json['user']['country'] ?? 'N/A',
      totalBookings: json['user']['total_bookings'].toString(),
      totalEarned: json['user']['total_earned'].toString(),
      totalDue: json['user']['due_payments'].toString(),
      unpaidBookings: json['user']['unpaid_bookings'].toString(),
      commissionPercentage: json['user']['commission_percentage'].toString(),
      totalCommission: json['user']['commission_amount'].toString(),
    );
  }
}
