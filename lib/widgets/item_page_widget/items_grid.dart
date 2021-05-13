import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:dro_pharmacy/pages/item_details_page.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemsPageModel>(context).list;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            //crossAxisSpacing: 2,
          ),
          itemBuilder: (BuildContext ctx, int index) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  ItemDetailsPage.route,
                  arguments: items[index]),
              child: ItemWidget(items[index])),
        ),
      ),
    );
  }
}
