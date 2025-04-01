import 'package:flutter/material.dart';

import '../../../../core/services/database_service.dart';
import '../models/chat_model.dart';
import '../models/conversation_model.dart';

class ChatRepository {
  final DatabaseService _databaseService;

  ChatRepository(this._databaseService);

  Future<List<ChatModel>> getChats() async {
    try {
      final db = await _databaseService.database;
      final chatMaps = await db.query(
        'chats',
        orderBy: 'last_message_date DESC',
      );
      final chats = <ChatModel>[];

      for (var chatMap in chatMaps) {
        final messages = await _getMessagesForChat(chatMap['id'] as int);
        final conversation = ConversationModel(
          receiverName: chatMap['receiver_name'] as String,
          messages: messages,
        );
        chats.add(ChatModel.fromMap(chatMap, conversation));
      }
      return chats;
    } catch (e) {
      debugPrint("Error fetching chats: $e");
      throw Exception('Failed to load chats');
    }
  }

  Future<List<Message>> _getMessagesForChat(int chatId) async {
    try {
      final db = await _databaseService.database;
      final messageMaps = await db.query(
        'messages',
        where: 'chat_id = ?',
        whereArgs: [chatId],
      );
      return messageMaps.map((map) => Message.fromMap(map)).toList();
    } catch (e) {
      debugPrint("Error fetching messages for chat: $e");
      throw Exception('Failed to load messages for chat');
    }
  }

  Future<void> addMessage(String receiverName, Message message) async {
    final db = await _databaseService.database;
    await db.transaction((txn) async {
      try {
        int chatId;
        final existingChats = await txn.query(
          'chats',
          where: 'receiver_name = ?',
          whereArgs: [receiverName],
        );

        // Create a ChatModel instance to use its toMap method
        final chatData = ChatModel(
          id: null, // ID will be set by the database on insert
          receiverName: receiverName,
          lastMessage: message.text,
          lastMessageDate: message.timestamp,
          conversation: ConversationModel(
              receiverName: receiverName, messages: []), // Placeholder
        );

        if (existingChats.isEmpty) {
          chatId = await txn.insert('chats', chatData.toMap());
        } else {
          chatId = existingChats.first['id'] as int;
          await txn.update(
            'chats',
            chatData.toMap()
              ..remove('id'), // Remove 'id' for update to avoid overwriting
            where: 'id = ?',
            whereArgs: [chatId],
          );
        }

        // Prepare message data with chatId
        final messageData = message.toMap()..['chat_id'] = chatId;
        await txn.insert('messages', messageData);
      } catch (e) {
        debugPrint('Error adding message: $e');
        throw Exception('Failed to add message');
      }
    });
  }
}
