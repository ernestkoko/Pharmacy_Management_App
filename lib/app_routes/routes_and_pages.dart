
import 'package:dro_pharmacy/pages/bags/bag_page.dart';
import 'package:dro_pharmacy/pages/bags/bag_page_binding.dart';
import 'package:dro_pharmacy/pages/item_details/item_details_binding.dart';
import 'package:dro_pharmacy/pages/item_details/item_details_page.dart';
import 'package:dro_pharmacy/pages/item_page/item_page_binding.dart';
import 'package:get/get.dart';

import '../pages/item_page/items_page.dart';

abstract class Routes {
  static const ITEM_PAGE = '/item_page';
  static const BAG_PAGE = '/bag_page';
  static const ITEM_DETAILS = '/item_details';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.ITEM_PAGE,
      page: () => ItemsPage(),
      binding: ItemPageBinding(),
    ),
    GetPage(
      name: Routes.BAG_PAGE,
      page: () => BagPage(),
      binding: BagPageBinding(),
    ),
    GetPage(
      name: Routes.ITEM_DETAILS,
      page: () => ItemDetailsPage(),
      binding: ItemDetailsBinding(),
    )
  ];
}
