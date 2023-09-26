import 'package:golden_racks_admin/constants.dart';

class AgendaModel {
  String? ticketNumber;
  String? technicalId;
  String? technicalName;
  String? companyId;
  String? companyName;
  String? visitDate;
  int? dailyTaskReturnTypeId;
  String? dailyTaskReturnTypeName;
  String? problemName;
  String? sound;
  List<String>? imagesAndVideos;
  String? readyPlanDetails;

  AgendaModel({
    this.ticketNumber,
    this.technicalId,
    this.technicalName,
    this.companyId,
    this.companyName,
    this.visitDate,
    this.dailyTaskReturnTypeId,
    this.dailyTaskReturnTypeName,
    this.problemName,
    this.sound,
    this.imagesAndVideos,
    this.readyPlanDetails,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ticketNumber': ticketNumber,
      'technicalId': technicalId,
      'technicalName': technicalName,
      'companyId': companyId,
      'companyName': companyName,
      'visitDate': visitDate,
      'dailyTaskReturnTypeId': dailyTaskReturnTypeId,
      'dailyTaskReturnTypeName': dailyTaskReturnTypeName,
      'problemName': problemName,
      'sound': sound,
      'imagesAndVideos': imagesAndVideos,
      'readyPlanDetails': readyPlanDetails,
    };
  }

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    return AgendaModel(
      ticketNumber: subtractTicketNumber(json['ticketNumber']),
      technicalId:
          json['technicalId'] != null ? json['technicalId'] as String : null,
      technicalName: json['technicalName'] != null
          ? json['technicalName'] as String
          : null,
      companyId: json['companyId'] != null ? json['companyId'] as String : null,
      companyName:
          json['companyName'] != null ? json['companyName'] as String : null,
      visitDate: json['visitDate'] != null ? json['visitDate'] as String : null,
      dailyTaskReturnTypeId: json['dailyTaskReturnTypeId'] != null
          ? json['dailyTaskReturnTypeId'] as int
          : null,
      dailyTaskReturnTypeName: json['dailyTaskReturnTypeName'] != null
          ? json['dailyTaskReturnTypeName'] as String
          : null,
      problemName:
          json['problemName'] != null ? json['problemName'] as String : null,
      sound: json['sound'] != null ? json['sound'] as String : null,
      imagesAndVideos: json['imagesAndVideos'] != null
          ? List<String>.from((json['imagesAndVideos'] as List<String>))
          : [],
      readyPlanDetails: json['readyPlanDetails'] != null
          ? json['readyPlanDetails'] as String
          : null,
    );
  }
}
