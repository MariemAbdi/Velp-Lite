import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/pet.dart';
import 'pet_detail_row.dart';

class PetDetailsContainer extends StatelessWidget {
  final Pet pet;

  const PetDetailsContainer({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    final birthdate = dateFormat.format(pet.dateOfBirth);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PetDetailRow(
                icon: Icons.pets,
                text: pet.breed,
              ),
              PetDetailRow(
                indicator: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: pet.gender == PetGender.male
                        ? const Color(0xFF90C1E1)
                        : const Color(0xFFF7B2BB),
                    shape: BoxShape.circle,
                  ),
                ),
                text: pet.gender.displayName,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PetDetailRow(
                icon: Icons.cake,
                text: birthdate,
              ),
              PetDetailRow(
                icon: Icons.straighten,
                text: '${pet.weight} kg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
