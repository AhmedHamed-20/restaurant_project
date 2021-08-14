import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseFun {
  static Database database;
  static void createData() {
    openDatabase(
      'favorite.db',
      version: 1,
      onCreate: (createdDataBase, ver) {
        createdDataBase
            .execute(
                'CREATE TABLE favorite (id INTEGER PRIMARY KEY, name TEXT, url TEXT)')
            .then(
              (value) => {
                print('database created'),
              },
            );
      },
      onOpen: (createdDataBase) {
        getdataFromDataBase(createdDataBase).then((value) {
          database = createdDataBase;
        });
        print('database opened');
      },
    ).then((value) {
      database = value;
    });
  }

  static Future<List<Map>> getdataFromDataBase(createdDataBase) async {
    return await createdDataBase.rawQuery('SELECT * FROM favorite');
  }

  static void deleteFromDataBase(int id, BuildContext context) async {
    await database
        .rawDelete('DELETE FROM favorite WHERE id = ?', [id]).then((value) {
      getdataFromDataBase(database).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Deleted ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.teal[200],
            duration: Duration(seconds: 2),
          ),
        );
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
