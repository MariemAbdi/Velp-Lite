import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/pet.dart';
import '../../../core/repositories/pet_repository.dart';
import '../../../core/services/database_service.dart';

///FOR HOME SCREEN (list management)
class PetState {
  final List<Pet> pets;
  final bool isLoading;
  final String? error;

  PetState({
    required this.pets,
    this.isLoading = false,
    this.error,
  });

  PetState copyWith({List<Pet>? pets, bool? isLoading, String? error}) {
    return PetState(
      pets: pets ?? this.pets,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class PetViewModel extends StateNotifier<PetState> {
  final PetRepository _repository;

  PetViewModel(this._repository) : super(PetState(pets: [])) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      final pets = await _repository.getPets();
      state = PetState(pets: pets, isLoading: false); // Reset isLoading
    } catch (e) {
      state = PetState(
          pets: state.pets, isLoading: false, error: 'Failed to load pets');
    }
  }

  Future<void> addPet(Pet pet) async {
    await _repository.addPet(pet);
    await refreshPets();
  }

  Future<void> deletePet(Pet pet) async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.deletePet(pet);
      final pets = await _repository.getPets();
      state = PetState(pets: pets);
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete pet');
    }
  }

  Future<void> refreshPets() async {
    state = state.copyWith(isLoading: true);
    try {
      final pets = await _repository.getPets();
      debugPrint('Pets fetched for refresh: $pets');
      state = PetState(pets: pets, isLoading: false);
    } catch (e) {
      debugPrint('Error in refreshPets: $e');
      state = PetState(
          pets: state.pets, isLoading: false, error: 'Failed to load pets');
    }
  }
}

final petRepositoryProvider =
    Provider((ref) => PetRepository(DatabaseService()));

final petProvider = StateNotifierProvider<PetViewModel, PetState>((ref) {
  final repository = ref.watch(petRepositoryProvider);
  return PetViewModel(repository);
});
