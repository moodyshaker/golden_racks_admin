class EventTypeModel {
  int? id;
  String? nameAr;
  String? nameEn;
  bool? isActive;
  String? image;
  String? oldEventTypeImage;

  EventTypeModel({this.id,
      this.nameAr,
      this.nameEn,
      this.isActive,
      this.image,
      this.oldEventTypeImage});

  EventTypeModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nameAr = json['name_Ar'];
    nameEn = json['name_En'];
    isActive = json['isActive'];
    image = json['image'];
    oldEventTypeImage = json['old_EventType_Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_Ar'] = this.nameAr;
    data['name_En'] = this.nameEn;
    data['isActive'] = this.isActive;
    data['image'] = this.image;
    data['old_EventType_Image'] = this.oldEventTypeImage;
    return data;
  }
}