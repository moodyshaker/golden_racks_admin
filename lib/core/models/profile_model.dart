class ProfileModel {
  String? fullName;
  String? userName;
  String? mobileNumber;
  String? fixedNumber;
  String? email;
  String? companyNameEn;
  String? companyNameAr;
  String? taxNumber;
  String? image;
  String? country;
  int? countryId;
  String? city;
  int? cityId;
  String? state;
  int? stateId;
  String? street;
  String? buildingNumber;

  ProfileModel({
    this.fullName,
    this.userName,
    this.mobileNumber,
    this.fixedNumber,
    this.email,
    this.companyNameEn,
    this.companyNameAr,
    this.taxNumber,
    this.image,
    this.country,
    this.countryId,
    this.city,
    this.cityId,
    this.state,
    this.stateId,
    this.street,
    this.buildingNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullName': fullName,
      'userName': userName,
      'mobileNumber': mobileNumber,
      'fixedNumber': fixedNumber,
      'email': email,
      'companyNameEn': companyNameEn,
      'companyNameAr': companyNameAr,
      'taxNumber': taxNumber,
      'image': image,
      'country': country,
      'countryId': countryId,
      'city': city,
      'cityId': cityId,
      'state': state,
      'stateId': stateId,
      'street': street,
      'buildingNumber': buildingNumber,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] != null ? json['fullName'] as String : '',
      userName: json['userName'] != null ? json['userName'] as String : '',
      mobileNumber:
          json['mobileNumber'] != null ? json['mobileNumber'] as String : '',
      fixedNumber:
          json['fixedNumber'] != null ? json['fixedNumber'] as String : '',
      email: json['email'] != null ? json['email'] as String : '',
      companyNameEn: json['companyName_En'] != null
          ? json['companyName_En'] as String
          : '',
      companyNameAr: json['companyName_Ar'] != null
          ? json['companyName_Ar'] as String
          : '',
      taxNumber: json['taxNumber'] != null ? json['taxNumber'] as String : '',
      image: json['image'] != null ? json['image'] as String : '',
      country: json['country'] != null ? json['country'] as String : '',
      countryId: json['countryId'] != null ? json['countryId'] as int : null,
      city: json['city'] != null ? json['city'] as String : '',
      cityId: json['cityId'] != null ? json['cityId'] as int : null,
      state: json['state'] != null ? json['state'] as String : '',
      stateId: json['stateId'] != null ? json['stateId'] as int : null,
      street: json['street'] != null ? json['street'] as String : '',
      buildingNumber: json['buildingNumber'] != null
          ? json['buildingNumber'] as String
          : '',
    );
  }
}
