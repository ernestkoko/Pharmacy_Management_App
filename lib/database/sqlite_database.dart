import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SqLiteDatabase {
  static Future<sql.Database> _database() async {
    //get the default database path
    final databasePath = await sql.getDatabasesPath();
    //join the path with the name of the app
    final path = join(databasePath, 'dro_pharmacy.db');
    try {
      ///open the database with the path and [onCreate] will be fired the first time
      ///the firebase is opening
      return sql.openDatabase(
        path,
        onCreate: (sql.Database db, int version) => _onCreate(db),
        version: 1,
      );
    } catch (error) {
      rethrow;
    }
  }

  static _onCreate(Database db) async {
    try {
      await db.execute(
          "CREATE TABLE ${DbVariables.tableName}(${DbVariables.tableId} TEXT PRIMARY KEY, ${DbVariables.cartItemQuantity} TEXT)");
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> insertIntoDb(Map<String, dynamic> data) async {
    final db = await SqLiteDatabase._database();

    try {
      print('DB Insert: ');
      return await db.insert(DbVariables.tableName, data,
          conflictAlgorithm: ConflictAlgorithm.replace);


    } catch (error) {
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> readAllBagData() async {
    print('DB Read data:');
    try {
      final db = await SqLiteDatabase._database();
     final result = await db.query(DbVariables.tableName);
      print('DB Read data: $result');
     return result;
    } catch (error) {
      print('Db Read data error: $error');
      rethrow;
    }
  }
}

abstract class DbVariables {
  static const tableName = "cart_item_table";
  static const tableId = "cart_item_table_id";
  static const cartItemQuantity = "cart_item_quantity";
}
