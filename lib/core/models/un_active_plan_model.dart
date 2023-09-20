import 'package:golden_racks_admin/constants.dart';

class UnActivePlanModel {
  int? id;
  String? companyNameAr;
  String? companyNameEn;
  String? accountNumber;
  String? payedWay;
  String? address;
  String? planeName;
  double? planePrice;
  String? ticketNumber;

  UnActivePlanModel({
    this.id,
    this.companyNameAr,
    this.companyNameEn,
    this.accountNumber,
    this.payedWay,
    this.address,
    this.planeName,
    this.planePrice,
    this.ticketNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'companyNameAr': companyNameAr,
      'companyNameEn': companyNameEn,
      'accountNumber': accountNumber,
      'payedWay': payedWay,
      'address': address,
      'planeName': planeName,
      'planePrice': planePrice,
      'ticketNumber': ticketNumber,
    };
  }

  factory UnActivePlanModel.fromJson(Map<String, dynamic> json) {
    return UnActivePlanModel(
      id: json['id'] != null ? json['id'] as int : null,
      companyNameAr: json['companyNameAr'] != null
          ? json['companyNameAr'] as String
          : null,
      companyNameEn: json['companyNameEn'] != null
          ? json['companyNameEn'] as String
          : null,
      accountNumber: json['accountNumber'] != null
          ? json['accountNumber'] as String
          : null,
      payedWay: json['payedWay'] != null ? json['payedWay'] as String : null,
      address: json['address'] != null ? json['address'] as String : null,
      planeName: json['planeName'] != null ? json['planeName'] as String : null,
      planePrice:
          json['planePrice'] != null ? json['planePrice'] as double : null,
      ticketNumber: subtractTicketNumber(json['ticketNumber']),
    );
  }
}
