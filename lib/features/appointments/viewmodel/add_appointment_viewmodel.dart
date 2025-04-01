import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/pet.dart';
import '../../../core/models/vet.dart';
import '../data/models/appointment.dart';
import 'appointment_viewmodel.dart';

class AddAppointmentState {
  final Pet? selectedPet;
  final Vet? selectedVet;
  final DateTime? selectedDateTime;
  final bool isSubmitting;

  AddAppointmentState({
    this.selectedPet,
    this.selectedVet,
    this.selectedDateTime,
    this.isSubmitting = false,
  });

  AddAppointmentState copyWith({
    Pet? selectedPet,
    Vet? selectedVet,
    DateTime? selectedDateTime,
    bool? isSubmitting,
  }) {
    return AddAppointmentState(
      selectedPet: selectedPet ?? this.selectedPet,
      selectedVet: selectedVet ?? this.selectedVet,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class AddAppointmentViewModel extends StateNotifier<AddAppointmentState> {
  final Ref ref;

  AddAppointmentViewModel(this.ref) : super(AddAppointmentState()) {}

  void setPet(Pet? pet) {
    state = state.copyWith(selectedPet: pet);
  }

  void setVet(Vet? vet) {
    state = state.copyWith(selectedVet: vet);
  }

  void setDateTime(DateTime? dateTime) {
    state = state.copyWith(selectedDateTime: dateTime);
  }

  Future<bool> submit() async {
    // Create a Random instance
    final random = Random();
    // Pick a random status from AppointmentStatus.values
    final randomStatus = AppointmentStatus
        .values[random.nextInt(AppointmentStatus.values.length)];

    final appointment = Appointment(
      id: null,
      pet: state.selectedPet!,
      vet: state.selectedVet!,
      dateTime: state.selectedDateTime!,
      status: randomStatus, // Assign random status
    );

    state = state.copyWith(isSubmitting: true);
    try {
      await ref.read(appointmentProvider.notifier).addAppointment(
            pet: appointment.pet,
            vet: appointment.vet,
            dateTime: appointment.dateTime,
            status: appointment.status,
          );
      state = AddAppointmentState(
        selectedPet: null,
        selectedVet: null,
        selectedDateTime: null,
        isSubmitting: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      return false;
    }
  }
}

final addAppointmentProvider = StateNotifierProvider.autoDispose<
    AddAppointmentViewModel, AddAppointmentState>((ref) {
  return AddAppointmentViewModel(ref);
});
