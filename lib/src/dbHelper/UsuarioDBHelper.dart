import 'package:intl/intl.dart';
import 'package:lemon/BaseDBHelper.dart';
import 'package:sqflite/sqlite_api.dart';

class UsuarioDBHelper extends BaseDBHelper {
   @override
  Future<Database> get database async => await super.database;

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        dni TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        user_type TEXT CHECK(user_type IN ('client', 'admin')) DEFAULT 'client'
      )
    ''');
  }

    // Método para insertar un nuevo usuario
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
// Método para obtener usuario por DNI
Future<Map<String, dynamic>?> getUserByDni(String dni) async {
  final db = await database;
  final List<Map<String, dynamic>> result = await db.query('users', where: 'dni = ?', whereArgs: [dni]);
  return result.isNotEmpty ? result.first : null; // Retorna el primer resultado o null si no hay resultados
}


  // Método para obtener usuario por id
  Future<Map<String, Object?>?> getUserById(int id) async {
    final db = await database;
    var result = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first; // Devuelve el primer (y único) resultado
    } else {
      return null; // Si no se encuentra el usuario, devuelve null
    }
  }

  // Método para obtener todos los usuarios
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Método para actualizar un usuario
  Future<void> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  // Método para eliminar un usuario
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Método para realizar el login de un usuario
  Future<Map<String, dynamic>?> loginUser(String dni, String password) async {
    final db = await database;

    // Consulta para verificar el email y contraseña
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'dni = ? AND password = ?',
      whereArgs: [dni, password],
    );

    // Si el resultado no está vacío, significa que el usuario fue encontrado
    if (result.isNotEmpty) {
      return result.first; // Retornamos el primer usuario encontrado
    }

    return null; // Si no se encontró el usuario, retornamos null
  }

  Future<List<Map<String, dynamic>>> getUsersAttendingToday() async {
  // Aquí asumiendo que tienes una tabla de reservas que contiene la fecha de las reservas.
  // Asegúrate de ajustar la consulta a tu esquema de base de datos.

  final today = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(today); // Formato de fecha para la consulta

  final db = await database; // Asumiendo que tienes un método para obtener la base de datos
  final List<Map<String, dynamic>> results = await db.rawQuery(
    'SELECT u.dni, u.first_name FROM users u '
    'JOIN user_reservations r ON u.id = r.user_id '
    'WHERE r.reservation_date = ?',
    [formattedDate],
  );
  print(results);
  return results;
}

  
}
