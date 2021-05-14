import 'package:dro_pharmacy/assets/myIcons.dart';
import 'package:dro_pharmacy/data/item_data.dart';
import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:dro_pharmacy/widgets/common_widgets/common_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagSummaryWidget extends StatefulWidget {
  final ItemData item;

  final int quantity;

  BagSummaryWidget(this.item, this.quantity);

  @override
  _BagSummaryWidgetState createState() => _BagSummaryWidgetState();
}

class _BagSummaryWidgetState extends State<BagSummaryWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    Color _white = Colors.white;
    final _provider = Provider.of<ItemsPageModel>(context);
    return Container(
      margin: const EdgeInsets.only(top: 11),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ///toggle expanded

              setState(() {
                _expanded = !_expanded;
              });
            },
            child: CommonRow(
              child1: Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.item.imageUrl!),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${widget.quantity}' + 'X',
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
                "N${(widget.quantity * widget.item.itemPrice!).round()}",
                style: TextStyle(color: _white),
              ),
            ),
          ),
          if (_expanded)
            CommonRow(
                child1: _container(Icons.delete,
                    () async => _deleteItem(widget.item.id!, _provider)),
                child3: CommonRow(
                  child1: _container(
                      MyIcons.minus,
                      () async => await decrementAndUpdate(
                          widget.item.id!, widget.quantity, _provider)),
                  child2: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  child3: _container(
                      Icons.add,
                      () async => await incrementAndUpdate(
                          widget.item.id!, widget.quantity, _provider)),
                ))
        ],
      ),
    );
  }

  ///increment the quantity and update the database
  Future<void> incrementAndUpdate(
      String id, int quantity, ItemsPageModel provider) async {
    try {
      int _quantity = quantity + 1;
      final result = await provider.updateItem(id, _quantity.toString());
      print('Update Result: $result');
    } catch (error) {
      print('Update Error: $error');
    }
  }

  ///decrement the quantity and update the database
  Future<void> decrementAndUpdate(
      String id, int quantity, ItemsPageModel provider) async {
    try {
      int _quantity = quantity - 1;

      ///ensure _quantity is not less that one
      if (_quantity <= 1) _quantity = 1;
      final result = await provider.updateItem(id, _quantity.toString());
      print('Update Result: $result');
    } catch (error) {
      print('Update Error: $error');
    }
  }

  Future<void> _deleteItem(String id, ItemsPageModel provider) async {
    try {
      final result = await provider.deleteItem(id);
      print('Delete Result: $result');
    } catch (error) {
      print('Delete Error: $error');
    }
  }

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
