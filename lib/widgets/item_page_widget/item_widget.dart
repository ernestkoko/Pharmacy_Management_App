import 'package:dro_pharmacy/data/item_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final ItemData item;

  ItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return _myWidget();
  }

  Widget _myWidget() {
    return Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  item.imageUrl!,
                  errorBuilder: (ctx, exception, trace) => Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    '${item.manufacturerName}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
                Text(' '),
                Text('')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      ' ${item.itemType}',
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "${item.itemName}",
                    maxLines: 2,
                    softWrap: true,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    ' #${item.itemPrice}',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
