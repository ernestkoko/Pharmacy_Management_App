import 'package:dro_pharmacy/pages/item_page/item_page_controller.dart';
import 'package:get/get.dart';

import '../../data/bag_data.dart';
import '../../data/item_data.dart';
import '../../database/sqlite_database.dart';

class ItemDetailsController extends GetxController
    with StateMixin<List<BagData>> {
  bool _isSearch = false;
  RxInt itemQuantity = 1.obs;
  RxList<int?> _itemDataList = <int?>[].obs;
  int _totalAmount = 0;
  final bagDataList = <BagData>[].obs;
  final item = Get.arguments;
 // RxList<int?> _itemDataList = <int?>[].obs;

  // int _totalItemInCart = 0;

  List<ItemData> _data = [];

  @override
  onInit() {
    getAllCartItems();
    super.onInit();
  }

  ///a list of Item data that an external class can access
  List<ItemData> get list {
    return _isSearch ? [..._data] : ItemPageController.productList;
  }

  ///
  RxList<int?> get itemDatList {
    return _itemDataList;
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
    //notifyListeners();
  }

  ///off search and notify listiners
  void offSearch() {
    _isSearch = false;
    _data = [];
    //  notifyListeners();
  }

  void search(String text) {
    ///check if the text is empty
    ///if true, set the list to empty list and notify listeners and then return
    if (text.isEmpty) {
      _data = [];
      // notifyListeners();
      return;
    }

    ///if the text is not empty
    ///set the list to empty list and notify listeners
    _data = [];
    // notifyListeners();

    ///declare a variable of type [ItemData]
    ItemData data;

    ///loop through the original list of ItemData
    for (data in ItemPageController.productList) {
      ///get the manufacturer's name to lower case after trimming both sides
      String manufacturerName = data.manufacturerName.trim().toLowerCase();

      ///if the manufacturer's name matches the text entered by the customer
      ///add the item to the new list
      if (manufacturerName.contains(text.trim().toLowerCase())) {
        ///add the data to the list
        _data.add(data);

        ///notify listeners
        // notifyListeners();
      }
    }
  }

  // int get itemQuantity {
  //   return _itemQuantity;
  // }

  void incrementItemQuantity() {
    itemQuantity.value++;
    // notifyListeners();
  }

  void decrementItemQuantity() {
    if (itemQuantity.value <= 1) {
      return;
    }
    itemQuantity.value--;
    //  notifyListeners();
  }

  void setItemQuantityToOne() {
    itemQuantity.value = 1;
  }

  Future<void> addToCart(String itemId) async {
    print('Insert: Called');
    try {
      ///get the list of items in the database to know if the item about to insert
      ///already exists
      final _listOfItem = await SqLiteDatabase.readAllBagData();
      if (_listOfItem.isEmpty) {
        final data =
            BagData(itemId: itemId, quantity: itemQuantity.value.toString())
                .toMap();
       await SqLiteDatabase.insertIntoDb(data);



        ///notify the listeners
        //notifyListeners();

      }

      _listOfItem.map((e) async {
        final result = BagData.fromMap(e);
        if (result.itemId == itemId) {
          final qty = int.tryParse(result.quantity!)! + itemQuantity.value;
          final data =
              BagData(itemId: itemId, quantity: qty.toString()).toMap();
          final _result = await SqLiteDatabase.insertIntoDb(data);

          ///notify the listeners
          //notifyListeners();
          print("Result!: $_result");

          return;
        } else {
          final data =
              BagData(itemId: itemId, quantity: itemQuantity.value.toString())
                  .toMap();
          final res = await SqLiteDatabase.insertIntoDb(data);
          print("Result: $res");

          ///notify the listeners
          //notifyListeners();
        }
      }).toList();
      ///update listeners
      await getAllCartItems();
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  ///read all the data from db
  Future<List<BagData>?> getAllCartItems() async {
    change(null, status: RxStatus.loading());
    try {
      final _result = await SqLiteDatabase.readAllBagData();

      final finalResult = _result.map((e) => BagData.fromMap(e)).toList();
      bagDataList.value = finalResult;
      print("Length:  ${bagDataList.length}");
      change(finalResult, status: RxStatus.success());

      return finalResult;
    } catch (error) {
      change(null, status: RxStatus.error("Error"));
      rethrow;
    }
  }

  Future<List<ItemData>?> getAllItems() async {
    List<ItemData> finalList = [];
    try {
      final list = await getAllCartItems();
      List<int?> dataList = [];
      for (BagData data in list!) {
        ItemPageController.productList.map((ItemData e) {
          if (data.itemId == e.id) {
            dataList.add(int.tryParse(data.quantity!));
            print('getAllItems(): $dataList ');
            finalList.add(e);
            print('getAllItems() Final list: $finalList ');
          }
        }).toList();
      }

      ///notify listeners

      _itemDataList.value = dataList;
      return finalList;
    } catch (error) {}
  }
}
