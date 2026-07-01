import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:inspirelymd_patient/core/common/models/country/country_model.dart';
import 'package:inspirelymd_patient/core/services/database/countries_seed.dart';

class DatabaseService {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final pathString = join(databasesPath, 'inspirelymd_patient.db');

    return await openDatabase(
      pathString,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    debugPrint('DB_SERVICE: Creating database tables...');
    // Countries Table
    await db.execute('''
      CREATE TABLE countries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        countryName TEXT NOT NULL,
        countryCode TEXT NOT NULL,
        flag TEXT NOT NULL,
        isoCode TEXT NOT NULL,
        digitCount INTEGER NOT NULL,
        timezone TEXT NOT NULL
      )
    ''');

    // Users Table
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        countryCode TEXT NOT NULL,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    // OTP Table
    await db.execute('''
      CREATE TABLE otp_codes (
        phoneNumber TEXT PRIMARY KEY,
        otp TEXT NOT NULL,
        createdAt INTEGER NOT NULL
      )
    ''');

    // Appointments Table
    await db.execute('''
      CREATE TABLE appointments (
        id TEXT PRIMARY KEY,
        doctorName TEXT NOT NULL,
        specialty TEXT NOT NULL,
        dateTime TEXT NOT NULL,
        status TEXT NOT NULL,
        type TEXT NOT NULL
      )
    ''');

    // Prescriptions Table
    await db.execute('''
      CREATE TABLE prescriptions (
        id TEXT PRIMARY KEY,
        medicineName TEXT NOT NULL,
        dosage TEXT NOT NULL,
        frequency TEXT NOT NULL,
        doctorName TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    // Vitals Table
    await db.execute('''
      CREATE TABLE vitals (
        id TEXT PRIMARY KEY,
        heartRate INTEGER NOT NULL,
        bloodPressure TEXT NOT NULL,
        temperature REAL NOT NULL,
        weight REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    // Seed data
    await _seedCountries(db);
    await _seedMockData(db);
  }

  Future<void> _seedCountries(Database db) async {
    final batch = db.batch();
    for (final country in defaultCountries) {
      batch.insert('countries', {
        'countryName': country.countryName,
        'countryCode': country.countryCode,
        'flag': country.flag,
        'isoCode': country.isoCode,
        'digitCount': country.digitCount,
        'timezone': country.timezone,
      });
    }
    await batch.commit(noResult: true);
    debugPrint('DB_SERVICE: Seeded countries.');
  }

  Future<void> _seedMockData(Database db) async {
    final batch = db.batch();

    // Seed dummy user
    batch.insert('users', {
      'id': 'user-1',
      'phoneNumber': '1234567890',
      'countryCode': '+1',
      'name': 'Sarah Mitchell',
      'email': 'sarah.mitchell@gmail.com',
      'createdAt': DateTime.now().toIso8601String(),
    });

    // Seed dummy appointments
    batch.insert('appointments', {
      'id': 'appt-1',
      'doctorName': 'Dr. Sarah Jenkins',
      'specialty': 'Cardiologist',
      'dateTime': DateTime.now().add(const Duration(days: 2, hours: 3)).toIso8601String(),
      'status': 'Upcoming',
      'type': 'In-Person Consultation',
    });
    batch.insert('appointments', {
      'id': 'appt-2',
      'doctorName': 'Dr. Michael Chang',
      'specialty': 'Dermatologist',
      'dateTime': DateTime.now().add(const Duration(days: 5, hours: 1)).toIso8601String(),
      'status': 'Upcoming',
      'type': 'Video Visit',
    });
    batch.insert('appointments', {
      'id': 'appt-3',
      'doctorName': 'Dr. Emily Watson',
      'specialty': 'Primary Care',
      'dateTime': DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      'status': 'Completed',
      'type': 'In-Person Consultation',
    });

    // Seed dummy prescriptions
    batch.insert('prescriptions', {
      'id': 'presc-1',
      'medicineName': 'Lisinopril 10mg',
      'dosage': '1 Tablet',
      'frequency': 'Once daily',
      'doctorName': 'Dr. Sarah Jenkins',
      'date': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
    });
    batch.insert('prescriptions', {
      'id': 'presc-2',
      'medicineName': 'Atorvastatin 20mg',
      'dosage': '1 Tablet',
      'frequency': 'At bedtime',
      'doctorName': 'Dr. Sarah Jenkins',
      'date': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
    });

    // Seed dummy vitals
    batch.insert('vitals', {
      'id': 'vital-1',
      'heartRate': 72,
      'bloodPressure': '120/80',
      'temperature': 98.6,
      'weight': 142.3,
      'date': DateTime.now().toIso8601String(),
    });

    await batch.commit(noResult: true);
    debugPrint('DB_SERVICE: Seeded dashboard mock data.');
  }

  // --- Helpers for query ---
  Future<List<CountryModel>> getCountriesList({String? search}) async {
    final db = await database;
    List<Map<String, dynamic>> results;
    if (search != null && search.isNotEmpty) {
      results = await db.query(
        'countries',
        where: 'countryName LIKE ? OR countryCode LIKE ? OR isoCode LIKE ?',
        whereArgs: ['%$search%', '%$search%', '%$search%'],
        orderBy: 'countryName ASC',
      );
    } else {
      results = await db.query(
        'countries',
        orderBy: 'countryName ASC',
      );
    }
    return results.map((e) => CountryModel.fromJson(e)).toList();
  }

  Future<void> saveOtp(String phoneNumber, String otp) async {
    final db = await database;
    await db.insert(
      'otp_codes',
      {
        'phoneNumber': phoneNumber,
        'otp': otp,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getOtp(String phoneNumber) async {
    final db = await database;
    final results = await db.query(
      'otp_codes',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
    if (results.isNotEmpty) {
      return results.first['otp'] as String;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUser(String phoneNumber, String countryCode) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'phoneNumber = ? AND countryCode = ?',
      whereArgs: [phoneNumber, countryCode],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAppointments() async {
    final db = await database;
    return await db.query('appointments', orderBy: 'dateTime ASC');
  }

  Future<List<Map<String, dynamic>>> getPrescriptions() async {
    final db = await database;
    return await db.query('prescriptions', orderBy: 'date DESC');
  }

  Future<List<Map<String, dynamic>>> getVitals() async {
    final db = await database;
    return await db.query('vitals', orderBy: 'date DESC');
  }
}
