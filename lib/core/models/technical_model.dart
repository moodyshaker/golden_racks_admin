class Technical {
  String? userId;
  String? mobileNumber;
  String? email;
  String? fullName;
  String? image;
  String? userName;

  Technical({
    this.userId,
    this.email,
    this.userName,
    this.mobileNumber,
    this.fullName,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'userName': userName,
      'mobileNumber': mobileNumber,
      'fullName': fullName,
      'image': image,
    };
  }

  factory Technical.fromJson(Map<String, dynamic> json) {
    return Technical(
      userId: json['userId'] != null ? json['userId'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      userName: json['userName'] != null ? json['userName'] as String : null,
      mobileNumber:
          json['mobileNumber'] != null ? json['mobileNumber'] as String : null,
      fullName: json['fullName'] != null ? json['fullName'] as String : null,
      image: json['image'] != null ? json['image'] as String : null,
    );
  }
}
