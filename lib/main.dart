import 'package:dro_pharmacy/app_routes/routes_and_pages.dart';
import 'package:dro_pharmacy/page_models/bag_page_model.dart';
import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:dro_pharmacy/pages/bags/bag_page.dart';
import 'package:dro_pharmacy/pages/item_details/item_details_page.dart';
import 'package:dro_pharmacy/pages/item_page/items_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DRO Pharmacy',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),

        getPages: AppPages.pages,
        initialRoute:Routes.ITEM_PAGE ,
      );

  }
}
