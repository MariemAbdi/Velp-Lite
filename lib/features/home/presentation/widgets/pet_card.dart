import 'package:flutter/material.dart';
import 'package:velp_lite/features/home/presentation/screens/pet_details.dart';
import 'package:velp_lite/features/home/presentation/widgets/pet_details_container.dart';
import 'package:velp_lite/features/home/presentation/widgets/pet_image_overlay.dart';

import '../../../../core/models/pet.dart';

class PetCard extends StatelessWidget {
  const PetCard({super.key, required this.pet});
  final Pet pet;
  @override
  Widget build(BuildContext context) {
    void goToPetDetails() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PetDetailsScreen(pet: pet)),
      );
    }

    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: goToPetDetails,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PetImageOverlay(pet: pet),
                  PetDetailsContainer(pet: pet)
                ]),
          ),
        ),
      ),
    );
  }
}
