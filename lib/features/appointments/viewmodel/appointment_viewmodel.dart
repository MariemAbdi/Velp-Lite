import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/pet.dart';
import '../../../../core/models/vet.dart';
import '../../../core/services/database_service.dart';
import '../data/models/appointment.dart';
import '../data/repositories/appointment_repository.dart';

class AppointmentState {
  final List<Appointment> appointments;
  final bool isLoading;
  final String? error;

  AppointmentState({
    required this.appointments,
    this.isLoading = false,
    this.error,
  });

  AppointmentState copyWith({
    List<Appointment>? appointments,
    bool? isLoading,
    String? error,
  }) {
    return AppointmentState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final appointmentProvider =
    StateNotifierProvider<AppointmentViewModel, AppointmentState>((ref) {
  return AppointmentViewModel();
});

class AppointmentViewModel extends StateNotifier<AppointmentState> {
  final AppointmentRepository _repository;

  AppointmentViewModel()
      : _repository = AppointmentRepository(DatabaseService()),
        super(AppointmentState(appointments: [])) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final appointments = await _repository.getAppointments();
      state = AppointmentState(appointments: appointments);
    } catch (e) {
      state = state.copyWith(error: 'Failed to load appointments');
    }
  }

  Future<void> addAppointment(
      {required Pet pet,
      required Vet vet,
      required DateTime dateTime,
      required AppointmentStatus status}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final newAppointment = Appointment(
        pet: pet,
        vet: vet,
        dateTime: dateTime,
        status: status,
      );
      await _repository.addAppointment(newAppointment);
      final appointments = await _repository.getAppointments(); // Refresh list
      state = AppointmentState(appointments: appointments);
    } catch (e) {
      state = state.copyWith(error: 'Failed to add appointment');
    }
  }
}
