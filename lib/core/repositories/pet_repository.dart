import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/services/database_service.dart';
import '../models/pet.dart';

class PetRepository {
  final DatabaseService _databaseService;

  PetRepository(this._databaseService);

  Future<List<Pet>> getPets() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('pets');
    debugPrint('Fetched pets from DB: $maps');
    final pets = <Pet>[];
    for (var map in maps) {
      try {
        pets.add(Pet.fromMap(map));
      } catch (e) {
        debugPrint('Error mapping pet: $e for map: $map');
      }
    }
    debugPrint('Mapped pets: $pets');
    return pets;
  }

  Future<int> addPet(Pet pet) async {
    debugPrint('Inserting into pets: ${pet.toMap()}');
    final db = await _databaseService.database;
    try {
      final id = await db.insert(
        'pets',
        pet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('Inserted pet with ID: $id');
      return id;
    } catch (e) {
      debugPrint('Error adding pet: $e');
      throw Exception('Failed to add pet: $e');
    }
  }

  Future<void> deletePet(Pet pet) async {
    final db = await _databaseService.database;
    try {
      await db.delete(
        'pets',
        where: 'id = ?',
        whereArgs: [pet.id],
      );
      debugPrint('Deleted pet with ID: ${pet.id}');
    } catch (e) {
      debugPrint('Error deleting pet: $e');
      throw Exception('Failed to delete pet: $e');
    }
  }
}
