import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/utils/utils.dart';
import 'package:velp_lite/core/validators/validators.dart';
import 'package:velp_lite/core/widgets/app_date_picker.dart';
import 'package:velp_lite/core/widgets/input_field.dart';

import '../../../../core/models/pet.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../view_model/add_pet_provider.dart';
import '../../view_model/pet_viewmodel.dart';
import '../widgets/gender_selection_card.dart';

class AddPet extends ConsumerStatefulWidget {
  const AddPet({super.key});

  @override
  ConsumerState<AddPet> createState() => _AddPetState();
}

class _AddPetState extends ConsumerState<AddPet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController,
      _breedController,
      _chipController,
      _weightController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _breedController = TextEditingController();
    _chipController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _chipController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _savePet() async {
    if (_formKey.currentState?.validate() ?? false) {
      Utils.showLoadingDialog(context);
      final vm = ref.read(addPetProvider.notifier);
      final isSuccess = await vm.savePet();
      if (isSuccess) {
        await ref.read(petProvider.notifier).refreshPets();
        final petState = ref.read(petProvider);
        debugPrint('Pets after refresh: ${petState.pets}');
        _clearFields();
        if (mounted) {
          Utils.showSnackBar(context, 'Pet added successfully', Colors.green);
        }
      } else {
        final state = ref.read(addPetProvider);
        if (mounted) {
          Utils.showSnackBar(context, state.error!, Colors.redAccent);
        }
      }
      Future.delayed(const Duration(seconds: 2))
          .whenComplete(() => Navigator.pop(context));
    }
  }

  void _clearFields() {
    _nameController.clear();
    _breedController.clear();
    _chipController.clear();
    _weightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final addPetState = ref.watch(addPetProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Pet'),
          centerTitle: true,
        ),
        body: addPetState.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      InputField(
                        controller: _nameController,
                        label: "What's Your Pet's Name?",
                        hintText: "Your Pet's Name",
                        onTap: _nameController.clear,
                        validator: Validators.defaultValidation,
                        prefixIcon: Icons.pets,
                        onChanged: (value) =>
                            ref.read(addPetProvider.notifier).setName(value),
                      ),
                      Text("What's Your Pet's Gender?",
                          style: Theme.of(context).textTheme.labelMedium),
                      Row(
                        spacing: 10,
                        children: PetGender.values.map((gender) {
                          return GenderCard(
                            gender: gender,
                            isSelected: addPetState.gender == gender,
                            onTap: () => ref
                                .read(addPetProvider.notifier)
                                .setGender(gender),
                          );
                        }).toList(),
                      ),
                      InputField(
                        controller: _breedController,
                        label: "What's Your Pet's Breed?",
                        hintText: "Your Pet's Breed",
                        onTap: _breedController.clear,
                        validator: Validators.defaultValidation,
                        prefixIcon: Icons.category,
                        onChanged: (value) =>
                            ref.read(addPetProvider.notifier).setBreed(value),
                      ),
                      Text("What's Your Pet's Species?",
                          style: Theme.of(context).textTheme.labelMedium),
                      AppDropdown<PetSpecies>(
                        selectedValue: addPetState.species,
                        items: PetSpecies.values,
                        label: 'Species',
                        hintText: 'Select Species',
                        onChanged: (value) => ref
                            .read(addPetProvider.notifier)
                            .setSpecies(value!),
                        displayText: (species) => species.displayName,
                      ),
                      AppDatePicker(
                        selectedDate: addPetState.dateOfBirth,
                        firstDate: DateTime(DateTime.now().year - 100),
                        label: "What's Your Pet's Birthday?",
                        hintText: "Your Pet's Birthday",
                        lastDate: DateTime.now(),
                        onDateSelected: (date) => ref
                            .read(addPetProvider.notifier)
                            .setDateOfBirth(date),
                      ),
                      Text("What's Your Pet's Color?",
                          style: Theme.of(context).textTheme.labelMedium),
                      AppDropdown<PetColor>(
                        selectedValue: addPetState.color,
                        items: PetColor.values,
                        label: 'Color',
                        hintText: 'Select Color',
                        onChanged: (value) =>
                            ref.read(addPetProvider.notifier).setColor(value!),
                        displayText: (color) => color.displayName,
                      ),
                      InputField(
                          controller: _weightController,
                          label: "What's Your Pet's Weight?",
                          hintText: "Your Pet's Weight (kg)",
                          onSuffixPressed: _weightController.clear,
                          keyboardType: TextInputType.number,
                          validator: Validators.weightValidation,
                          prefixIcon: Icons.monitor_weight,
                          onChanged: (value) => ref
                              .read(addPetProvider.notifier)
                              .setWeight(double.tryParse(value) ?? 0.0)),
                      InputField(
                          controller: _chipController,
                          onSuffixPressed: _chipController.clear,
                          keyboardType: TextInputType.number,
                          label: "What's Your Pet's Chip Number?",
                          hintText: "Your Pet's Chip Number",
                          maxLength: 10,
                          onChanged: (value) => ref
                              .read(addPetProvider.notifier)
                              .setChipNumber(value),
                          validator: Validators.chipValidation,
                          prefixIcon: Icons.numbers),
                      ElevatedButton(
                          onPressed: addPetState.isLoading ? null : _savePet,
                          child: const Text("SAVE"))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
