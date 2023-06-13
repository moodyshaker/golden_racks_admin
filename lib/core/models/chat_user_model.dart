class ChatUserModel {
  String? fromUser;
  String? toUser;
  String? toUserImage;
  String? toUserName;
  String? lastMessage;
  String? lastDate;
  num? eventId;

  ChatUserModel(
      {this.fromUser,
        this.toUser,
        this.toUserImage,
        this.toUserName,
        this.lastMessage,
        this.lastDate,
        this.eventId});

  ChatUserModel.fromJson(Map<String, dynamic> json) {
    fromUser = json['fromUser'];
    toUser = json['toUser'];
    toUserImage = json['toUserImage'];
    toUserName = json['toUserName'];
    lastMessage = json['lastMessage'];
    lastDate = json['lastDate'];
    eventId = json['eventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromUser'] = this.fromUser;
    data['toUser'] = this.toUser;
    data['toUserImage'] = this.toUserImage;
    data['toUserName'] = this.toUserName;
    data['lastMessage'] = this.lastMessage;
    data['lastDate'] = this.lastDate;
    data['eventId'] = this.eventId;
    return data;
  }
}