import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:sqflite/sqflite.dart';

class CartDataBaseFun {
  static Database database;
  static List<Map> CartAndFavorite;
  static void createData() {
    openDatabase(
      'cart.db',
      version: 1,
      onCreate: (createdDataBase, ver) async {
        await createdDataBase
            .execute(
                'CREATE TABLE userdata (id INTEGER PRIMARY KEY,userId TEXT ,recipeName TEXT, photourl TEXT,email TEXT,price TEXT,slug TEXT,isFavorite INTEGER)')
            .then(
              (value) => {
                print('database created'),
              },
            );
      },
      onOpen: (createdDataBase) async {
        await getdataFromDataBase(createdDataBase).then((value) {
          CartAndFavorite = value;
          database = createdDataBase;
        });
        print('database opened');
      },
    ).then((value) {
      database = value;
    });
  }

  static Future<List<Map>> getdataFromDataBase(createdDataBase) async {
    return await createdDataBase.rawQuery('SELECT * FROM userdata');
  }

  static Future<List<Map>> getdataFromDataBaseByID(
      createdDataBase, String id) async {
    return await createdDataBase
        .rawQuery('SELECT * FROM userdata WHERE userId = "$id"');
  }

  static Future<List<Map>> getdataFromDataBaseByIDandFavorite(
      createdDataBase, String id, int isFavorite) async {
    return await createdDataBase.rawQuery(
        'SELECT * FROM userdata WHERE userId = "$id" AND isFavorite=$isFavorite');
  }

  static Future deleteFromDataBase(int id, BuildContext context) async {
    return await database.rawDelete('DELETE FROM userdata').then((value) {
      getdataFromDataBase(database).then((value) {
        CartAndFavorite = value;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  static updateDataBase(int isFavorite, String id, String recipeName) async {
    await database.rawUpdate(
        'UPDATE userdata SET isFavorite = ? WHERE userId = ? AND recipeName= ?',
        [isFavorite, '${id}', '${recipeName}']).then((value) {
      print(value);
    }).catchError((error) {
      print(error);
    });
  }

  static insertIntoDataBase(
      {String userId,
      String recipeName,
      String photourl,
      String email,
      String price,
      String slug,
      int IsFavorite}) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO userdata(userId ,recipeName, photourl, email,price,slug,isFavorite) VALUES(? , ?, ?, ?, ?, ?,?)',
        [
          '${userId}',
          '$recipeName',
          '$photourl',
          '${email}',
          '$price',
          '$slug',
          IsFavorite
        ],
      ).then((value) {
        getdataFromDataBase(database).then((value) {
          CartAndFavorite = value;
          getdataFromDataBaseByID(database, userId).then((value) {
            EndPoints.FilteredCartDataBase = value;
          });
          print(CartAndFavorite);
        });
      });
    });
  }
}
