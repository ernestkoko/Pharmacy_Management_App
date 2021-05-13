import 'package:dro_pharmacy/database/sqlite_database.dart';

class BagData {
  String? quantity;
  String? itemId;

  BagData({this.quantity, this.itemId});

  BagData.fromMap(Map<String, dynamic> map) {
    this.quantity = map[DbVariables.cartItemQuantity];
    this.itemId = map[DbVariables.tableId];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[DbVariables.tableId] = itemId;
    map[DbVariables.cartItemQuantity] = quantity;
    return map;
  }
}
