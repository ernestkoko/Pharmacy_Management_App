import 'package:dro_pharmacy/data/bag_data.dart';
import 'package:dro_pharmacy/database/sqlite_database.dart';
import 'package:flutter/foundation.dart';

class BagPageModel extends ChangeNotifier {
  bool _expanded = false;

  bool get expanded{
    return _expanded;
  }
  ///[updateItem] will update the item with [id] and [quantity] in the db
  Future<int> updateItem(String id, String quantity) async {
    try {
      final result = SqLiteDatabase.updateItem(id, quantity);

      ///notify listeners
      notifyListeners();
      return result;
    } catch (error) {
      rethrow;
    }
  }

  ///[delete] deletes an item with the given [id] in the database table
  Future<int?> deleteItem(String id) async {
    try {
      final result = await SqLiteDatabase.deleteItem(id);

      ///notify listeners
      notifyListeners();
      return result;
    } catch (error) {
      rethrow;
    }
  }

  ///read all the data from db
  Future<List<BagData>?> getAllCartItems() async {
    try {
      final _result = await SqLiteDatabase.readAllBagData();

      final finalResult = _result.map((e) => BagData.fromMap(e)).toList();
      return finalResult;
    } catch (error) {
      rethrow;
    }
  }
}
