import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String message, title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Icon(icon, size: 80, color: Color(0xFFCCCCCC)),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          Text(message, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
