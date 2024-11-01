import 'package:lemon/BaseDBHelper.dart';
import 'package:sqflite/sqlite_api.dart';

class ReservasDBHelper extends BaseDBHelper{
   @override
  Future<Database> get database async => await super.database;
  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE user_reservations (
        reservation_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        schedule_id INTEGER NOT NULL,
        reservation_date DATE NOT NULL,
        reservation_time TIME NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (schedule_id) REFERENCES available_schedule(id)
      )
    ''');
  }


  


Future<void> insertReservation(int userId, int scheduleId, String date, String time) async {
  final db = await database;
  await db.insert('user_reservations', {
    'user_id': userId,
    'schedule_id': scheduleId,
    'reservation_date': date,
    'reservation_time': time,
  });
}

  Future<void> deleteReservation(int reservationId) async {
  final db = await database; // Asumiendo que tienes tu base de datos inicializada
  await db.delete(
    'user_reservations', // Nombre de la tabla
    where: 'reservation_id = ?', // Condición
    whereArgs: [reservationId], // Argumento
  );
}
}
