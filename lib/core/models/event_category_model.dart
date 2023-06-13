class EventCategoryModel {
  int? id;
  int? count;
  String? nameAr;
  String? nameEn;
  bool? isActive;
  List<SubEventCategoryDtos>? subEventCategoryDtos;
  String? image;
  int? myGetType;
  int? categoryParent;
  int? categoryLevel;
  String? eventCategoryLogo;

  EventCategoryModel(
      {this.id,
      this.count,
      this.nameAr,
      this.nameEn,
      this.isActive,
      this.subEventCategoryDtos,
      this.image,
      this.myGetType,
      this.categoryParent,
      this.categoryLevel,
      this.eventCategoryLogo});

  EventCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    nameAr = json['name_Ar'];
    nameEn = json['name_En'];
    isActive = json['isActive'];
    if (json['subEventCategoryDtos'] != null) {
      subEventCategoryDtos = <SubEventCategoryDtos>[];
      json['subEventCategoryDtos'].forEach((v) {
        subEventCategoryDtos!.add(new SubEventCategoryDtos.fromJson(v));
      });
    }
    image = json['image'];
    myGetType = json['myGetType'];
    categoryParent = json['categoryParent'];
    categoryLevel = json['categoryLevel'];
    eventCategoryLogo = json['eventCategory_Logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['count'] = this.count;
    data['name_Ar'] = this.nameAr;
    data['name_En'] = this.nameEn;
    data['isActive'] = this.isActive;
    if (this.subEventCategoryDtos != null) {
      data['subEventCategoryDtos'] =
          this.subEventCategoryDtos!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['myGetType'] = this.myGetType;
    data['categoryParent'] = this.categoryParent;
    data['categoryLevel'] = this.categoryLevel;
    data['eventCategory_Logo'] = this.eventCategoryLogo;
    return data;
  }
}

class SubEventCategoryDtos {
  int? id;
  String? nameAr;
  String? nameEn;
  bool? isActive;
  int? count;

  SubEventCategoryDtos(
      {this.id, this.nameAr, this.nameEn, this.isActive, this.count});

  SubEventCategoryDtos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_Ar'];
    nameEn = json['name_En'];
    isActive = json['isActive'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_Ar'] = this.nameAr;
    data['name_En'] = this.nameEn;
    data['isActive'] = this.isActive;
    data['count'] = this.count;
    return data;
  }
}
