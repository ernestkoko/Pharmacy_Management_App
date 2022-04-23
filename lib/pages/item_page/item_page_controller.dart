import 'package:get/get.dart';

import '../../data/bag_data.dart';
import '../../data/item_data.dart';
import '../../database/sqlite_database.dart';

class ItemPageController extends GetxController with StateMixin<List<ItemData>>{
  RxBool _isSearch = false.obs;
  RxInt _itemQuantity = 1.obs;
  RxList<int?> itemDataList = <int?>[].obs;
 RxInt _totalAmount = 0.obs;

  // int _totalItemInCart = 0;
@override
onInit(){

  firstLoad();

  super.onInit();

}
@override
onReady(){
  getAllItems();
}
  RxList<ItemData> _data = <ItemData>[].obs;
  static RxList<ItemData> productList = <ItemData>[
    ItemData(
        id: "PahAHGAGI",
        imageUrl: 'assets/image/durofen_pharm.png',
        manufacturerName: 'DUROFEN',
        // itemName: "Glucofen Sulphate  500 mg",
        itemName: "Glucofen Sulphate",
        itemType: "Capsule",
        itemPrice: 300),
    ItemData(
      id: "HJAGjAU",
      imageUrl: 'assets/image/glibofen_pharm.png',

      manufacturerName: "LIPTIPS",
      // itemName: 'GLIBOFEN Tablets 5/850',
      itemName: 'GLIBOFEN Tablets',
      itemType: 'Tablet',
      itemPrice: 400,
    ),
    ItemData(
      id: 'AERjahAY',
      imageUrl: 'assets/image/travegyl_pharm.png',
      manufacturerName: "Martarios",
      itemName: 'Tavegyl Clemastinum1',
      itemType: 'Tablet',
      itemPrice: 700,
    ),
    ItemData(
      id: "YuHahHn",
      imageUrl: 'assets/image/progreffon_pharm.png',
      manufacturerName: "ProgGreffon",
      itemName: '2.468mg Tacrolimus',
      itemType: 'Tablet',
      itemPrice: 739,
    ),
    ItemData(
      id: "5Ggjkjek",
      imageUrl: 'assets/image/disprin_pharm.png',
      manufacturerName: "DISPRIN",
      itemName: 'Disprin Tab',
      itemType: 'Tablet',
      itemPrice: 200,
    ),
    ItemData(
      id: "3uRejsi",
      imageUrl: 'assets/image/aspirin_pharm.png',
      itemName: 'Aspirin Tab 250mg',
      manufacturerName: "DIDI",
      itemType: 'Tablet',
      itemPrice: 204,
    )
  ].obs;

  ///a list of Item data that an external class can access
  // RxList<ItemData> get list {
  //   return _isSearch.value ?_data : productList;
  // }
  firstLoad(){
    change(productList, status: RxStatus.success());
  }

  ///
  // RxList<int?> get itemDatList {
  //   return _itemDataList;
  // }

  int get totalAmount {
    return _totalAmount.value;
  }

  ///get the value of search
  RxBool get isSearch {
    return _isSearch;
  }

  ///set search to true and notify listeners
  void onSearch() {
    _isSearch.value = !_isSearch.value;
    change(productList,status: RxStatus.success());
    //notifyListeners();
  }

  ///off search and notify listiners
  void offSearch() {
    _isSearch.value = false;
    _data = <ItemData>[].obs;
    change(productList,status: RxStatus.success());
   // notifyListeners();
  }

  void search(String text) {

    ///check if the text is empty
    ///if true, set the list to empty list and notify listeners and then return
    if (text.isEmpty) {
      _data = <ItemData>[].obs;
      if(text.isEmpty) change(productList,status: RxStatus.success());
     // notifyListeners();
      return;
    }

    ///if the text is not empty
    ///set the list to empty list and notify listeners
    _data = <ItemData>[].obs;
   // notifyListeners();

    ///declare a variable of type [ItemData]
    //ItemData data;

    ///loop through the original list of ItemData
    for (ItemData data in productList) {
    //  print(data.manufacturerName);
      ///get the manufacturer's name to lower case after trimming both sides
      String manufacturerName = data.manufacturerName.trim().toLowerCase();

      ///if the manufacturer's name matches the text entered by the customer
      ///add the item to the new list
      if (manufacturerName.contains(text.trim().toLowerCase())) {
        print(data.manufacturerName);
        ///add the data to the list
        _data.add(data);
        change(_data, status: RxStatus.success());

        ///notify listeners
       // notifyListeners();
      }
      if(_data.isEmpty) change(null, status: RxStatus.empty());

    }
  }

  int get itemQuantity {
    return _itemQuantity.value;
  }

  void incrementItemQuantity() {
    _itemQuantity++;
    //notifyListeners();
  }

  void decrementItemQuantity() {
    if (_itemQuantity <= 1) {
      return;
    }
    _itemQuantity--;
   // notifyListeners();
  }

  void setItemQuantityToOne() {
    _itemQuantity.value = 1;
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
       // notifyListeners();
        print('Inserted: $res');
      }

      _listOfItem.map((e) async {
        final result = BagData.fromMap(e);
        if (result.itemId == itemId) {
          final qty = int.tryParse(result.quantity!)! + _itemQuantity.value;
          final data =
          BagData(itemId: itemId, quantity: qty.toString()).toMap();
          final _result = await SqLiteDatabase.insertIntoDb(data);

          ///notify the listeners
         // notifyListeners();
          print("Result!: $_result");

          return;
        } else {
          final data =
          BagData(itemId: itemId, quantity: _itemQuantity.toString())
              .toMap();
          final res = await SqLiteDatabase.insertIntoDb(data);
          print("Result: $res");

          ///notify the listeners
          // notifyListeners();
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

   getAllItems() async {
    print("getALlItemsCalled");
    List<ItemData> finalList = [];
    try {
      final list = await getAllCartItems();
      List<int?> dataList = [];
      for (BagData data in list!) {
        productList.map((ItemData e) {
          if (data.itemId == e.id) {
            dataList.add(int.tryParse(data.quantity!));

            finalList.add(e);

          }
        }).toList();
      }

      ///notify listeners

      itemDataList.value = dataList;
      //firstLoad();
      //return finalList;
    } catch (error) {}
  }
}