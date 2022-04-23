import 'package:dro_pharmacy/pages/item_page/item_page_controller.dart';
import 'package:get/get.dart';

class ItemPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ItemPageController());
  }

}