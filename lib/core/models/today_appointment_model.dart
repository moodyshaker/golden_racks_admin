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
    };
  }
}
