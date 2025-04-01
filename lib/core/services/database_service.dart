import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    try {
      _database = await _initDatabase();
      return _database!;
    } catch (e) {
      debugPrint('Error initializing database: $e');
      throw Exception('Failed to initialize database');
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pet_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pets (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            chip_number INTEGER,
            name TEXT NOT NULL,
            species INTEGER NOT NULL,
            breed TEXT NOT NULL,
            color INTEGER NOT NULL,
            gender INTEGER NOT NULL,
            weight REAL NOT NULL,
            date_of_birth TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE chats (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            receiver_name TEXT NOT NULL,
            last_message TEXT NOT NULL,
            last_message_date TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            chat_id INTEGER,
            text TEXT NOT NULL,
            timestamp TEXT NOT NULL,
            is_sent_by_user INTEGER NOT NULL,
            FOREIGN KEY (chat_id) REFERENCES chats(id)
          )
        ''');
        await db.execute('''
          CREATE TABLE appointments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pet_id INTEGER NOT NULL,
            vet_first_name TEXT NOT NULL,
            vet_last_name TEXT NOT NULL,
            date_time TEXT NOT NULL,
            status TEXT NOT NULL,
            FOREIGN KEY (pet_id) REFERENCES pets(id)
          )
        ''');
      },
    );
  }
}
