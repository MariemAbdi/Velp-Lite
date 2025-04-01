import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../validators/validators.dart';
import 'input_field.dart'; // Adjust import path to your InputField

class AppDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final DateTime firstDate, lastDate;
  final String label, hintText;
  final ValueChanged<DateTime> onDateSelected;
  final bool includeTime;

  const AppDatePicker({
    super.key,
    this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.label,
    required this.hintText,
    required this.onDateSelected,
    this.includeTime = false, // Default to calendar only
  });

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      confirmText: "Confirm",
    );

    if (pickedDate != null && context.mounted) {
      if (includeTime) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialEntryMode: TimePickerEntryMode.dialOnly,
          initialTime: selectedDate != null
              ? TimeOfDay.fromDateTime(selectedDate!)
              : TimeOfDay.now(),
        );
        if (pickedTime != null) {
          final combinedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          onDateSelected(combinedDateTime);
        }
      } else {
        onDateSelected(pickedDate); // Only date, no time
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: AbsorbPointer(
        child: InputField(
          readOnly: true,
          label: label,
          validator: Validators.defaultValidation,
          hintText: selectedDate == null
              ? hintText
              : includeTime
                  ? DateFormat('yyyy-MM-dd HH:mm').format(selectedDate!)
                  : DateFormat('yyyy-MM-dd').format(selectedDate!),
          prefixIcon: Icons.calendar_today,
          controller: TextEditingController(
            text: selectedDate != null
                ? (includeTime
                    ? DateFormat('yyyy-MM-dd HH:mm').format(selectedDate!)
                    : DateFormat('yyyy-MM-dd').format(selectedDate!))
                : '',
          ),
        ),
      ),
    );
  }
}
