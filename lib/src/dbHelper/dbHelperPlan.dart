import 'package:sqflite/sqlite_api.dart';

import '../../BaseDBHelper.dart';

class PlanDBHelper extends BaseDBHelper {
  @override
  Future<Database> get database async => await super.database;
  
  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE plan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL,
        class_quantity INT DEFAULT 0 CHECK (class_quantity >= 0),
        price DOUBLE(10, 2) CHECK (price >= 0)
      )
    ''');

    await _insertDefaultPlans(db);
  }

  Future<void> _insertDefaultPlans(Database db) async {
    List<Map<String, dynamic>> defaultPlans = [
      {'name': 'Fit Express', 'class_quantity': 4, 'price': 8000},
      {'name': 'Power Boost', 'class_quantity': 8, 'price': 10000},
      {'name': 'Super Fit', 'class_quantity': 12, 'price': 12000},
      {'name': 'Ultimate Warrior', 'class_quantity': 20, 'price': 14000},
    ];

    for (var plan in defaultPlans) {
      await db.insert('plan', plan);
    }
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
