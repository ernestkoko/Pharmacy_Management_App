import 'package:dro_pharmacy/pages/bags/bag_page_controller.dart';
import 'package:dro_pharmacy/pages/item_page/item_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends StatelessWidget {
  final controller = Get.find<ItemPageController>();
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<ItemsPageModel>(context);
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.purple.shade700,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 3,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      'Bag',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(20)
                      shape: BoxShape.circle),
                  child: Obx(
                    () => Text("${controller.itemDataList.value.length} "),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
