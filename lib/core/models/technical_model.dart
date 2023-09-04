class Technical {
  String? email;
  String? userName;
  String? mobileNumber;
  String? fullName;
  String? image;
  Technical({
    this.email,
    this.userName,
    this.mobileNumber,
    this.fullName,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'userName': userName,
      'mobileNumber': mobileNumber,
      'fullName': fullName,
      'image': image,
    };
  }

  factory Technical.fromJson(Map<String, dynamic> json) {
    return Technical(
      email: json['email'] != null ? json['email'] as String : null,
      userName: json['userName'] != null ? json['userName'] as String : null,
      mobileNumber:
          json['mobileNumber'] != null ? json['mobileNumber'] as String : null,
      fullName: json['fullName'] != null ? json['fullName'] as String : null,
      image: json['image'] != null ? json['image'] as String : null,
    );
  }
}
