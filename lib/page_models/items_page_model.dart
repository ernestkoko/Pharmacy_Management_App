import 'package:dro_pharmacy/data/bag_data.dart';
import 'package:dro_pharmacy/data/item_data.dart';
import 'package:dro_pharmacy/database/sqlite_database.dart';
import 'package:flutter/foundation.dart';

class ItemsPageModel with ChangeNotifier {
  bool _isSearch = false;
  int _itemQuantity = 1;
  List<int?> _itemDataList = [];
  int _totalAmount = 2;

  // int _totalItemInCart = 0;

  List<ItemData> _data = [];
  static List<ItemData> productList = [
    ItemData(
        id: "PahAHGAGI",
        imageUrl:
            'https://mir-s3-cdn-cf.behance.net/project_modules/disp/d08c2420185017.5604201066224.jpg',
        manufacturerName: 'DUROFEN',
        // itemName: "Glucofen Sulphate  500 mg",
        itemName: "Glucofen Sulphate",
        itemType: "Capsule",
        itemPrice: 300),
    ItemData(
      id: "HJAGjAU",
      imageUrl:
          "https://i.pinimg.com/originals/69/b8/e1/69b8e14095884291da494a3543f20b11.jpg",
      manufacturerName: "LIPTIPS",
      // itemName: 'GLIBOFEN Tablets 5/850',
      itemName: 'GLIBOFEN Tablets',
      itemType: 'Tablet',
      itemPrice: 400,
    ),
    ItemData(
      id: 'AERjahAY',
      imageUrl:
          "https://mir-s3-cdn-cf.behance.net/project_modules/disp/51adf120185023.5604201011e59.jpg",
      manufacturerName: "Martarios",
      itemName: 'Tavegyl Clemastinum1',
      itemType: 'Tablet',
      itemPrice: 700,
    ),
    ItemData(
      id: "YuHahHn",
      imageUrl:
          "https://mir-s3-cdn-cf.behance.net/project_modules/disp/51adf120185023.5604201011e59.jpg",
      manufacturerName: "NOVARTIS",
      itemName: 'Tavegyl Clemastinum2',
      itemType: 'Tablet',
      itemPrice: 739,
    ),
    ItemData(
      id: "5Ggjkjek",
      imageUrl:
          "https://mir-s3-cdn-cf.behance.net/project_modules/disp/51adf120185023.5604201011e59.jpg",
      manufacturerName: "Emzor",
      itemName: 'Tavegyl Clemastinum3',
      itemType: 'Tablet',
      itemPrice: 200,
    )
  ];

  ///a list of Item data that an external class can access
  List<ItemData> get list {
    return _isSearch ? [..._data] : [...productList];
  }

  ///
  List<int?> get itemDatList {
    return [..._itemDataList];
  }

  int get totalAmount {
    return _totalAmount;
  }

  ///get the value of search
  bool get isSearch {
    return _isSearch;
  }

  ///set search to true and notify listeners
  void onSearch() {
    _isSearch = true;
    notifyListeners();
  }

  ///off search and notify listiners
  void offSearch() {
    _isSearch = false;
    _data = [];
    notifyListeners();
  }

  void search(String text) {
    ///check if the text is empty
    ///if true, set the list to empty list and notify listeners and then return
    if (text.isEmpty) {
      _data = [];
      notifyListeners();
      return;
    }

    ///if the text is not empty
    ///set the list to empty list and notify listeners
    _data = [];
    notifyListeners();

    ///declare a variable of type [ItemData]
    ItemData data;

    ///loop through the original list of ItemData
    for (data in productList) {
      ///get the manufacturer's name to lower case after trimming both sides
      String manufacturerName = data.manufacturerName!.trim().toLowerCase();

      ///if the manufacturer's name matches the text entered by the customer
      ///add the item to the new list
      if (manufacturerName.contains(text.trim().toLowerCase())) {
        ///add the data to the list
        _data.add(data);

        ///notify listeners
        notifyListeners();
      }
    }
  }

  int get itemQuantity {
    return _itemQuantity;
  }

  void incrementItemQuantity() {
    _itemQuantity++;
    notifyListeners();
  }

  void decrementItemQuantity() {
    if (_itemQuantity <= 1) {
      return;
    }
    _itemQuantity--;
    notifyListeners();
  }

  Future<void> addToCart(String itemId) async {
    print('Insert: Called');
    try {
      ///get the list of items in the database to know if the item about to insert
      ///already exists
      final _listOfItem = await SqLiteDatabase.readAllBagData();
      if (_listOfItem.isEmpty) {
        final data =
            BagData(itemId: itemId, quantity: _itemQuantity.toString()).toMap();
        final res = await SqLiteDatabase.insertIntoDb(data);

        ///notify the listeners
        notifyListeners();
        print('Inserted: $res');
      }

      _listOfItem.map((e) async {
        final result = BagData.fromMap(e);
        if (result.itemId == itemId) {
          final qty = int.tryParse(result.quantity!)! + _itemQuantity;
          final data =
              BagData(itemId: itemId, quantity: qty.toString()).toMap();
          final _result = await SqLiteDatabase.insertIntoDb(data);

          ///notify the listeners
          notifyListeners();
          print("Result!: $_result");

          return;
        } else {
          final data =
              BagData(itemId: itemId, quantity: _itemQuantity.toString())
                  .toMap();
          final res = await SqLiteDatabase.insertIntoDb(data);
          print("Result: $res");

          ///notify the listeners
          notifyListeners();
        }
      }).toList();
    } catch (error) {
      print('Error: $error');
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

  Future<List<ItemData>?> getAllItems() async {
    List<ItemData> finalList = [];
    try {
      final list = await getAllCartItems();

      for (BagData data in list!) {
        productList.map((ItemData e) {
          if (data.itemId == e.id) {
            _itemDataList.add(int.tryParse(data.quantity!));
            // _amount += (e.itemPrice! as int) * int.tryParse(data.quantity!)!;
            finalList.add(e);
          }
        }).toList();
      }

      return finalList;
    } catch (error) {}
  }
}
