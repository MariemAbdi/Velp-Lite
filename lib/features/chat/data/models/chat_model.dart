import 'conversation_model.dart';

class ChatModel {
  final int? id;
  final String receiverName;
  final String lastMessage;
  final DateTime lastMessageDate;
  final ConversationModel conversation;

  ChatModel({
    this.id,
    required this.receiverName,
    required this.lastMessage,
    required this.lastMessageDate,
    required this.conversation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'receiver_name': receiverName,
      'last_message': lastMessage,
      'last_message_date': lastMessageDate.toIso8601String(),
    };
  }

  factory ChatModel.fromMap(
      Map<String, dynamic> map, ConversationModel conversation) {
    return ChatModel(
      id: map['id'] as int,
      receiverName: map['receiver_name'] as String,
      lastMessage: map['last_message'] as String,
      lastMessageDate: DateTime.parse(map['last_message_date'] as String),
      conversation: conversation,
    );
  }

  ChatModel copyWith({
    int? id,
    String? receiverName,
    String? lastMessage,
    DateTime? lastMessageDate,
    ConversationModel? conversation,
  }) {
    return ChatModel(
      id: id ?? this.id,
      receiverName: receiverName ?? this.receiverName,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageDate: lastMessageDate ?? this.lastMessageDate,
      conversation: conversation ?? this.conversation,
    );
  }
}
