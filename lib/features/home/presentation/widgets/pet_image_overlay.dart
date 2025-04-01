import 'package:flutter/material.dart';
import 'package:velp_lite/features/home/presentation/widgets/pet_image.dart';

import '../../../../core/models/pet.dart';

class PetImageOverlay extends StatelessWidget {
  final Pet pet;

  const PetImageOverlay({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PetImage(
          petImageUrl: pet.defaultImage,
          imageHeight: 180,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pet.name,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white, fontSize: 20),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: pet.speciesColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    pet.species.displayName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
