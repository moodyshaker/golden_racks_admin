import 'package:golden_racks_admin/constants.dart';

class UnActivePlanModel {
  int? id;
  String? companyName_Ar;
  String? companyName_En;
  String? accountNumber;
  String? payedWay;
  String? address;
  String? planeName;
  double? planePrice;
  String? ticketNumber;

  UnActivePlanModel({
    this.id,
    this.companyName_Ar,
    this.companyName_En,
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
      'companyName_Ar': companyName_Ar,
      'companyName_En': companyName_En,
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
      companyName_Ar: json['companyName_Ar'] != null
          ? json['companyName_Ar'] as String
          : null,
      companyName_En: json['companyName_En'] != null
          ? json['companyName_En'] as String
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
