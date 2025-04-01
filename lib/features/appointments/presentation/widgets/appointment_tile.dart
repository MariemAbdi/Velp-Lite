import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/appointment.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;

  const AppointmentTile({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: appointment.getStatusColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              child: Text(
                appointment.status.name.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 12,
                    ),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(appointment.pet.defaultImage),
            ),
            title: Text(appointment.pet.name,
                style: Theme.of(context).textTheme.bodyMedium),
            subtitle: Text(
              DateFormat('MMM d, yyyy - HH:mm').format(appointment.dateTime),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Divider(
            height: 10,
            thickness: 1,
            color: Colors.grey.shade600,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 5,
            children: [
              Text(
                "Dr. ${appointment.vet.fullName}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
