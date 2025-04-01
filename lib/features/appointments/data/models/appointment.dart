import 'package:flutter/material.dart';
import 'package:velp_lite/core/models/pet.dart';
import 'package:velp_lite/core/models/vet.dart';

enum AppointmentStatus {
  pending,
  done,
  cancelled,
}

class Appointment {
  final int? id;
  final Pet pet;
  final Vet vet;
  final DateTime dateTime;
  final AppointmentStatus status;

  Appointment({
    this.id,
    required this.pet,
    required this.vet,
    required this.dateTime,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pet_id': pet.id,
      'vet_first_name': vet.firstName,
      'vet_last_name': vet.lastName,
      'date_time': dateTime.toIso8601String(),
      'status': status.name,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map, Pet pet, Vet vet) {
    return Appointment(
      id: map['id'] as int?,
      pet: pet,
      vet: vet,
      dateTime: DateTime.parse(map['date_time'] as String),
      status:
          AppointmentStatus.values.firstWhere((e) => e.name == map['status']),
    );
  }

  Appointment copyWith({
    int? id,
    Pet? pet,
    Vet? vet,
    DateTime? dateTime,
    AppointmentStatus? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      pet: pet ?? this.pet,
      vet: vet ?? this.vet,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
    );
  }

  Color getStatusColor() {
    switch (status) {
      case AppointmentStatus.pending:
        return Colors.orange.withValues(alpha: 0.4);
      case AppointmentStatus.done:
        return Colors.green.withValues(alpha: 0.4);
      case AppointmentStatus.cancelled:
        return Colors.red.withValues(alpha: 0.4);
    }
  }
}
