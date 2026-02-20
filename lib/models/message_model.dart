import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String senderId;
  final Timestamp createdAt;
  final String? senderName;

  MessageModel({
    this.senderName,
    required this.message,
    required this.senderId,
    required this.createdAt,
  });

  factory MessageModel.fromJson(messageMap) {
    return MessageModel(
      message: messageMap['message'] ?? '',
      senderId: messageMap['senderId'] ?? false,
      createdAt: messageMap['createdAt'] ?? Timestamp.now(),
      senderName: messageMap['senderName'],
    );
  }
}
