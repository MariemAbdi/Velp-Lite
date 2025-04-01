import 'package:flutter/material.dart';

class GreetingsSection extends StatelessWidget {
  const GreetingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelLarge,
        children: [
          TextSpan(
            text: 'Hello, Pet Parent!\n',
          ),
          TextSpan(
            text: 'Your furry friends are waiting.',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
