import 'package:golden_racks_admin/constants.dart';

class AdminTicketsModel {
  int? id;
  String? companyName;
  String? technicalName;
  String? ticketNumber;
  String? problemName;
  String? createdDate;
  String? typeName;
  String? visitDate;
  String? ticketStatus;
  VisitDetails? visitDetails;
  String? completeTicketNumber;

  AdminTicketsModel({
    this.id,
    this.companyName,
    this.ticketNumber,
    this.problemName,
    this.createdDate,
    this.typeName,
    this.technicalName,
    this.visitDate,
    this.ticketStatus,
    this.completeTicketNumber,
    this.visitDetails,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'companyName': companyName,
      'ticketNumber': completeTicketNumber,
      'problemName': problemName,
      'createdDate': createdDate,
      'typeName': typeName,
      'technicalName': technicalName,
      'visitDate': visitDate,
      'ticketStatus': ticketStatus,
      'visitDetails': visitDetails!.toJson(),
    };
  }

  factory AdminTicketsModel.fromJson(Map<String, dynamic> json) {
    return AdminTicketsModel(
      id: json['id'] != null ? json['id'] as int : null,
      companyName:
          json['companyName'] != null ? json['companyName'] as String : null,
      ticketNumber: subtractTicketNumber(json['ticketNumber']),
      problemName:
          json['problemName'] != null ? json['problemName'] as String : null,
      createdDate:
          json['createdDate'] != null ? json['createdDate'] as String : null,
      typeName: json['typeName'] != null ? json['typeName'] as String : null,
      technicalName: json['technicalName'] != null
          ? json['technicalName'] as String
          : null,
      visitDate: json['visitDate'] != null ? json['visitDate'] as String : null,
      ticketStatus:
          json['ticketStatus'] != null ? json['ticketStatus'] as String : null,
      visitDetails: json['visitDetails'] != null
          ? VisitDetails.fromJson(json['visitDetails'] as Map<String, dynamic>)
          : null,
      completeTicketNumber: json['ticketNumber'],
    );
  }
}

class VisitDetails {
  String? sound;
  String? message;
  String? note;
  String? address;
  String? problemName;
  String? createdDate;
  List<ProblemDetail>? problemDetails;

  VisitDetails({
    this.sound,
    this.message,
    this.note,
    this.address,
    this.problemName,
    this.createdDate,
    this.problemDetails,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sound': sound,
      'message': message,
      'note': note,
      'address': address,
      'problemName': problemName,
      'createdDate': createdDate,
      'problemDetails': problemDetails!.map((x) => x.toJson()).toList(),
    };
  }

  factory VisitDetails.fromJson(Map<String, dynamic> map) {
    return VisitDetails(
      sound: map['sound'] != null ? map['sound'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      problemName:
          map['problemName'] != null ? map['problemName'] as String : null,
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as String : null,
      problemDetails: map['problemDetails'] != null
          ? List<ProblemDetail>.from(
              (map['problemDetails'] as List<dynamic>).map<ProblemDetail?>(
                (x) => ProblemDetail.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class ProblemDetail {
  String? fileName;
  String? createdDate;

  ProblemDetail({
    this.fileName,
    this.createdDate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fileName': fileName,
      'createdDate': createdDate!,
    };
  }

  factory ProblemDetail.fromJson(Map<String, dynamic> json) {
    return ProblemDetail(
      fileName: json['fileName'] != null ? json['fileName'] as String : null,
      createdDate:
          json['createdDate'] != null ? json['createdDate'] as String : null,
    );
  }
}
