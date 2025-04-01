import 'package:flutter/material.dart';
import 'package:velp_lite/core/models/vet.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/app_listview.dart';
import '../screens/conversation_screen.dart';

class VetList extends StatelessWidget {
  const VetList({super.key, required this.vets});

  final List<Vet> vets;
  @override
  Widget build(BuildContext context) {
    void goToConversationScreen(String vetName) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ConversationScreen(
            receiverName: vetName,
          ),
        ),
      );
    }

    return AppListview(
        padding: EdgeInsets.only(left: 20),
        height: 50,
        itemCount: vets.length,
        itemBuilder: (context, index) {
          final vet = vets[index];
          return InkWell(
            onTap: () => goToConversationScreen(vet.fullName),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(Utils.initials(vet.fullName)),
            ),
          );
        });
  }
}
