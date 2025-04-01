import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/widgets/app_listview.dart';
import 'package:velp_lite/core/widgets/empty_list.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../viewmodel/appointment_viewmodel.dart';
import '../widgets/appointment_tile.dart';
import 'add_appointment_screen.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentState = ref.watch(appointmentProvider);
    final appointments = appointmentState.appointments;
    void goToAddAppointmentScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddAppointmentScreen()),
      );
    }

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      currentRoute: 'Appointments',
      body: appointmentState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : appointmentState.error != null
              ? Center(child: Text(appointmentState.error!))
              : appointments.isEmpty
                  ? EmptyList(
                      icon: Icons.event,
                      title: 'No appointments yet',
                      message: 'Schedule one now!')
                  : AppListview(
                      padding: const EdgeInsets.all(20),
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = appointments[index];
                        return AppointmentTile(appointment: appointment);
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToAddAppointmentScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
