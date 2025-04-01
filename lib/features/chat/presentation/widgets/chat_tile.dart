import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/utils.dart';
import '../../data/models/chat_model.dart';
import '../screens/conversation_screen.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chat});

  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    void goToConversation() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ConversationScreen(
            receiverName: chat.receiverName,
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            Utils.initials(chat.receiverName),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
        title: Text(
          chat.receiverName,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            chat.lastMessage,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        trailing: Text(
          DateFormat('HH:mm').format(chat.lastMessageDate),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: goToConversation,
      ),
    );
  }
}
