import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:dro_pharmacy/pages/bag_page.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/bottom_sheet_widget.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/items_grid.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/search_bar_widget.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<ItemsPageModel>(context);
    final items = itemsProvider.list;
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            '${items.length} items',
            style: TextStyle(color: Colors.black),
          )),
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
            itemsProvider.isSearch ? SearchBarWidget() : Container(),
            ItemsGrid(),
            GestureDetector(child: BottomSheetWidget(),
            onTap: ()=> Navigator.of(context).pushNamed(BagPage.route),)
          ],
        ));
  }
}
