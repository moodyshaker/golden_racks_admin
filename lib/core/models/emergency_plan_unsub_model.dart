import 'package:golden_racks_admin/constants.dart';

class EmergencyPlanSubModel {
  int? id;
  String? ticketNumber;
  String? userId;
  int? problemId;
  String? problemName;
  String? sound;
  String? message;
  String? notes;
  int? numberOfHours;
  List<ProblemDetails>? problemDetails;
  String? address;
  bool? isRejected;
  String? addedDate;
  String? companyName_Ar;
  String? companyName_En;
  String? accountNumber;
  String? completeTicketNumber;

  EmergencyPlanSubModel({
    this.id,
    this.ticketNumber,
    this.userId,
    this.problemId,
    this.problemName,
    this.sound,
    this.message,
    this.notes,
    this.numberOfHours,
    this.problemDetails,
    this.address,
    this.isRejected,
    this.addedDate,
    this.companyName_Ar,
    this.companyName_En,
    this.accountNumber,
    this.completeTicketNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'ticketNumber': ticketNumber,
      'userId': userId,
      'problemId': problemId,
      'problemName': problemName,
      'sound': sound,
      'message': message,
      'notes': notes,
      'numberOfHours': numberOfHours,
      'problemDetails': problemDetails?.map((x) => x.toJson()).toList(),
      'address': address,
      'isRejected': isRejected,
      'addedDate': addedDate,
      'companyName_Ar': companyName_Ar,
      'companyName_En': companyName_En,
      'accountNumber': accountNumber,
    };
  }

  factory EmergencyPlanSubModel.fromJson(Map<String, dynamic> json) {
    return EmergencyPlanSubModel(
      id: json['id'] != null ? json['id'] as int : null,
      ticketNumber: json['ticketNumber'] != null
          ? subtractTicketNumber(json['ticketNumber'])
          : null,
      completeTicketNumber:
          json['ticketNumber'] != null ? (json['ticketNumber']) : null,
      userId: json['userId'] != null ? json['userId'] as String : null,
      problemId: json['problemId'] != null ? json['problemId'] as int : null,
      problemName:
          json['problemName'] != null ? json['problemName'] as String : null,
      sound: json['sound'] != null ? json['sound'] as String : null,
      message: json['message'] != null ? json['message'] as String : null,
      notes: json['notes'] != null ? json['notes'] as String : null,
      numberOfHours:
          json['numberOfHours'] != null ? json['numberOfHours'] as int : null,
      problemDetails: json['problemDetails'] != null
          ? List<ProblemDetails>.from(
              (json['problemDetails'] as List<dynamic>).map<ProblemDetails?>(
                (x) => ProblemDetails.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      address: json['address'] != null ? json['address'] as String : null,
      isRejected:
          json['isRejected'] != null ? json['isRejected'] as bool : null,
      addedDate: json['addedDate'] != null ? json['addedDate'] as String : null,
      companyName_Ar: json['companyName_Ar'] != null
          ? json['companyName_Ar'] as String
          : null,
      companyName_En: json['companyName_En'] != null
          ? json['companyName_En'] as String
          : null,
      accountNumber: json['accountNumber'] != null
          ? json['accountNumber'] as String
          : null,
    );
  }
}

class ProblemDetails {
  int? visitWithoutSubscripeId;
  String? fileName;
  ProblemDetails({
    this.visitWithoutSubscripeId,
    this.fileName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'visitWithoutSubscripeId': visitWithoutSubscripeId,
      'fileName': fileName,
    };
  }

  factory ProblemDetails.fromJson(Map<String, dynamic> json) {
    return ProblemDetails(
      visitWithoutSubscripeId: json['visitWithoutSubscripeId'] != null
          ? json['visitWithoutSubscripeId'] as int
          : null,
      fileName: json['fileName'] != null ? json['fileName'] as String : null,
    );
  }
}
