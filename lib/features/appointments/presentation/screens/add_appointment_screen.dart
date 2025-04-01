import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/utils/utils.dart';
import 'package:velp_lite/core/widgets/app_dropdown.dart';

import '../../../../core/models/pet.dart';
import '../../../../core/models/vet.dart';
import '../../../../core/providers/vet_provider.dart';
import '../../../../core/widgets/app_date_picker.dart';
import '../../../home/view_model/pet_viewmodel.dart';
import '../../viewmodel/add_appointment_viewmodel.dart';

class AddAppointmentScreen extends ConsumerStatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  AddAppointmentScreenState createState() => AddAppointmentScreenState();
}

class AddAppointmentScreenState extends ConsumerState<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  void _addAppointment() async {
    if (_formKey.currentState?.validate() ?? false) {
      Utils.showLoadingDialog(context);
      final success = await ref.read(addAppointmentProvider.notifier).submit();
      if (!mounted) return;
      Navigator.pop(context); // Hide loading dialog
      if (success) {
        Utils.showSnackBar(
            context, 'Appointment added successfully', Colors.green);
      } else {
        Utils.showSnackBar(
            context, 'Error adding appointment', Colors.redAccent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final addState = ref.watch(addAppointmentProvider);
    final petState = ref.watch(petProvider);
    final pets = petState.pets;
    final vets = ref.watch(vetProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Appointment'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  'Select Pet',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                AppDropdown<Pet>(
                  selectedValue: addState.selectedPet,
                  items: pets,
                  label: 'Select Pet',
                  hintText: pets.isEmpty ? 'No pets available' : 'Choose a pet',
                  onChanged: (pet) =>
                      ref.read(addAppointmentProvider.notifier).setPet(pet),
                  displayText: (Pet? pet) =>
                      pet == null ? 'No pets available' : pet.name,
                ),
                Text(
                  'Select Vet',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                AppDropdown<Vet>(
                  selectedValue: addState.selectedVet,
                  items: vets,
                  icon: Icons.medical_services_rounded,
                  label: 'Select Vet',
                  hintText: vets.isEmpty ? 'No vets available' : 'Choose a vet',
                  onChanged: (vet) =>
                      ref.read(addAppointmentProvider.notifier).setVet(vet),
                  displayText: (Vet? vet) =>
                      vet == null ? 'No vets available' : vet.fullName,
                ),
                AppDatePicker(
                  selectedDate: addState.selectedDateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  label: 'Select Date and Time',
                  hintText: 'Pick a date and time',
                  onDateSelected: (dateTime) => ref
                      .read(addAppointmentProvider.notifier)
                      .setDateTime(dateTime),
                  includeTime: true,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: addState.isSubmitting ? null : _addAppointment,
            child: const Text('Add Appointment'),
          ),
        ),
      ),
    );
  }
}
