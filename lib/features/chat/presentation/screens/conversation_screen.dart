import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/validators/validators.dart';
import 'package:velp_lite/core/widgets/app_listview.dart';
import 'package:velp_lite/core/widgets/empty_list.dart';
import 'package:velp_lite/core/widgets/input_field.dart';

import '../../data/models/chat_model.dart';
import '../../data/models/conversation_model.dart';
import '../../viewmodel/chat_viewmodel.dart';
import '../widgets/chat_bubble.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  final ChatModel? chat; // Optional existing chat
  final String receiverName; // For new or existing chats

  const ConversationScreen({super.key, required this.receiverName, this.chat});

  @override
  ConversationScreenState createState() => ConversationScreenState();
}

class ConversationScreenState extends ConsumerState<ConversationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_formKey.currentState?.validate() ?? false) {
      final messageText = _messageController.text.trim();
      if (messageText.isEmpty) return;
      ref
          .read(chatProvider.notifier)
          .addMessage(widget.receiverName, messageText);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final existingChat = widget.chat ??
        chatState.chats.firstWhere(
          (chat) => chat.receiverName == widget.receiverName,
          orElse: () => ChatModel(
            id: null,
            receiverName: widget.receiverName,
            lastMessage: '',
            lastMessageDate: DateTime.now(),
            conversation: ConversationModel(
                messages: [], receiverName: widget.receiverName),
          ),
        );
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverName),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: existingChat.conversation.messages.isEmpty
                  ? EmptyList(
                      icon: Icons.chat,
                      title: "Be the first to say hello!",
                      message: "Tap the chat box and start talking!")
                  : AppListview(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: existingChat.conversation.messages.length,
                      itemBuilder: (context, index) {
                        final message = existingChat.conversation.messages[
                            existingChat.conversation.messages.length -
                                1 -
                                index];
                        return ChatBubble(
                          message: message.text,
                          timestamp: message.timestamp,
                          isMe: message.isSentByUser,
                          senderName: message.isSentByUser
                              ? 'You'
                              : widget.receiverName,
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: _messageController,
                        hintText: 'Type a message',
                        validator: Validators.defaultValidation,
                        onSuffixPressed: _messageController.clear,
                      ),
                    ),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
