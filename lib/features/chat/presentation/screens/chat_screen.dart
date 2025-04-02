import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/widgets/app_listview.dart';
import 'package:velp_lite/core/widgets/app_scaffold.dart';
import 'package:velp_lite/core/widgets/empty_list.dart';
import 'package:velp_lite/features/chat/presentation/widgets/vet_list.dart';

import '../../../../core/providers/vet_provider.dart';
import '../../viewmodel/chat_viewmodel.dart';
import '../widgets/chat_tile.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final chats = chatState.chats;
    final vets = ref.watch(vetProvider);
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      currentRoute: 'Chat',
      body: chatState.isLoading
          ? Center(child: CircularProgressIndicator())
          : chatState.error != null
              ? Center(child: Text(chatState.error!))
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VetList(vets: vets),
                      chats.isEmpty
                          ? Expanded(
                              child: EmptyList(
                                icon: Icons.chat,
                                title: "No chats yet",
                                message: "Start a conversation now!",
                              ),
                            )
                          : Expanded(
                              child: AppListview(
                                padding: const EdgeInsets.all(20),
                                itemCount: chats.length,
                                itemBuilder: (context, index) {
                                  return ChatTile(chat: chats[index]);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
    );
  }
}
