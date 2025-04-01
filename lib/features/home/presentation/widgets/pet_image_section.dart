import 'package:flutter/material.dart';
import 'package:velp_lite/features/home/presentation/widgets/pet_image.dart';

import '../../../../core/models/pet.dart';

class PetImageSection extends StatelessWidget {
  const PetImageSection({super.key, required this.pet});

  final Pet pet;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PetImage(
          petImageUrl: pet.defaultImage,
          imageHeight: 350,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
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
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Row(
                spacing: 12,
                children: [
                  Text(pet.name, style: Theme.of(context).textTheme.bodyLarge),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: pet.speciesColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      pet.species.displayName,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              Text(
                pet.breed,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
