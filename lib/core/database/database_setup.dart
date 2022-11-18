import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static late Database database;
  static Future init(
      {required String databasesName,
      required int version,
      required String query}) async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databasesName);
    database = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
      await db.execute(query);
    }, onOpen: (createdDatabase) async {
      database = createdDatabase;
    });
  }

  static Future<List<Map<String, Object?>>> getAllDataFromDatabaseByUserId(
      String tableName, String userId) async {
    return await database
        .rawQuery('SELECT * FROM $tableName WHERE userId = ?', [userId]);
  }

  static Future<int> deleteDataFromDatabaseByDataBaseIdAndUserId(
      {required int dataBaseId,
      required String tableName,
      required String userId}) async {
    return await database.rawDelete(
        'DELETE FROM $tableName WHERE id = "$dataBaseId" AND userId= "$userId');
  }

  static Future<int> deleteAllDataCartsFromDatabase(
      {required String tableName}) async {
    return await database.rawDelete('DELETE FROM $tableName');
  }

  static Future<void> insertIntoDataBase(
      {required List<Object?> data, required String query}) async {
    await database.execute(
      query,
      data,
    );
  }

  static Future<int> updateDataBase(String query, List arguments) async {
    return await database.rawUpdate(query, arguments);
  }

  static Future close() async => database.close();
}
