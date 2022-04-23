import 'package:dro_pharmacy/pages/bags/bag_page_controller.dart';
import 'package:get/get.dart';

class BagPageBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => BagPageController());
  }

}