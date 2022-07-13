class MessageModel {
  String? title, senderId, recieverId, messageId;

  DateTime? time;

  MessageModel(
      {this.title, this.senderId, this.recieverId, this.messageId, this.time});

  static MessageModel fromJson(Map<String, dynamic> map) {
    MessageModel messageModel = MessageModel(
      title: map['title'],
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      messageId: map['messageId'],
      time: map['time'].toDate(),
    );

    return messageModel;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'title': title,
      'senderId': senderId,
      'recieverId': recieverId,
      'messageId': messageId,
      'time': time,
    };
    return json;
  }
}
