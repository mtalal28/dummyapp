import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserModel {
  final AddressModel address;
  final String businessName;
  final String familyName;
  final PhoneModel phone;
  final String fname;
  final String email;
  final String lname;
  final String dob;
  final bool status;

  const UserModel({
    required this.address,
    required this.businessName,
    required this.familyName,
    required this.phone,
    required this.fname,
    required this.email,
    required this.lname,
    required this.dob,
    required this.status,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'address': address.toJson(),
        'businessName': businessName,
        'familyName': familyName,
        'phone': phone.toJson(),
        'fname': fname,
        'email': email,
        'lname': lname,
        'dob': dob,
        'status': status,
      };

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      address: AddressModel.fromJson(json['address']),
      businessName: json['businessName'],
      familyName: json['familyName'],
      phone: PhoneModel.fromJson(json['phone']),
      fname: json['fname'],
      email: json['email'],
      lname: json['lname'],
      dob: json['dob'],
      status: json['status'],
    );
  }

  // CopyWith for immutability
  UserModel copyWith({
    AddressModel? address,
    String? businessName,
    String? familyName,
    PhoneModel? phone,
    String? fname,
    String? email,
    String? lname,
    String? dob,
    bool? status,
  }) {
    return UserModel(
      address: address ?? this.address,
      businessName: businessName ?? this.businessName,
      familyName: familyName ?? this.familyName,
      phone: phone ?? this.phone,
      fname: fname ?? this.fname,
      email: email ?? this.email,
      lname: lname ?? this.lname,
      dob: dob ?? this.dob,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'UserModel(address: $address, businessName: $businessName, familyName: $familyName, phone: $phone, fname: $fname, email: $email, lname: $lname, dob: $dob, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.address == address &&
        other.businessName == businessName &&
        other.familyName == familyName &&
        other.phone == phone &&
        other.fname == fname &&
        other.email == email &&
        other.lname == lname &&
        other.dob == dob &&
        other.status == status;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        businessName.hashCode ^
        familyName.hashCode ^
        phone.hashCode ^
        fname.hashCode ^
        email.hashCode ^
        lname.hashCode ^
        dob.hashCode ^
        status.hashCode;
  }
}

@immutable
class AddressModel {
  final String country;
  final String state;
  final String city;
  final String refCode;
  final String location;
  final String address;

  const AddressModel({
    required this.country,
    required this.state,
    required this.city,
    required this.refCode,
    required this.location,
    required this.address,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'country': country,
        'state': state,
        'city': city,
        'refCode': refCode,
        'location': location,
        'address': address,
      };

  // Create from JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      country: json['country'],
      state: json['state'],
      city: json['city'],
      refCode: json['refCode'],
      location: json['location'],
      address: json['address'],
    );
  }

  // CopyWith for immutability
  AddressModel copyWith({
    String? country,
    String? state,
    String? city,
    String? refCode,
    String? location,
    String? address,
  }) {
    return AddressModel(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      refCode: refCode ?? this.refCode,
      location: location ?? this.location,
      address: address ?? this.address,
    );
  }

  @override
  String toString() {
    return 'AddressModel(country: $country, state: $state, city: $city, refCode: $refCode, location: $location, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.country == country &&
        other.state == state &&
        other.city == city &&
        other.refCode == refCode &&
        other.location == location &&
        other.address == address;
  }

  @override
  int get hashCode {
    return country.hashCode ^
        state.hashCode ^
        city.hashCode ^
        refCode.hashCode ^
        location.hashCode ^
        address.hashCode;
  }
}

@immutable
class PhoneModel {
  final String mobileNumber;
  final String phoneNumber;
  final String code;

  const PhoneModel({
    required this.mobileNumber,
    required this.phoneNumber,
    required this.code,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'mobileNumber': mobileNumber,
        'phoneNumber': phoneNumber,
        'code': code,
      };

  // Create from JSON
  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      mobileNumber: json['mobileNumber'],
      phoneNumber: json['phoneNumber'],
      code: json['code'],
    );
  }

  // CopyWith for immutability
  PhoneModel copyWith({
    String? mobileNumber,
    String? phoneNumber,
    String? code,
  }) {
    return PhoneModel(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      code: code ?? this.code,
    );
  }

  @override
  String toString() {
    return 'PhoneModel(mobileNumber: $mobileNumber, phoneNumber: $phoneNumber, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneModel &&
        other.mobileNumber == mobileNumber &&
        other.phoneNumber == phoneNumber &&
        other.code == code;
  }

  @override
  int get hashCode {
    return mobileNumber.hashCode ^ phoneNumber.hashCode ^ code.hashCode;
  }
}
