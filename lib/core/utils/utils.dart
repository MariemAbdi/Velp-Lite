import 'package:flutter/material.dart';

class Utils {
  static showSnackBar(BuildContext context, String message, Color color) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
          backgroundColor: color,
        ))
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  static void showConfirmationDialog(BuildContext context, String title,
      String description, void Function() onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              onConfirm();
            },
            child: Text('Confirm',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  static String initials(String fullName) {
    List<String> words =
        fullName.trim().split(RegExp(r'\s+')); // Split by spaces
    return words
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();
  }

  static String capitalizeWords(String input) {
    return input
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }
}
