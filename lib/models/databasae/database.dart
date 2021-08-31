import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseFun {
  static Database database;
  static List<Map> storedData;
  static void createData() {
    openDatabase(
      'user.db',
      version: 1,
      onCreate: (createdDataBase, ver) async {
        await createdDataBase
            .execute(
                'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, photourl TEXT,email TEXT,userId TEXT)')
            .then(
              (value) => {
                print('user database created'),
              },
            );
      },
      onOpen: (createdDataBase) async {
        await getdataFromDataBase(createdDataBase).then((value) {
          storedData = value;
          database = createdDataBase;
        });
        print('database opened');
      },
    ).then((value) {
      database = value;
    });
  }

  static Future<List<Map>> getdataFromDataBase(createdDataBase) async {
    return await createdDataBase.rawQuery('SELECT * FROM user');
  }

  static Future deleteFromDataBase(int id, BuildContext context) async {
    return await database.rawDelete('DELETE FROM user').then((value) {
      getdataFromDataBase(database).then((value) {
        storedData = value;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  static insertIntoDataBase({
    String name,
    String photourl,
    String email,
    String userId,
  }) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO user(name, photourl, email,userId) VALUES(?, ?, ?, ?)',
        [
          '$name',
          '$photourl',
          '${email}',
          ' ${userId}',
        ],
      ).then((value) {
        getdataFromDataBase(database).then((value) {
          storedData = value;
          print(storedData);
        });
      });
    });
  }
}
