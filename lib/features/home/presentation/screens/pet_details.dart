import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/utils/utils.dart';

import '../../../../core/models/pet.dart';
import '../../view_model/pet_viewmodel.dart';
import '../widgets/pet_details_section.dart';
import '../widgets/pet_image_section.dart';

class PetDetailsScreen extends ConsumerStatefulWidget {
  final Pet pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  ConsumerState<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends ConsumerState<PetDetailsScreen> {
  Future<void> _deletePet() async {
    if (widget.pet.id == null) {
      Utils.showSnackBar(
          context, 'Cannot delete pet: No ID assigned', Colors.redAccent);
      return;
    }
    Utils.showLoadingDialog(context); // Show loading
    final vm = ref.read(petProvider.notifier);
    await vm.deletePet(widget.pet);
    final state = ref.read(petProvider);
    if (!mounted) return;
    Navigator.pop(context); // Hide loading
    if (state.error == null) {
      Navigator.pop(context, true);
    } else {
      Utils.showSnackBar(
          context, 'Failed to delete pet: ${state.error}', Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(petProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => Utils.showConfirmationDialog(
                context,
                'Delete Pet',
                'Are you sure you want to delete ${widget.pet.name}?',
                _deletePet),
            tooltip: 'Delete Pet',
          ),
        ],
      ),
      body: petState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                PetImageSection(pet: widget.pet),
                PetDetailsSection(pet: widget.pet),
              ],
            ),
    );
  }
}
