import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
      required this.isMe,
      required this.senderName,
      required this.message,
      required this.timestamp});

  final String message, senderName;
  final DateTime timestamp;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: MediaQuery.sizeOf(context).width * 0.65,
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).primaryColor : Colors.grey.shade200,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(senderName, style: Theme.of(context).textTheme.labelMedium),
              Text(message, style: Theme.of(context).textTheme.bodySmall),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(DateFormat('HH:mm').format(timestamp),
                    style: Theme.of(context).textTheme.bodySmall),
              )
            ],
          ),
        ),
      ],
    );
  }
}
