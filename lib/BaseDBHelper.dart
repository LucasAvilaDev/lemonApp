import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'src/dbHelper/dbHelperHorario.dart';
import 'src/dbHelper/dbHelperPlan.dart';
import 'src/dbHelper/dbHelperReservas.dart';
import 'src/dbHelper/dbHelperSuscripciones.dart';
import 'src/dbHelper/dbHelperUsuario.dart';

abstract class BaseDBHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await UsuarioDBHelper().createTable(db);
        await PlanDBHelper().createTable(db);
        await SubscriptionDBHelper().createTable(db);
        await HorarioDBHelper().createTable(db);
        await ReservasDBHelper().createTable(db);
      },
    );
  }

  Future<void> closeDB() async {
    final db = await database;
    db.close();
  }
}

