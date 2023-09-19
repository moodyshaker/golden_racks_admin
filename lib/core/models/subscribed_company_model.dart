class SubscribedCompanyModel {
  String? userId;
  String? companyName;
  String? userName;
  String? email;
  String? mobileNumber;
  List<SubscriptionsForThisCompany>? subscriptionsForThisCompanies;

  SubscribedCompanyModel({
    this.userId,
    this.companyName,
    this.userName,
    this.email,
    this.mobileNumber,
    this.subscriptionsForThisCompanies,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'companyName': companyName,
      'userName': userName,
      'email': email,
      'mobileNumber': mobileNumber,
      'subscriptionsForThisCompanies':
          subscriptionsForThisCompanies!.map((x) => x.toJson()).toList(),
    };
  }

  factory SubscribedCompanyModel.fromJson(Map<String, dynamic> json) {
    return SubscribedCompanyModel(
      userId: json['userId'] != null ? json['userId'] as String : null,
      companyName:
          json['companyName'] != null ? json['companyName'] as String : null,
      userName: json['userName'] != null ? json['userName'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      mobileNumber:
          json['mobileNumber'] != null ? json['mobileNumber'] as String : null,
      subscriptionsForThisCompanies:
          json['subscriptionsForThisCompanies'] != null
              ? List<SubscriptionsForThisCompany>.from(
                  (json['subscriptionsForThisCompanies'] as List<dynamic>)
                      .map<SubscriptionsForThisCompany?>(
                    (x) => SubscriptionsForThisCompany.fromJson(
                      x as Map<String, dynamic>,
                    ),
                  ),
                )
              : null,
    );
  }
}

class SubscriptionsForThisCompany {
  int? planTypeId;
  String? planType;
  String? startDate;
  String? endDate;
  int? numberOEmregencyVisits;
  int? numberOfFixedVisits;

  SubscriptionsForThisCompany({
    this.planTypeId,
    this.planType,
    this.startDate,
    this.endDate,
    this.numberOEmregencyVisits,
    this.numberOfFixedVisits,
  });

  factory SubscriptionsForThisCompany.fromJson(Map<String, dynamic> json) {
    return SubscriptionsForThisCompany(
      planTypeId: json["planTypeId"],
      planType: json["planType"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      numberOEmregencyVisits: json["numberOEmregencyVisits"],
      numberOfFixedVisits: json["numberOfFixedVisits"],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "planTypeId": planTypeId,
      "planType": planType,
      "startDate": startDate,
      "endDate": endDate,
      "numberOEmregencyVisits": numberOEmregencyVisits,
      "numberOfFixedVisits": numberOfFixedVisits,
    };
  }
}
