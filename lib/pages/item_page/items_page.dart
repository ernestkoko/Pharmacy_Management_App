import 'package:dro_pharmacy/app_routes/routes_and_pages.dart';
import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:dro_pharmacy/pages/bags/bag_page.dart';
import 'package:dro_pharmacy/pages/item_page/item_page_controller.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/bottom_sheet_widget.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/items_grid.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/search_bar_widget.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsPage extends GetView<ItemPageController> {
  @override
  Widget build(BuildContext context) {
    //final itemsProvider = Provider.of<ItemsPageModel>(context);
    // final items = itemsProvider.list;
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: controller.obx(
                      (state) => Text(
                            '${state!.length} items',
                            style: TextStyle(color: Colors.black),
                          ),
                      onEmpty: Text("0 item"))),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SearchWidget(),

                ///display the searchBar widget if isSearch is true
                Obx(() => controller.isSearch.value
                    ? SearchBarWidget()
                    : Container()),
                ItemsGrid(),
                GestureDetector(
                    child: BottomSheetWidget(),
                    onTap: () => Get.toNamed(Routes.BAG_PAGE,
                        arguments: controller.itemDataList)
                    //Navigator.of(context).pushNamed(BagPage.route),
                    )
              ],
            )));
  }
}
