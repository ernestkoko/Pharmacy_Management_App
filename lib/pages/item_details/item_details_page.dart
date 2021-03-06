import 'package:dro_pharmacy/app_routes/routes_and_pages.dart';
import 'package:dro_pharmacy/assets/myIcons.dart';

import 'package:dro_pharmacy/data/item_data.dart';

import 'package:dro_pharmacy/pages/item_details/item_details_controller.dart';
import 'package:dro_pharmacy/widgets/common_widgets/common_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ItemDetailsPage extends GetView<ItemDetailsController> {


  @override
  Widget build(BuildContext context) {
    final item = controller.item as ItemData;


    print('Args: $item');
    print('Args Id: ${item.id}');
    return Scaffold(
        appBar: AppBar(elevation: 0, actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.BAG_PAGE, arguments: controller.itemDatList),
            child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.purple.shade700,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(children: [
                  const Icon(Icons.shopping_bag_outlined),

                    Obx(()=>Text('${controller.bagDataList.length}'),),

                ])),
          )
        ]),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                CommonRow(
                  child1: Text(
                    item.itemName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                CommonRow(
                  child1: Text(item.itemType,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonRow(
                  child1: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(40)),
                        height: 40,
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SOLD BY',
                              style: TextStyle(color: Colors.black38)),
                          Text('${item.manufacturerName}',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonRow(
                    child1: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(MyIcons.minus),
                                onPressed: controller.decrementItemQuantity,
                                padding: EdgeInsets.all(0),
                                iconSize: 20,
                              ),
                              Obx(()=> Text(
                                "${controller.itemQuantity.value}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: controller.incrementItemQuantity,
                                padding: EdgeInsets.all(0),
                                iconSize: 20,
                              )
                            ],
                          ),
                        ),
                        Text('Packs')
                      ],
                    ),
                    child2: Container(),
                    child3: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: Text(
                            'N',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          left: -10,
                          top: -3,
                        ),
                        Text(
                          '${item.itemPrice}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 30,
                ),
                CommonRow(
                  child1: Text(
                    "PRODUCT DETAILS",
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _commonRowWithColumn(Icons.wine_bar, 'Pack Size', '3x10',
                    child: _commonRowWithColumn(
                        Icons.wysiwyg_outlined, "PRODUCT ID", "${item.id}")),
                SizedBox(
                  height: 10,
                ),
                _commonRowWithColumn(
                    Icons.score_rounded, 'CONSTITUENTS', item.itemName),
                SizedBox(
                  height: 10,
                ),
                _commonRowWithColumn(Icons.account_balance_wallet_outlined,
                    'DISPENSED IN', item.itemType),
                CommonRow(
                  child2: Text(
                    'one pack of ..',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                CommonRow(
                  child2: ElevatedButton.icon(
                    onPressed: () => _addToCart(item.id, context, item),
                    icon: Icon(Icons.add_photo_alternate_outlined),
                    label: Text("Add to bag"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.purple.shade700),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _addToCart(
      String itemId, BuildContext context, ItemData item) async {
    try {
      await controller.addToCart(itemId);

      ///show dialog
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -50,
                        left: 20,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.greenAccent,
                            ),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text('Successful')
                    ],
                  ),
                ),
                actions: [
                  Center(
                      child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Text(
                          '${item.itemName} has been added to your bag',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ///pop the dialog first
                           // Navigator.of(context).pop();
                            //navigate to the bag page
                            Get.toNamed(Routes.BAG_PAGE, arguments: controller.itemDatList);
                          },
                          child: Text('View Bag'),
                          style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(Size.infinite),
                              maximumSize:
                                  MaterialStateProperty.all(Size.infinite),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.greenAccent)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Done'),
                          style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(Size.infinite),
                              maximumSize:
                                  MaterialStateProperty.all(Size.infinite),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.greenAccent)),
                        ),
                      ],
                    ),
                  )),
                ],
              ));
    } catch (error) {}
  }

  Widget _commonRowWithColumn(IconData icon, String text1, String text,
      {Widget? child}) {
    return CommonRow(
      child1: Row(
        children: [
          Icon(
            icon,
            color: Colors.purple,
          ),
          Column(
            children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: '$text1 \n',
                      style: TextStyle(color: Colors.black38)),
                  TextSpan(
                      text: text, style: TextStyle(fontWeight: FontWeight.bold))
                ]),
              )
            ],
          )
        ],
      ),
      child2: child,
    );
  }

  void _resetItemQuantity() {
    controller.setItemQuantityToOne();
  }

// @override
// void deactivate() {
//
//   _resetItemQuantity();
//   super.deactivate();
// }

}
