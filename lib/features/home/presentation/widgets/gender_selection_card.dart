import 'package:flutter/material.dart';

import '../../../../core/models/pet.dart';

class GenderCard extends StatelessWidget {
  final PetGender gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Card(
            color: isSelected ? Theme.of(context).primaryColor : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Icon(
                    gender == PetGender.female ? Icons.female : Icons.male,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  Text(gender.displayName,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isSelected ? Colors.white : Colors.black,
                          ))
                ],
              ),
            )),
      ),
    );
  }
}
