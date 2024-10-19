import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Clase DatabaseHelper que gestiona las operaciones de la base de datos
class DBHelper {
  // Singleton para la base de datos, asegurándonos que solo se crea una instancia
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  // Referencia de la base de datos
  static Database? _database;

  // Método para obtener la base de datos, si no existe, la crea
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Si la base de datos aún no existe, la inicializamos
    _database = await _initDatabase();
    return _database!;
  }

  // Inicialización de la base de datos
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

// Crear tablas en la base de datos
  Future<void> _onCreate(Database db, int version) async {
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

    await db.execute('''
    CREATE TABLE plan(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(100) NOT NULL,
      class_quantity INT DEFAULT 0 CHECK (class_quantity >= 0),
      price DECIMAL(10, 2) CHECK (price >= 0)
    )
    ''');

    // Insertar algunos planes por defecto
    await db.insert('plan', {
      'name': '4 clases',
      'class_quantity': 4,
      'price': 8000,
    });

    await db.insert('plan', {
      'name': '8 clases',
      'class_quantity': 8,
      'price': 10000,
    });

    await db.insert('plan', {
      'name': '12 clases',
      'class_quantity': 12,
      'price': 12000,
    });

    await db.insert('plan', {
      'name': '20 clases',
      'class_quantity': 20,
      'price': 14000,
    });

    await db.execute('''
      CREATE TABLE subscription(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INT,
        plan_id INT,
        start_date TIMESTAMP NOT NULL,
        expiration_date TIMESTAMP NOT NULL,
        remaining_classes INT DEFAULT 0 CHECK (remaining_classes >= 0),
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (plan_id) REFERENCES plan(id)
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
  Future<List<Map<String, dynamic>>> getUserByDni(String dni) async {
    final db = await database;
    return await db.query('users', where: 'dni = ?', whereArgs: [dni]);
  }

  // Método para obtener usuario por DNI
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

  Future<bool> decrementUserClasses(int userId) async {
    var subscription = await getActiveSubscription(userId);

    if (subscription != null && subscription['remaining_classes'] > 0) {
      int updatedClasses = subscription['remaining_classes'] - 1;
      await updateSubscriptionClasses(subscription['id'], updatedClasses);
      return true;
    } else {
      return false; // No hay clases restantes
    }
  }

  Future<void> updateSubscriptionClasses(
      int subscriptionId, int remainingClasses) async {
    final db = await database;
    await db.update('subscription', {'remaining_classes': remainingClasses},
        where: 'id = ?', whereArgs: [subscriptionId]);
  }

  Future<Map<String, dynamic>?> getActiveSubscription(int userId) async {
    final db = await database;

    // Obtener la suscripción más reciente basada en la fecha de expiración
    var result = await db.query(
      'subscription',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'expiration_date DESC',
      limit: 1,
    );

    return result.isNotEmpty ? result.first : null;
  }

  // Insertar un nuevo plan
  Future<void> insertPlan(Map<String, dynamic> plan) async {
    final db = await database;
    await db.insert(
      'plan',
      plan,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtener todos los planes
  Future<List<Map<String, dynamic>>> getPlans() async {
    final db = await database;
    return await db.query('plan');
  }

  // Obtener un plan por ID
  Future<Map<String, dynamic>?> getPlanById(int id) async {
    final db = await database;
    var result = await db.query('plan', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> associatePlanToUser(int userId, int planId) async {
    final db = await database;

    // Aquí puedes agregar la lógica para crear una nueva suscripción o asociación entre el usuario y el plan
    await db.insert('subscription', {
      'user_id': userId,
      'plan_id': planId,
      'remaining_classes':
          await getClassQuantityForPlan(planId), // Cantidad de clases del plan
      'start_date': DateTime.now().toIso8601String(), // Fecha de inicio
      'expiration_date': DateTime.now()
          .add(const Duration(days: 30))
          .toIso8601String(), // Por ejemplo, 30 días de vigencia
    });
  }

// Método para obtener la cantidad de clases del plan
  Future<int> getClassQuantityForPlan(int planId) async {
    final db = await database;
    var result = await db.query('plan', where: 'id = ?', whereArgs: [planId]);

    if (result.isNotEmpty) {
      // Validar que el campo class_quantity sea un entero
      return (result.first['class_quantity'] ?? 0) as int;
    }

    return 0; // Por si no se encuentra el plan
  }
}
