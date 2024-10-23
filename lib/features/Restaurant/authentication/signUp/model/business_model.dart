import 'package:flutter/foundation.dart' show immutable;

@immutable
class BusinessModel {
  final AddressModel address;
  final String businessName;
  final String category;
  final ContactPersonModel contactPerson;
  final String emailAddress;
  final PhoneModel phone;
  final PhoneModel mobile;
  final String password;
  final String confirmPassword;
  final String tradeLicenseFile;
  final String? referralCode;

  const BusinessModel({
    required this.address,
    required this.businessName,
    required this.category,
    required this.contactPerson,
    required this.emailAddress,
    required this.phone,
    required this.mobile,
    required this.password,
    required this.confirmPassword,
    required this.tradeLicenseFile,
    this.referralCode,
  });

  
  Map<String, dynamic> toJson() => {
        'address': address.toJson(),
        'businessName': businessName,
        'category': category,
        'contactPerson': contactPerson.toJson(),
        'emailAddress': emailAddress,
        'phone': phone.toJson(),
        'mobile': mobile.toJson(),
        'password': password,
        'confirmPassword': confirmPassword,
        'tradeLicenseFile': tradeLicenseFile,
        'referralCode': referralCode,
      };

  
  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      address: AddressModel.fromJson(json['address']),
      businessName: json['businessName'],
      category: json['category'],
      contactPerson: ContactPersonModel.fromJson(json['contactPerson']),
      emailAddress: json['emailAddress'],
      phone: PhoneModel.fromJson(json['phone']),
      mobile: PhoneModel.fromJson(json['mobile']),
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      tradeLicenseFile: json['tradeLicenseFile'],
      referralCode: json['referralCode'],
    );
  }

  
  BusinessModel copyWith({
    AddressModel? address,
    String? businessName,
    String? category,
    ContactPersonModel? contactPerson,
    String? emailAddress,
    PhoneModel? phone,
    PhoneModel? mobile,
    String? password,
    String? confirmPassword,
    String? tradeLicenseFile,
    String? referralCode,
  }) {
    return BusinessModel(
      address: address ?? this.address,
      businessName: businessName ?? this.businessName,
      category: category ?? this.category,
      contactPerson: contactPerson ?? this.contactPerson,
      emailAddress: emailAddress ?? this.emailAddress,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      tradeLicenseFile: tradeLicenseFile ?? this.tradeLicenseFile,
      referralCode: referralCode ?? this.referralCode,
    );
  }

  @override
  String toString() {
    return 'BusinessModel(address: $address, businessName: $businessName, category: $category, contactPerson: $contactPerson, emailAddress: $emailAddress, phone: $phone, mobile: $mobile, password: $password, confirmPassword: $confirmPassword, tradeLicenseFile: $tradeLicenseFile, referralCode: $referralCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusinessModel &&
        other.address == address &&
        other.businessName == businessName &&
        other.category == category &&
        other.contactPerson == contactPerson &&
        other.emailAddress == emailAddress &&
        other.phone == phone &&
        other.mobile == mobile &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.tradeLicenseFile == tradeLicenseFile &&
        other.referralCode == referralCode;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        businessName.hashCode ^
        category.hashCode ^
        contactPerson.hashCode ^
        emailAddress.hashCode ^
        phone.hashCode ^
        mobile.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        tradeLicenseFile.hashCode ^
        referralCode.hashCode;
  }
}

class ContactPersonModel {
  String name;
  String mainPointOfContact;

  ContactPersonModel({
    required this.name,
    required this.mainPointOfContact,
  });
 
  Map<String, dynamic> toJson() => {
        'name': name,
        'mainPointOfContact': mainPointOfContact,
      };

  
  factory ContactPersonModel.fromJson(Map<String, dynamic> json) {
    return ContactPersonModel(
      name: json['name'],
      mainPointOfContact: json['mainPointOfContact'],
    );
  }

  
  ContactPersonModel copyWith({
    String? name,
    String? mainPointOfContact,
  }) {
    return ContactPersonModel(
      name: name ?? this.name,
      mainPointOfContact: mainPointOfContact ?? this.mainPointOfContact,
    );
  }

  @override
  String toString() {
    return 'ContactPersonModel(name: $name, mainPointOfContact: $mainPointOfContact)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactPersonModel &&
        other.name == name &&
        other.mainPointOfContact == mainPointOfContact;
  }

  @override
  int get hashCode {
    return name.hashCode ^ mainPointOfContact.hashCode;
  }
}

@immutable
class PhoneModel {
  final String number;
  final String code;

  const PhoneModel({
    required this.number,
    required this.code,
  });

 
  Map<String, dynamic> toJson() => {
        'number': number,
        'code': code,
      };

  
  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      number: json['number'],
      code: json['code'],
    );
  }

 
  PhoneModel copyWith({
    String? number,
    String? code,
  }) {
    return PhoneModel(
      number: number ?? this.number,
      code: code ?? this.code,
    );
  }

  @override
  String toString() {
    return 'PhoneModel(number: $number, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneModel &&
        other.number == number &&
        other.code == code;
  }

  @override
  int get hashCode {
    return number.hashCode ^ code.hashCode;
  }
}

@immutable
class AddressModel {
  final String country;
  final String state;
  final String city;
  final String location;
  final String address;

  const AddressModel({
    required this.country,
    required this.state,
    required this.city,
    required this.location,
    required this.address,
  });

 
  Map<String, dynamic> toJson() => {
        'country': country,
        'state': state,
        'city': city,
        'location': location,
        'address': address,
      };

  
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      country: json['country'],
      state: json['state'],
      city: json['city'],
      location: json['location'],
      address: json['address'],
    );
  }

  
  AddressModel copyWith({
    String? country,
    String? state,
    String? city,
    String? location,
    String? address,
  }) {
    return AddressModel(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      location: location ?? this.location,
      address: address ?? this.address,
    );
  }

  @override
  String toString() {
    return 'AddressModel(country: $country, state: $state, city: $city, location: $location, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.country == country &&
        other.state == state &&
        other.city == city &&
        other.location == location &&
        other.address == address;
  }

  @override
  int get hashCode {
    return country.hashCode ^
        state.hashCode ^
        city.hashCode ^
        location.hashCode ^
        address.hashCode;
  }
}
