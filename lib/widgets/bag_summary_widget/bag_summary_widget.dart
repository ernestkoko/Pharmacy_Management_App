import 'dart:math';

import 'package:dro_pharmacy/assets/myIcons.dart';
import 'package:dro_pharmacy/data/item_data.dart';
import 'package:dro_pharmacy/pages/bags/bag_page_controller.dart';
import 'package:dro_pharmacy/widgets/common_widgets/common_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class BagSummaryWidget extends StatefulWidget{
  final ItemData item;
  final int index;

  final int quantity;

  BagSummaryWidget(this.item, this.quantity,{required this.index,Key? key}): super(key: key);


  @override
  State<BagSummaryWidget> createState() => _BagSummaryWidgetState();
}
class _BagSummaryWidgetState extends State<BagSummaryWidget>{


  bool _expanded=false;
  Color _white = Colors.white;
  final controller = Get.find<BagPageController>();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

         //controller.changeExpanded();

        setState(() {
          _expanded = !_expanded;
        });
      },

      child:Container(
        margin: const EdgeInsets.only(top: 11),
        child: Column(
          children: [
            CommonRow(
              child1: Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.item.imageUrl),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${widget.quantity}  X',
                    style: TextStyle(color: _white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.item.itemName}',
                        style: TextStyle(color: _white),
                      ),
                      Text(
                        "${widget.item.itemType}",
                        style: TextStyle(color: _white),
                      )
                    ],
                  )
                ],
              ),
              child3: Text(
                "N${(widget.quantity * widget.item.itemPrice).round()}",
                style: TextStyle(color: _white),
              ),
            ),
            if (_expanded)
              Column(
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  CommonRow(
                      child1: GestureDetector(
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                        onTap: () async =>
                        await controller.deleteItem(widget.item.id, index: widget.index),
                           // _deleteItem(widget.item.id, controller),
                      ),
                      child3: CommonRow(
                        child1: _container(
                            MyIcons.minus,
                            () async => await controller.decrementQuantity(
                                widget.item.id,widget. quantity, index: widget.index)),
                        child2: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        child3: _container(
                            Icons.add,
                            () async => await controller.incrementQuantity(
                                widget.item.id, widget.quantity, index: widget.index)),
                      )),
                ],
              )
          ],
        ),
      ),
    );
  }





  // Future<void> _deleteItem(String id, {required int index }) async {
  //   try {
  //     await provider.deleteItem(id, index:index);
  //     await Fluttertoast.showToast(
  //         backgroundColor: Colors.white,
  //         textColor: Colors.black,
  //         msg: 'Deleted successfully',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER);
  //   } catch (error) {
  //     print('Delete Error: $error');
  //   }
  // }

  Widget _container(IconData icon, VoidCallback fun) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon),
      ),
    );
  }
}
