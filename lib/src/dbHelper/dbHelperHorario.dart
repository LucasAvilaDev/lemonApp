import 'package:lemon/BaseDBHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../models/scheduled_model.dart';

class HorarioDBHelper extends BaseDBHelper{
   @override
  Future<Database> get database async => await super.database;

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE available_schedule (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        day VARCHAR(20) NOT NULL,
        available_time TIME NOT NULL,
        max_reservations INTEGER DEFAULT 10,
        current_reservations INTEGER DEFAULT 0
      )
    ''');

    await initializeAvailableSchedule(db);
  }

  Future<void> initializeAvailableSchedule(Database db) async {
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM available_schedule'));
    if (count == 0) {
      await db.transaction((txn) async {
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '09:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '10:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '11:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '12:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '13:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '14:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '15:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '16:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '17:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '18:00:00'});
        await txn.insert('available_schedule',
            {'day': 'lunes', 'available_time': '19:00:00'});
        await txn.insert('available_schedule',
            {'day': 'Lunes', 'available_time': '20:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '09:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '10:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '11:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '12:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '13:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '14:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '15:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '16:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '17:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '18:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '19:00:00'});
        await txn.insert('available_schedule',
            {'day': 'martes', 'available_time': '20:00:00'});

        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '09:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '10:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '11:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '12:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '13:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '14:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '15:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '16:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '17:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '18:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '19:00:00'});
        await txn.insert('available_schedule',
            {'day': 'miércoles', 'available_time': '20:00:00'});

        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '09:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '10:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '11:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '12:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '13:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '14:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '15:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '16:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '17:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '18:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '19:00:00'});
        await txn.insert('available_schedule',
            {'day': 'jueves', 'available_time': '20:00:00'});

        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '09:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '10:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '11:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '12:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '13:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '14:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '15:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '16:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '17:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '18:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '19:00:00'});
        await txn.insert('available_schedule',
            {'day': 'viernes', 'available_time': '20:00:00'});

        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '09:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '10:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '11:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '12:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '13:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '14:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '15:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '16:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '17:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '18:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '19:00:00'});
        await txn.insert('available_schedule',
            {'day': 'sábado', 'available_time': '20:00:00'});

        // Continúa insertando el resto de los días de la semana de manera similar
      });
    }
  }

    
Future<List<Map<String, dynamic>>> getAvailableSchedules(String day) async {
  final db = await database;
  return await db.query(
    'available_schedule',
    columns: ['id AS schedule_id', 'available_time'], // Asegúrate de incluir 'id' como schedule_id
    where: 'day = ?',
    whereArgs: [day],
  );
}

  Future<List<ScheduledClass>> getScheduledClasses(int userId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'user_reservations',
    where: 'user_id = ?',
    whereArgs: [userId],
  );

  print(maps);

  return List.generate(maps.length, (i) {
    return ScheduledClass.fromMap(maps[i]);
  });
}


}
