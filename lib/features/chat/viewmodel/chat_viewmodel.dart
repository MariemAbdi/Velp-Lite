import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/database_service.dart';
import '../data/models/chat_model.dart';
import '../data/models/conversation_model.dart';
import '../data/repositories/chat_repository.dart';

class ChatState {
  final List<ChatModel> chats;
  final bool isLoading;
  final String? error;

  ChatState({
    required this.chats,
    this.isLoading = false,
    this.error,
  });
}

class ChatViewModel extends StateNotifier<ChatState> {
  final ChatRepository _repository;

  ChatViewModel(this._repository) : super(ChatState(chats: [])) {
    _init();
  }

  Future<void> _init() async {
    state = ChatState(chats: state.chats, isLoading: true);
    try {
      final chats = await _repository.getChats();
      state = ChatState(chats: chats);
    } catch (e) {
      state = ChatState(chats: state.chats, error: 'Failed to load chats');
    }
  }

  Future<void> addMessage(String receiverName, String messageText) async {
    final newMessage = Message(
      text: messageText,
      timestamp: DateTime.now(),
      isSentByUser: true,
    );
    await _repository.addMessage(receiverName, newMessage);
    await _loadChats();

    Future.delayed(const Duration(seconds: 1), () async {
      final replyMessage = Message(
        text: _generateRandomMessage(),
        timestamp: DateTime.now(),
        isSentByUser: false,
      );
      await _repository.addMessage(receiverName, replyMessage);
      await _loadChats();
    });
  }

  Future<void> _loadChats() async {
    state = ChatState(chats: state.chats, isLoading: true);
    try {
      final chats = await _repository.getChats();
      state = ChatState(chats: chats);
    } catch (e) {
      state = ChatState(chats: state.chats, error: 'Failed to load chats');
    }
  }

  String _generateRandomMessage() {
    final random = Random();
    final length = random.nextInt(20) + 5;
    const chars = 'abcdefghijklmnopqrstuvwxyz';
    return String.fromCharCodes(
      List.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
}

final chatRepositoryProvider =
    Provider((ref) => ChatRepository(DatabaseService()));

final chatProvider = StateNotifierProvider<ChatViewModel, ChatState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatViewModel(repository);
});
