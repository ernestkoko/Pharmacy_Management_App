import 'package:dro_pharmacy/page_models/bag_page_model.dart';
import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:dro_pharmacy/pages/bag_page.dart';
import 'package:dro_pharmacy/pages/item_details_page.dart';
import 'package:dro_pharmacy/pages/items_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemsPageModel>(
            create: (ctx) => ItemsPageModel()),
        ChangeNotifierProvider<BagPageModel>(
            create: (BuildContext ctx) => BagPageModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DRO Pharmacy',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: ItemsPage(),
        routes: {
          ItemDetailsPage.route: (ctx) => ItemDetailsPage(),
          BagPage.route: (BuildContext ctx) => BagPage()
        },
      ),
    );
  }
}
