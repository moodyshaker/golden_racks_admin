class NotificationModel {
  int? id;
  String? time;
  String? titleen;
  String? titlear;
  String? data;
  bool? isActive;

  NotificationModel({
    this.id,
    this.time,
    this.titleen,
    this.titlear,
    this.data,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'time': time,
      'titleen': titleen,
      'titlear': titlear,
      'data': data,
      'isActive': isActive,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] != null ? json['id'] as int : null,
      time: json['time'] != null ? json['time'] as String : null,
      titleen: json['titleen'] != null ? json['titleen'] as String : null,
      titlear: json['titlear'] != null ? json['titlear'] as String : null,
      data: json['data'] != null ? json['data'] as String : null,
      isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    );
  }
}
