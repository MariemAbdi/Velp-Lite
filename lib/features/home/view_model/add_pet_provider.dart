import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/utils/utils.dart';
import 'package:velp_lite/features/home/view_model/pet_viewmodel.dart';

import '../../../core/models/pet.dart';
import '../../../core/repositories/pet_repository.dart';

class AddPetState {
  final String name;
  final String breed;
  final PetSpecies species;
  final PetColor color;
  final PetGender gender;
  final double weight;
  final DateTime? dateOfBirth; // Nullable for form state
  final int? chipNumber;
  final bool isLoading;
  final String? error;

  AddPetState({
    this.name = '',
    this.breed = '',
    this.species = PetSpecies.dog,
    this.color = PetColor.black,
    this.gender = PetGender.female,
    this.weight = 0,
    this.dateOfBirth,
    this.chipNumber,
    this.isLoading = false,
    this.error,
  });

  AddPetState copyWith({
    String? name,
    String? breed,
    PetSpecies? species,
    PetColor? color,
    PetGender? gender,
    double? weight,
    DateTime? dateOfBirth,
    int? chipNumber,
    bool? isLoading,
    String? error,
  }) {
    return AddPetState(
      name: name ?? this.name,
      breed: breed ?? this.breed,
      species: species ?? this.species,
      color: color ?? this.color,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      chipNumber: chipNumber ?? this.chipNumber,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AddPetViewModel extends StateNotifier<AddPetState> {
  final PetRepository _repository;

  AddPetViewModel(this._repository) : super(AddPetState());

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setBreed(String breed) {
    state = state.copyWith(breed: breed);
  }

  void setSpecies(PetSpecies species) {
    state = state.copyWith(species: species);
  }

  void setColor(PetColor color) {
    state = state.copyWith(color: color);
  }

  void setGender(PetGender gender) {
    state = state.copyWith(gender: gender);
  }

  void setWeight(double weight) {
    state = state.copyWith(weight: weight);
  }

  void setDateOfBirth(DateTime? date) {
    state = state.copyWith(dateOfBirth: date);
  }

  void setChipNumber(String? chipNumber) {
    state = state.copyWith(chipNumber: int.tryParse(chipNumber ?? ''));
  }

  Future<bool> savePet() async {
    if (state.dateOfBirth == null) {
      state = state.copyWith(error: 'Please select a date of birth');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      final petToSave = Pet(
        name: Utils.capitalizeWords(state.name),
        breed: Utils.capitalizeWords(state.breed),
        species: state.species,
        color: state.color,
        gender: state.gender,
        weight: state.weight,
        dateOfBirth: state.dateOfBirth!, // Non-null guaranteed by validation
        chipNumber: state.chipNumber,
      );
      debugPrint('Attempting to save pet: ${petToSave.toMap()}');
      await _repository.addPet(petToSave);
      debugPrint('Pet saved successfully');
      state = AddPetState(); // Reset to initial state
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to save pet: $e');
      return false;
    }
  }
}

final addPetProvider =
    StateNotifierProvider<AddPetViewModel, AddPetState>((ref) {
  return AddPetViewModel(ref.watch(petRepositoryProvider));
});
