class Profile {
  String firstName;
  String lastName;
  String businessName;
  String email;
  String mobileCode;
  String mobileNumber;
  String dob;
  String profilePicture;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.businessName,
    required this.email,
    required this.mobileCode,
    required this.mobileNumber,
    required this.dob,
    required this.profilePicture,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      businessName: json['business_name'] ?? '',
      email: json['email'] ?? '',
      mobileCode: json['mobile_code'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      dob: json['dob'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }
  bool isEmailChanged(String newEmail) {
    return email != newEmail;
  }
}
