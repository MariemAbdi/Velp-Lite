import 'package:flutter/material.dart';

import '../validators/validators.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final String label, hintText;
  final IconData icon;
  final ValueChanged<T?> onChanged;
  final String Function(T) displayText;
  const AppDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.label,
    required this.hintText,
    required this.onChanged,
    required this.displayText,
    this.icon = Icons.pets,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(displayText(item)),
        );
      }).toList(),
      dropdownColor: Colors.grey.shade300,
      onChanged: onChanged,
      validator: Validators.defaultValidation,
    );
  }
}
