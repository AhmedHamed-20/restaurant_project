import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'date_base_service.dart';

class DatabaseProvider extends DataBaseService {
  late Database _database;
  @override
  Future init(
      {required String databasesName,
      required int version,
      required String query}) async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databasesName);
    _database = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
      await db.execute(query);
    }, onOpen: (createdDatabase) async {
      _database = createdDatabase;
    });
  }

  @override
  Future<List<Map<String, Object?>>> getAllDataFromDatabaseByUserId(
      String tableName, String userId) async {
    return await _database
        .rawQuery('SELECT * FROM $tableName WHERE userId = ?', [userId]);
  }

  @override
  Future<List<Map<String, Object?>>> getAllDataFromDatabaseByRecipeIdAndUserId(
      {required String tableName,
      required String recipeId,
      required String userId}) async {
    return await _database.rawQuery(
        'SELECT * FROM $tableName WHERE recipeId = ? AND userId= ?',
        [recipeId, userId]);
  }

  @override
  Future<int> deleteDataFromDatabaseByDataBaseIdAndUserId(
      {required int dataBaseId,
      required String tableName,
      required String userId}) async {
    return await _database.rawDelete(
        'DELETE FROM $tableName WHERE id = "$dataBaseId" AND userId= "$userId');
  }

  @override
  Future<int> deleteAllDataFromDatabaseByUserId(
      {required String tableName, required String userId}) async {
    return await _database
        .rawDelete('DELETE FROM $tableName WHERE userId= ?', [userId]);
  }

  @override
  Future<int> deleteAllDataCartsFromDatabase(
      {required String tableName}) async {
    return await _database.rawDelete('DELETE FROM $tableName');
  }

  @override
  Future<void> insertIntoDataBase(
      {required List<Object?> data, required String query}) async {
    await _database.execute(
      query,
      data,
    );
  }

  @override
  Future<int> updateDataBase(String query, List arguments) async {
    return await _database.rawUpdate(query, arguments);
  }

  @override
  Future close() async => _database.close();
}
