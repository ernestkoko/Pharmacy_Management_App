import 'package:dro_pharmacy/data/bag_data.dart';
import 'package:dro_pharmacy/data/item_data.dart';
import 'package:dro_pharmacy/page_models/bag_page_model.dart';
import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:dro_pharmacy/pages/bags/bag_page_controller.dart';
import 'package:dro_pharmacy/pages/item_page/item_page_controller.dart';
import 'package:dro_pharmacy/widgets/bag_summary_widget/bag_summary_widget.dart';
import 'package:dro_pharmacy/widgets/common_widgets/common_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BagPage extends GetView<BagPageController> {
  @override
  Widget build(BuildContext context) {
    //final _provider = Provider.of<BagPageModel>(context, listen: false);
    //final _itemPageController = Get.find<ItemPageController>();
    Color _white = Colors.white;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.purple.shade700,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            children: [
              CommonRow(
                child2: Container(
                  height: 3,
                  margin: const EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                      color: _white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              CommonRow(
                child1: Container(
                  child: Text(''),
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(20),
                    // ),
                  ),
                ),
                child2: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: _white,
                    ),
                    Text(
                      'Bag',
                      style: TextStyle(color: _white),
                    )
                  ],
                ),
                child3: Container(
                  child: Obx(()=> Text('${controller.arg.length} ')),

                  ///return the length of the list if there is data

                  padding: EdgeInsets.all(10),
                  // margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(20),
                    // ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text('Tap on an item for add, remove and delete options',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              Expanded(
                  child: controller.obx(
                      (state) =>
                          listWidget(state!, controller.arg),
                      onEmpty: Center(
                        child: Text('Empty'),
                      ),
                      onError: (error) => Center(
                            child: Text('error'),
                          ))),
              CommonRow(
                child1: Text(
                  "Total",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                child3: controller.obx((state) {
                  double totalAmount = 0;
                  for (int index = 0; index < state!.length; index++) {
                    totalAmount +=
                        state[index].itemPrice * controller.arg[index]!;
                  }
                  return Text(
                    "N$totalAmount ",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
                },
                    onError: (error) => Center(
                          child: Text('Error occurred'),
                        ),
                    onEmpty: Center(
                      child: Text('Data is empty'),
                    )),
              ),
              Container(
                child: Center(
                    child: Text(
                  'Checkout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                width: MediaQuery.of(context).size.width * 0.7,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listWidget(List<ItemData> data, List<int?> quantityList) {
    print(data);
    print("Quantity: $quantityList");
    return ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext ctx, int index) =>
            BagSummaryWidget(data[index], quantityList[index]!, index: index,),);
  }
}
