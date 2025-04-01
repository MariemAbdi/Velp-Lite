class Message {
  final String text;
  final DateTime timestamp;
  final bool isSentByUser;

  Message({
    required this.text,
    required this.timestamp,
    required this.isSentByUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'is_sent_by_user': isSentByUser ? 1 : 0,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      isSentByUser: (map['is_sent_by_user'] as int) == 1,
    );
  }
}

class ConversationModel {
  final String receiverName;
  final List<Message> messages;

  ConversationModel({
    required this.receiverName,
    required this.messages,
  });
}
