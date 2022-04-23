import 'package:dro_pharmacy/pages/item_details/item_details_controller.dart';
import 'package:get/get.dart';

class ItemDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ItemDetailsController());
  }

}