class UserProfile {
  String? nameAr;
  String? nameEn;
  String? image;
  List<UserInfoIntersts>? userInfoIntersts;
  int? numberOfFolower;
  int? numberOfFolowing;
  int? numberOfFavouriteEvents;
  int? numberOfLikeEvents;
  String? birthDate;
  int? gender;
  String? currenWork;
  String? yourStudents;
  String? email;
  String? phone;

  UserProfile(
      {this.nameAr,
        this.nameEn,
        this.image,
        this.userInfoIntersts,
        this.numberOfFolower,
        this.numberOfFolowing,
        this.numberOfFavouriteEvents,
        this.numberOfLikeEvents,
        this.birthDate,
        this.gender,
        this.currenWork,
        this.yourStudents,
        this.email,
        this.phone});

  UserProfile.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_Ar'];
    nameEn = json['name_En'];
    image = json['image'];
    if (json['userInfoIntersts'] != null) {
      userInfoIntersts = <UserInfoIntersts>[];
      json['userInfoIntersts'].forEach((v) {
        userInfoIntersts!.add(new UserInfoIntersts.fromJson(v));
      });
    }
    numberOfFolower = json['numberOfFolower'];
    numberOfFolowing = json['numberOfFolowing'];
    numberOfFavouriteEvents = json['numberOfFavouriteEvents'];
    numberOfLikeEvents = json['numberOfLikeEvents'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    currenWork = json['currenWork'];
    yourStudents = json['yourStudents'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_Ar'] = this.nameAr;
    data['name_En'] = this.nameEn;
    data['image'] = this.image;
    if (this.userInfoIntersts != null) {
      data['userInfoIntersts'] =
          this.userInfoIntersts!.map((v) => v.toJson()).toList();
    }
    data['numberOfFolower'] = this.numberOfFolower;
    data['numberOfFolowing'] = this.numberOfFolowing;
    data['numberOfFavouriteEvents'] = this.numberOfFavouriteEvents;
    data['numberOfLikeEvents'] = this.numberOfLikeEvents;
    data['birthDate'] = this.birthDate;
    data['gender'] = this.gender;
    data['currenWork'] = this.currenWork;
    data['yourStudents'] = this.yourStudents;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class UserInfoIntersts {
  String? nameAr;
  String? nameEn;
  String? image;

  UserInfoIntersts({this.nameAr, this.nameEn, this.image});

  UserInfoIntersts.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_Ar'];
    nameEn = json['name_En'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_Ar'] = this.nameAr;
    data['name_En'] = this.nameEn;
    data['image'] = this.image;
    return data;
  }
}