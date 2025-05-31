import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/add_expense/data/repository/add_expense_repository.dart';

class SQLiteHelper {
  static Database? _database;
  static const String _dbName = 'masareefi.db';
  static const int _dbVersion = 1;
  static const String _expensesTable = 'expenses';

  static final SQLiteHelper _instance = SQLiteHelper._internal();
  factory SQLiteHelper() => _instance;
  SQLiteHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);

    // ⚠️ DEV ONLY: delete the old database file to reset schema
/*
    if (await File(path).exists()) {
      await File(path).delete();
      logger.w('⚠️ Deleted old DB file for fresh start');
    }
*/

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS $_expensesTable');
        await _createDB(db, newVersion);
        logger.i('✅ DB upgraded from $oldVersion to $newVersion');
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_expensesTable (
        id TEXT PRIMARY KEY,
        category_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        currency TEXT NOT NULL DEFAULT 'EGP',
        converted_amount_usd REAL,
        exchange_rate REAL,
        date TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    logger.i('✅ Expenses table created');
  }

  Future<int> insertExpense(Map<String, dynamic> expense) async {
    try {
      final db = await database;
      expense['created_at'] = DateTime.now().toIso8601String();
      expense['updated_at'] = DateTime.now().toIso8601String();
      final id = await db.insert(_expensesTable, expense);
      logger.i('Inserted expense ID: $id');
      return id;
    } catch (e, st) {
      logger.e('❌ Insert expense failed: $e\n$st');
      rethrow;
    }
  }

  Future<Map<String, double>> getExpensesSummaryByRange(
      DateTime startDate, DateTime endDate) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT 
        SUM(amount) as egp,
        SUM(converted_amount_usd) as usd
      FROM $_expensesTable
      WHERE date >= ? AND date <= ?
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    final row = result.first;
    return {
      'egp': (row['egp'] as num?)?.toDouble() ?? 0.0,
      'usd': (row['usd'] as num?)?.toDouble() ?? 0.0,
    };
  }

  Future<List<Map<String, dynamic>>> getExpensesByDateRangePaginated({
    required DateTime startDate,
    required DateTime endDate,
    int limit = 10,
    int offset = 0,
  }) async {
    final db = await database;
    return await db.query(
      _expensesTable,
      where: 'date >= ? AND date <= ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      limit: limit,
      offset: offset,
      orderBy: 'date DESC, created_at DESC',
    );
  }
}
