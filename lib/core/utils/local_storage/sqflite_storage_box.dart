import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../app_exports.dart';

/// Minimal synchronous interface to mimic Hive Box usage patterns
abstract class KeyValueStore {
  Future<void> init();
  dynamic get(String key);
  Future<void> put(String key, dynamic value);
  Future<void> delete(String key);
  Future<void> clear();
}

/// A SQLite backed implementation that preloads values into memory
class SqfliteStorageBox implements KeyValueStore {
  Database? _database;
  final Map<String, dynamic> _cache = <String, dynamic>{};
  static const String _tableName = 'key_value_store';
  static const String _keyColumn = 'key';
  static const String _valueColumn = 'value';

  SqfliteStorageBox();

  @override
  Future<void> init() async {
    try {
      // Get the database path
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'local_storage.db');

      // Open the database
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE $_tableName (
              $_keyColumn TEXT PRIMARY KEY,
              $_valueColumn TEXT NOT NULL
            )
          ''');
        },
      );

      // Load all data into cache
      await _loadAllData();
    } catch (e) {
      Logger.lOG('Error initializing SQLite storage: $e');
      rethrow;
    }
  }

  Future<void> _loadAllData() async {
    if (_database == null) return;

    try {
      final List<Map<String, dynamic>> maps = await _database!.query(_tableName);
      for (final map in maps) {
        final key = map[_keyColumn] as String;
        final value = map[_valueColumn] as String;
        _cache[key] = _decode(value);
      }
    } catch (e) {
      Logger.lOG('Error loading data from SQLite: $e');
    }
  }

  @override
  dynamic get(String key) {
    return _cache[key];
  }

  @override
  Future<void> put(String key, dynamic value) async {
    if (_database == null) {
      Logger.lOG('Database not initialized');
      return;
    }

    try {
      _cache[key] = value;
      final encodedValue = _encode(value);

      await _database!.insert(_tableName, {
        _keyColumn: key,
        _valueColumn: encodedValue,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      Logger.lOG('Error storing data in SQLite: $e');
      // Remove from cache if database operation failed
      _cache.remove(key);
    }
  }

  @override
  Future<void> delete(String key) async {
    if (_database == null) {
      Logger.lOG('Database not initialized');
      return;
    }

    try {
      _cache.remove(key);
      await _database!.delete(_tableName, where: '$_keyColumn = ?', whereArgs: [key]);
    } catch (e) {
      Logger.lOG('Error deleting data from SQLite: $e');
    }
  }

  @override
  Future<void> clear() async {
    if (_database == null) {
      Logger.lOG('Database not initialized');
      return;
    }

    try {
      _cache.clear();
      await _database!.delete(_tableName);
    } catch (e) {
      Logger.lOG('Error clearing data from SQLite: $e');
    }
  }

  /// Close the database connection
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  String _encode(dynamic value) {
    if (value == null) return 'N:null';
    if (value is String) return 'S:$value';
    if (value is bool) return 'B:${value ? '1' : '0'}';
    if (value is int) return 'I:$value';
    if (value is double) return 'D:$value';
    // Fallback to JSON
    return 'J:${jsonEncode(value)}';
  }

  dynamic _decode(String raw) {
    if (raw.length < 2 || raw[1] != ':') return raw; // unknown format -> raw string
    final String tag = raw[0];
    final String data = raw.substring(2);
    switch (tag) {
      case 'N':
        return null;
      case 'S':
        return data;
      case 'B':
        return data == '1';
      case 'I':
        return int.tryParse(data);
      case 'D':
        return double.tryParse(data);
      case 'J':
        try {
          return jsonDecode(data);
        } catch (_) {
          return data;
        }
      default:
        return raw;
    }
  }
}
