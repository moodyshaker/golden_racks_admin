import 'package:golden_racks_admin/constants.dart';

class TodayAppointmentModel {
  int? id;
  String? userId;
  int? readyPlanId;
  bool? isFree;
  int? numberOfRacks;
  double? pricePlan;
  String? startDate;
  String? endDate;
  bool? isActive;
  int? numberOfFixedVisits;
  int? numberOEmregencyVisits;
  int? remaningNumberOfFixedVisits;
  int? remaningNumberOEmregencyVisits;
  String? paymentMethod;
  int? transactionId;
  String? planName;
  String? companyName;
  String? address;
  String? ticketNumber;
  String? userImage;
  String? accountNumber;
  String? completeTicketNumber;

  TodayAppointmentModel({
    this.id,
    this.userId,
    this.readyPlanId,
    this.isFree,
    this.numberOfRacks,
    this.pricePlan,
    this.startDate,
    this.endDate,
    this.isActive,
    this.numberOfFixedVisits,
    this.numberOEmregencyVisits,
    this.remaningNumberOfFixedVisits,
    this.remaningNumberOEmregencyVisits,
    this.paymentMethod,
    this.transactionId,
    this.planName,
    this.companyName,
    this.address,
    this.ticketNumber,
    this.userImage,
    this.accountNumber,
    this.completeTicketNumber,
  });

  factory TodayAppointmentModel.fromJson(Map<String, dynamic> json) {
    return TodayAppointmentModel(
      id: json["id"],
      userId: json["userId"],
      readyPlanId: json["readyPlanId"],
      isFree: json["isFree"],
      numberOfRacks: json["numberOfRacks"],
      pricePlan: json["pricePlan"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      isActive: json["isActive"],
      numberOfFixedVisits: json["numberOfFixedVisits"],
      numberOEmregencyVisits: json["numberOEmregencyVisits"],
      remaningNumberOfFixedVisits: json["remaningNumberOfFixedVisits"],
      remaningNumberOEmregencyVisits: json["remaningNumberOEmregencyVisits"],
      paymentMethod: json["paymentMethod"],
      transactionId: json["transactionId"],
      planName: json["planName"],
      companyName: json["companyName"],
      address:
          '${json["address"]['country']} - ${json["address"]['city']} - ${json["address"]['state']} - ${json["address"]['street']}',
      ticketNumber: subtractTicketNumber(json["ticketNumber"]),
      completeTicketNumber: (json["ticketNumber"]),
      userImage: json["userImage"],
      accountNumber: json["accountNumber"],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "userId": userId,
      "readyPlanId": readyPlanId,
      "isFree": isFree,
      "numberOfRacks": numberOfRacks,
      "pricePlan": pricePlan,
      "startDate": startDate,
      "endDate": endDate,
      "isActive": isActive,
      "numberOfFixedVisits": numberOfFixedVisits,
      "numberOEmregencyVisits": numberOEmregencyVisits,
      "remaningNumberOfFixedVisits": remaningNumberOfFixedVisits,
      "remaningNumberOEmregencyVisits": remaningNumberOEmregencyVisits,
      "paymentMethod": paymentMethod,
      "transactionId": transactionId,
      "planName": planName,
      "companyName": companyName,
      "ticketNumber": completeTicketNumber,
      "userImage": userImage,
      "accountNumber": accountNumber,
    };
  }
}
