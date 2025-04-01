import 'package:flutter/material.dart';

enum PetSpecies {
  dog('Dog'),
  cat('Cat'),
  bird('Bird'),
  rabbit('Rabbit'),
  fish('Fish');

  final String displayName;
  const PetSpecies(this.displayName);
}

enum PetGender {
  female('Female'),
  male('Male');

  final String displayName;
  const PetGender(this.displayName);
}

enum PetColor {
  black('Black'),
  white('White'),
  brown('Brown'),
  gray('Gray'),
  golden('Golden'),
  spotted('Spotted'),
  mixed('Mixed');

  final String displayName;
  const PetColor(this.displayName);
}

class Pet {
  final int? id, chipNumber;
  final String name, breed;
  final PetSpecies species;
  final PetGender gender;
  final PetColor color;
  final double weight;
  final DateTime dateOfBirth;

  Pet({
    this.id,
    this.chipNumber,
    required this.name,
    required this.species,
    required this.breed,
    required this.color,
    required this.gender,
    required this.weight,
    required this.dateOfBirth,
  });

  String get age {
    final now = DateTime.now();
    final difference = now.difference(dateOfBirth);

    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;
    final days = (difference.inDays % 365) % 30;

    if (years > 0) {
      return '$years ${years == 1 ? "year" : "years"} old';
    } else if (months > 0) {
      return '$months ${months == 1 ? "month" : "months"} old';
    } else {
      return '$days ${days == 1 ? "day" : "days"} old';
    }
  }

  String get defaultImage {
    switch (species) {
      case PetSpecies.dog:
        return "https://cdn.pixabay.com/photo/2018/03/31/06/31/dog-3277416_640.jpg";
      case PetSpecies.cat:
        return "https://cdn.pixabay.com/photo/2023/11/02/00/19/ai-generated-8359510_640.jpg";
      case PetSpecies.bird:
        return "https://cdn.pixabay.com/photo/2023/07/24/22/07/european-herring-gull-8147941_640.jpg";
      case PetSpecies.rabbit:
        return "https://cdn.pixabay.com/photo/2014/06/21/08/43/rabbit-373691_640.jpg";
      case PetSpecies.fish:
        return "https://cdn.pixabay.com/photo/2019/10/12/04/59/koi-4543131_640.jpg";
    }
  }

  Color get speciesColor {
    switch (species) {
      case PetSpecies.dog:
        return const Color(0xFF70A9A1);
      case PetSpecies.cat:
        return const Color(0xFFDDB771);
      case PetSpecies.bird:
        return const Color(0xFF90C1E1);
      case PetSpecies.rabbit:
        return const Color(0xFFE07A5F);
      case PetSpecies.fish:
        return const Color(0xFF7CAA2D);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chip_number': chipNumber,
      'name': name,
      'species': species.index,
      'breed': breed,
      'color': color.index,
      'gender': gender.index,
      'weight': weight,
      'date_of_birth': dateOfBirth.toIso8601String(),
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] as int?,
      chipNumber: map['chip_number'] != null
          ? int.tryParse(map['chip_number'].toString())
          : null,
      name: map['name'].toString(),
      species: PetSpecies.values[map['species'] as int],
      breed: map['breed'].toString(),
      color: PetColor.values[map['color'] as int],
      gender: PetGender.values[map['gender'] as int],
      weight: (map['weight'] as num).toDouble(),
      dateOfBirth: DateTime.parse(map['date_of_birth'].toString()),
    );
  }

  Pet copyWith({
    int? id,
    int? chipNumber,
    String? name,
    PetSpecies? species,
    String? breed,
    PetColor? color,
    PetGender? gender,
    double? weight,
    DateTime? dateOfBirth,
  }) {
    return Pet(
      id: id ?? this.id,
      chipNumber: chipNumber ?? this.chipNumber,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      color: color ?? this.color,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
