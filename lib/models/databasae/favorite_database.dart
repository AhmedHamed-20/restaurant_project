import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDataBaseFun {
  static Database database;
  static List<Map> FavoriteDataBase;
  static void createData() {
    openDatabase(
      'favorite.db',
      version: 1,
      onCreate: (createdDataBase, ver) async {
        await createdDataBase
            .execute(
                'CREATE TABLE favorite (id INTEGER PRIMARY KEY,userId TEXT ,recipeName TEXT, photourl TEXT,email TEXT,price TEXT,slug TEXT,recipeId TEXT)')
            .then(
              (value) => {
                print('favorite database created '),
              },
            );
      },
      onOpen: (createdDataBase) async {
        await getdataFromDataBase(createdDataBase).then((value) {
          FavoriteDataBase = value;
          database = createdDataBase;
        });
        print('favorite database opened');
      },
    ).then((value) {
      database = value;
    });
  }

  static Future<List<Map>> getdataFromDataBase(createdDataBase) async {
    return await createdDataBase.rawQuery('SELECT * FROM favorite');
  }

  static Future<List<Map>> getdataFromDataBaseByID(
      createdDataBase, String id) async {
    return await createdDataBase
        .rawQuery('SELECT * FROM favorite WHERE userId = "$id"');
  }

  static Future<List<Map>> getdataFromDataBaseByIDandFavorite(
      createdDataBase, String id, int isFavorite) async {
    return await createdDataBase.rawQuery(
        'SELECT * FROM favorite WHERE userId = "$id" AND isFavorite=$isFavorite');
  }

  static Future deleteFromDataBase(int id, BuildContext context) async {
    return await database
        .rawDelete('DELETE FROM favorite WHERE id = ?', [id]).then((value) {
      getdataFromDataBase(database).then((value) {
        FavoriteDataBase = value;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  static deleteFromDataBaseName(String name, BuildContext context) async {
    return await database.rawDelete(
        'DELETE FROM favorite WHERE recipeName = ?', [name]).then((value) {
      getdataFromDataBase(database).then((value) {
        FavoriteDataBase = value;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  static updateDataBase(int isFavorite, String id, String recipeName) async {
    await database.rawUpdate(
        'UPDATE favorite SET isFavorite = ? WHERE userId = ? AND recipeName= ?',
        [isFavorite, '${id}', '${recipeName}']).then((value) {
      print(value);
    }).catchError((error) {
      print(error);
    });
  }

  static Future insertIntoDataBase(
      {String userId,
      String recipeName,
      String photourl,
      String email,
      String price,
      String slug,
      String recipeId}) async {
    await database.transaction((txn) async {
      return await txn.rawInsert(
        'INSERT INTO favorite(userId ,recipeName, photourl, email,price,slug,recipeId) VALUES(? , ?, ?, ?, ?,?,?)',
        [
          '${userId}',
          '$recipeName',
          '$photourl',
          '${email}',
          '$price',
          '$slug',
          '$recipeId',
        ],
      ).then((value) {
        getdataFromDataBase(database).then((value) {
          FavoriteDataBase = value;

          print(FavoriteDataBase);
        });
      });
    });
  }
}
