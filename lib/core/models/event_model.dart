class EventModel {
  int? eventId;
  String? eventNameAr;
  String? eventNameEn;
  String? eventLocation;
  String? startDate;
  String? endDate;
  String? locatioMap;
  String? image;
  List<GetEventusers>? getEventusers;
  String? orgnizerId;
  String? orgnizerNameAr;
  String? orgnizerNameEn;
  String? companyNameAr;
  String? companyNameEn;
  String? orgnizerImage;
  bool? isLike;
  bool? isFav;
  int? eventcategoryId;
  String? eventCategoryEn;
  String? eventCategoryAr;
  int? eventTypeId;
  String? eventTypeEn;
  String? eventTypeAr;
  int? eventDateType;

  EventModel(
      {this.eventId,
        this.eventNameAr,
        this.eventNameEn,
        this.eventLocation,
        this.startDate,
        this.endDate,
        this.locatioMap,
        this.image,
        this.getEventusers,
        this.orgnizerId,
        this.orgnizerNameAr,
        this.orgnizerNameEn,
        this.companyNameAr,
        this.companyNameEn,
        this.orgnizerImage,
        this.isLike,
        this.isFav,
        this.eventcategoryId,
        this.eventCategoryEn,
        this.eventCategoryAr,
        this.eventTypeId,
        this.eventTypeEn,
        this.eventTypeAr,
        this.eventDateType});

  EventModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_Id'];
    eventNameAr = json['eventName_Ar'];
    eventNameEn = json['eventName_En'];
    eventLocation = json['event_Location'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    locatioMap = json['locatio_Map'];
    image = json['image'];
    if (json['getEventusers'] != null) {
      getEventusers = <GetEventusers>[];
      json['getEventusers'].forEach((v) {
        getEventusers!.add(new GetEventusers.fromJson(v));
      });
    }
    orgnizerId = json['orgnizerId'];
    orgnizerNameAr = json['orgnizerName_Ar'];
    orgnizerNameEn = json['orgnizerName_En'];
    companyNameAr = json['companyName_Ar'];
    companyNameEn = json['companyName_En'];
    orgnizerImage = json['orgnizerImage'];
    isLike = json['isLike'];
    isFav = json['isFav'];
    eventcategoryId = json['eventcategory_Id'];
    eventCategoryEn = json['event_Category_En'];
    eventCategoryAr = json['event_Category_Ar'];
    eventTypeId = json['eventType_Id'];
    eventTypeEn = json['event_Type_En'];
    eventTypeAr = json['event_Type_Ar'];
    eventDateType = json['eventDateType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_Id'] = this.eventId;
    data['eventName_Ar'] = this.eventNameAr;
    data['eventName_En'] = this.eventNameEn;
    data['event_Location'] = this.eventLocation;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['locatio_Map'] = this.locatioMap;
    data['image'] = this.image;
    if (this.getEventusers != null) {
      data['getEventusers'] =
          this.getEventusers!.map((v) => v.toJson()).toList();
    }
    data['orgnizerId'] = this.orgnizerId;
    data['orgnizerName_Ar'] = this.orgnizerNameAr;
    data['orgnizerName_En'] = this.orgnizerNameEn;
    data['companyName_Ar'] = this.companyNameAr;
    data['companyName_En'] = this.companyNameEn;
    data['orgnizerImage'] = this.orgnizerImage;
    data['isLike'] = this.isLike;
    data['isFav'] = this.isFav;
    data['eventcategory_Id'] = this.eventcategoryId;
    data['event_Category_En'] = this.eventCategoryEn;
    data['event_Category_Ar'] = this.eventCategoryAr;
    data['eventType_Id'] = this.eventTypeId;
    data['event_Type_En'] = this.eventTypeEn;
    data['event_Type_Ar'] = this.eventTypeAr;
    data['eventDateType'] = this.eventDateType;
    return data;
  }
}

class GetEventusers {
  String? id;
  String? fullName;
  String? image;

  GetEventusers({this.id, this.fullName, this.image});

  GetEventusers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}