import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velp_lite/core/models/pet.dart';
import 'package:velp_lite/features/home/presentation/widgets/pet_details_item.dart';

class PetDetailsSection extends StatelessWidget {
  const PetDetailsSection({super.key, required this.pet});

  final Pet pet;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 5,
          children: [
            PetDetailsItem(
              icon: Icons.cake,
              label: 'Age',
              value: pet.age,
              color: pet.speciesColor,
            ),
            PetDetailsItem(
              icon: Icons.calendar_today,
              label: 'Birth Date',
              value: DateFormat('dd-MM-yyyy').format(pet.dateOfBirth),
              color: pet.speciesColor,
            ),
            PetDetailsItem(
              icon: Icons.color_lens,
              label: 'Color',
              value: pet.color.displayName,
              color: pet.speciesColor,
            ),
            PetDetailsItem(
              icon: Icons.male,
              label: 'Gender',
              value: pet.gender.displayName,
              color: pet.speciesColor,
            ),
            PetDetailsItem(
              icon: Icons.monitor_weight,
              label: 'Weight',
              value: '${pet.weight} kg',
              color: pet.speciesColor,
            ),
            PetDetailsItem(
              icon: Icons.sim_card_sharp,
              label: 'Chip Number',
              value: "${pet.chipNumber ?? 'N/A'}",
              color: pet.speciesColor,
            ),
          ],
        ),
      ),
    );
  }
}
