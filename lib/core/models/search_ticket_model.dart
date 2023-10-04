import 'package:golden_racks_admin/constants.dart';

class SearchTicketModel {
  int? subscribeId;
  String? ticketStatus;
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
  List<ImagesAndVideos>? imagesAndVideos;
  List<ReadyPlanDetails>? readyPlanDetails;
  String? completeTicketNumber;

  SearchTicketModel({
    this.subscribeId,
    this.ticketStatus,
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
    this.completeTicketNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subscribeId': subscribeId,
      'ticketStatus': ticketStatus,
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
      'imagesAndVideos': imagesAndVideos!.map((x) => x.toJson()).toList(),
      'readyPlanDetails': readyPlanDetails!.map((x) => x.toJson()).toList(),
    };
  }

  factory SearchTicketModel.fromJson(Map<String, dynamic> json) {
    return SearchTicketModel(
      subscribeId: json['subscribeId'],
      ticketStatus: json['ticketStatus'],
      ticketNumber: subtractTicketNumber(json['ticketNumber']),
      completeTicketNumber: (json['ticketNumber']),
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
          json['problemName'] != null ? json['problemName'] as String : '',
      sound: json['sound'] != null ? json['sound'] as String : '',
      imagesAndVideos: json['imagesAndVideos'] != null
          ? List<ImagesAndVideos>.from(
              (json['imagesAndVideos'] as List<dynamic>).map<ImagesAndVideos?>(
                (x) => ImagesAndVideos.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
      readyPlanDetails: json['readyPlanDetails'] != null
          ? List<ReadyPlanDetails>.from(
              (json['readyPlanDetails'] as List<dynamic>)
                  .map<ReadyPlanDetails?>(
                (x) => ReadyPlanDetails.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}

class ImagesAndVideos {
  String? fileName;

  ImagesAndVideos({
    this.fileName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fileName': fileName,
    };
  }

  factory ImagesAndVideos.fromJson(Map<String, dynamic> map) {
    return ImagesAndVideos(
      fileName: map['fileName'],
    );
  }
}

class ReadyPlanDetails {
  int? id;
  String? readyPlanName;
  bool? isFree;
  String? activationStartDate;
  String? activationEndDate;
  int? numberOfFixedVisit;
  int? remainingFixedVisit;
  int? numberOfEmeregencyVisit;
  int? remainingOfEmeregencyVisit;
  ReadyPlanDetails({
    this.id,
    this.readyPlanName,
    this.isFree,
    this.activationStartDate,
    this.activationEndDate,
    this.numberOfFixedVisit,
    this.remainingFixedVisit,
    this.numberOfEmeregencyVisit,
    this.remainingOfEmeregencyVisit,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'readyPlanName': readyPlanName,
      'isFree': isFree,
      'activationStartDate': activationStartDate,
      'activationEndDate': activationEndDate,
      'numberOfFixedVisit': numberOfFixedVisit,
      'remainingFixedVisit': remainingFixedVisit,
      'numberOfEmeregencyVisit': numberOfEmeregencyVisit,
      'remainingOfEmeregencyVisit': remainingOfEmeregencyVisit,
    };
  }

  factory ReadyPlanDetails.fromJson(Map<String, dynamic> json) {
    return ReadyPlanDetails(
      id: json['id'] != null ? json['id'] as int : null,
      readyPlanName: json['readyPlanName'] != null
          ? json['readyPlanName'] as String
          : null,
      isFree: json['isFree'] != null ? json['isFree'] as bool : null,
      activationStartDate: json['activationStartDate'] != null
          ? json['activationStartDate'] as String
          : null,
      activationEndDate: json['activationEndDate'] != null
          ? json['activationEndDate'] as String
          : null,
      numberOfFixedVisit: json['numberOfFixedVisit'] != null
          ? json['numberOfFixedVisit'] as int
          : null,
      remainingFixedVisit: json['remainingFixedVisit'] != null
          ? json['remainingFixedVisit'] as int
          : null,
      numberOfEmeregencyVisit: json['numberOfEmeregencyVisit'] != null
          ? json['numberOfEmeregencyVisit'] as int
          : null,
      remainingOfEmeregencyVisit: json['remainingOfEmeregencyVisit'] != null
          ? json['remainingOfEmeregencyVisit'] as int
          : null,
    );
  }
}
