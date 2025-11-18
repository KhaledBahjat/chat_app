class Message {
  final String message;
  Message({required this.message});
  factory Message.fromJson(json) {
    return Message(
      message: json['body'],
    );
  }
}
