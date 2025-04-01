import 'package:flutter/material.dart';

class PetDetailRow extends StatelessWidget {
  final IconData? icon;
  final Widget? indicator; // For custom indicators like gender dot
  final String text;

  const PetDetailRow({
    super.key,
    this.icon,
    this.indicator,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        if (icon != null) Icon(icon, size: 16, color: const Color(0xFF666666)),
        if (indicator != null) indicator!,
        Text(
          text,
          style: TextStyle(color: const Color(0xFF666666), fontSize: 14),
        ),
      ],
    );
  }
}
