import 'package:lemon/BaseDBHelper.dart';
import 'package:sqflite/sqlite_api.dart';

class SubscriptionDBHelper extends BaseDBHelper{
   @override
  Future<Database> get database async => await super.database;
  Future<void> createTable(Database db) async {
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

  // Devolver el primer resultado como un mapa de datos o null si está vacío
  return result.isNotEmpty ? result.first as Map<String, dynamic> : null;
}


}
