class EventDetailsModel {
  int? eventId;
  String? eventNameAr;
  String? eventNameEn;
  String? aboutEventEn;
  String? aboutEventAr;
  String? eventLocation;
  String? startDate;
  String? endDate;
  String? orgnizerId;
  String? orgnizerNameAr;
  String? orgnizerNameEn;
  String? companyNameAr;
  String? companyNameEn;
  String? orgnizerImage;
  String? locatioMap;
  String? image;
  bool? isLike;
  bool? isFav;
  num? price;
  List<EventProperties>? getEventProperties;
  List<EventSpeakers>? getEventSpeakers;
  List<GetEventusers>? getEventusers;
  List<String>? getEventImages;

  EventDetailsModel(
      {this.eventId,
        this.eventNameAr,
        this.eventNameEn,
        this.aboutEventAr,
        this.aboutEventEn,
        this.eventLocation,
        this.startDate,
        this.endDate,
        this.orgnizerId,
        this.orgnizerNameAr,
        this.orgnizerNameEn,
        this.companyNameAr,
        this.companyNameEn,
        this.orgnizerImage,
        this.locatioMap,
        this.image,
        this.isLike,
        this.isFav,
        this.price,
        this.getEventProperties,
        this.getEventSpeakers,
        this.getEventusers,
        this.getEventImages});

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventNameAr = json['eventName_Ar'];
    eventNameEn = json['eventName_En'];
    aboutEventAr = json['aboutEvent_Ar'];
    aboutEventEn = json['aboutEvent_En'];
    eventLocation = json['event_Location'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    orgnizerId = json['orgnizerId'];
    orgnizerNameAr = json['orgnizerName_Ar'];
    orgnizerNameEn = json['orgnizerName_En'];
    companyNameAr = json['companyName_Ar'];
    companyNameEn = json['companyName_En'];
    orgnizerImage = json['orgnizerImage'];
    locatioMap = json['locatio_Map'];
    image = json['image'];
    isLike = json['isLike'];
    isFav = json['isFav'];
    price = json['price'];
    if (json['getEventProperties'] != null) {
      getEventProperties = <EventProperties>[];
      json['getEventProperties'].forEach((v) {
        getEventProperties!.add(new EventProperties.fromJson(v));
      });
    }
    if (json['getEventSpeakers'] != null) {
      getEventSpeakers = <EventSpeakers>[];
      json['getEventSpeakers'].forEach((v) {
        getEventSpeakers!.add(new EventSpeakers.fromJson(v));
      });
    }
    if (json['getEventusers'] != null) {
      getEventusers = <GetEventusers>[];
      json['getEventusers'].forEach((v) {
        getEventusers!.add(new GetEventusers.fromJson(v));
      });
    }
    if (json['getEventImages'] != null) {
      getEventImages = <String>[];
      json['getEventImages'].forEach((v) {
        getEventImages!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['eventName_Ar'] = this.eventNameAr;
    data['eventName_En'] = this.eventNameEn;
    data['aboutEvent_En'] = this.aboutEventEn;
    data['aboutEvent_Ar'] = this.aboutEventAr;
    data['event_Location'] = this.eventLocation;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['orgnizerId'] = this.orgnizerId;
    data['orgnizerName_Ar'] = this.orgnizerNameAr;
    data['orgnizerName_En'] = this.orgnizerNameEn;
    data['companyName_Ar'] = this.companyNameAr;
    data['companyName_En'] = this.companyNameEn;
    data['orgnizerImage'] = this.orgnizerImage;
    data['locatio_Map'] = this.locatioMap;
    data['image'] = this.image;
    data['isLike'] = this.isLike;
    data['isFav'] = this.isFav;
    data['price'] = this.price;
    if (this.getEventProperties != null) {
      data['getEventProperties'] =
          this.getEventProperties!.map((v) => v.toJson()).toList();
    }
    if (this.getEventSpeakers != null) {
      data['getEventSpeakers'] =
          this.getEventSpeakers!.map((v) => v.toJson()).toList();
    }
    if (this.getEventusers != null) {
      data['getEventusers'] =
          this.getEventusers!.map((v) => v.toJson()).toList();
    }
    if (this.getEventImages != null) {
      data['getEventImages'] =
          this.getEventImages!.toList();
    }
    return data;
  }
}

class EventSpeakers {
  String? id;
  String? fullName;
  String? image;

  EventSpeakers({this.id, this.fullName, this.image});

  EventSpeakers.fromJson(Map<String, dynamic> json) {
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

class EventProperties {
  String? id;
  String? fullName;
  String? image;

  EventProperties({this.id, this.fullName, this.image});

  EventProperties.fromJson(Map<String, dynamic> json) {
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