import 'package:dro_pharmacy/pages/item_page/item_page_controller.dart';
import 'package:get/get.dart';

import '../../data/bag_data.dart';
import '../../data/item_data.dart';
import '../../database/sqlite_database.dart';

class BagPageController extends GetxController with StateMixin<List<ItemData>> {
  RxList<int?> arg = Get.arguments;
  RxDouble totalAMount = 0.0.obs;

  //RxBool _incrementOrDecrementClicked=false.obs;
  RxInt _index = 0.obs;

  RxList<ItemData> itemDataList = <ItemData>[].obs;

  @override
  onInit() {
    //arg = Get.arguments;
    // _calculateTotalAmount();
    super.onInit();
  }

  @override
  onReady() {
    getAllItems();
    //_calculateTotalAmount();
  }

  // _calculateTotalAmount() {
  //   for (int index = 0; index < arg.length; index++) {
  //     totalAMount.value += itemDataList[index].itemPrice * arg[index]!;
  //   }
  // }

  ///increment quantity
  Future incrementQuantity(String id, int quantity,
      {required int index}) async {
    try {
      quantity++;
      await updateItem(id, quantity.toString());

      print('Index is Increment::::: $index');
    } catch (error) {}
  }

  ///decrement
  Future decrementQuantity(String id, int quantity,
      {required int index}) async {
    try {
      quantity--;
      if (quantity > 0)
        await updateItem(
          id,
          quantity.toString(),
        );
      print('Index is Decrement::::: $index');
    } catch (error) {}
  }

  ///[updateItem] will update the item with [id] and [quantity] in the db
  Future<int> updateItem(String id, String quantity) async {
    try {
      final result = await SqLiteDatabase.updateItem(id, quantity);

      getAllItems();

      ///notify listeners
      // notifyListeners();
      return result;
    } catch (error) {
      rethrow;
    }
  }

  ///[delete] deletes an item with the given [id] in the database table
  Future<int?> deleteItem(String id, {required int index}) async {
    try {
      _index.value = index;

      final result = await SqLiteDatabase.deleteItem(id);

      ///remove the item with the index from the list
      arg.removeAt(index);
      getAllItems();

      ///notify listeners
      return result;
    } catch (error) {
      rethrow;
    }
  }

  ///read all the data from db
  Future<List<BagData>> _getAllCartItems() async {
    try {
      final _result = await SqLiteDatabase.readAllBagData();
      final finalResult = _result.map((e) => BagData.fromMap(e)).toList();
      return finalResult;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ItemData>> getAllItems() async {
    List<ItemData> finalList = [];
    try {
      final list = await _getAllCartItems();
      List<int?> dataList = [];
      for (BagData data in list) {
        ItemPageController.productList.map((ItemData e) {
          if (data.itemId == e.id) {
            dataList.add(int.tryParse(data.quantity!));
            //print('getAllItems(): $dataList ');
            finalList.add(e);
          }
        }).toList();
      }

      print("ArGUMENT: $dataList");
      //loop through the list of args and change the value with respect to the index that changed
      if (arg.isEmpty || arg != dataList) {
        arg.value = dataList;
      }
      for (int index = 0; index < dataList.length; index++) {
        print("RealARg: $arg");
        arg[index] = dataList[index];
      }

      ///notify listeners
      itemDataList.value = finalList;
      change(finalList, status: RxStatus.success());
     // print('getAllItems() Final list: $finalList ');
      //_itemDataList.value = dataList;
      return finalList;
    } catch (error) {
      change(null, status: RxStatus.error("Error occurred!"));
      rethrow;
    }
  }
}
