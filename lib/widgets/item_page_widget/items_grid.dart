import 'package:dro_pharmacy/app_routes/routes_and_pages.dart';
import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:dro_pharmacy/pages/item_details/item_details_page.dart';
import 'package:dro_pharmacy/pages/item_page/item_page_controller.dart';
import 'package:dro_pharmacy/widgets/item_page_widget/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ItemsGrid extends GetView<ItemPageController> {

  @override
  Widget build(BuildContext context) {
    //final items = Provider.of<ItemsPageModel>(context).list;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.obx((data)=>GridView.builder(
          shrinkWrap: true,
          itemCount: data?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            //crossAxisSpacing: 2,
          ),
          itemBuilder: (BuildContext ctx, int index) => GestureDetector(
              onTap: () => Get.toNamed(Routes.ITEM_DETAILS, arguments:data![index] ),
                  // Navigator.of(context).pushNamed(
                  // ItemDetailsPage.route,
                  // arguments: controller.list[index]),
              child: ItemWidget(data![index])),
        ),
        onError: ((error)=>Center(child: Text('Error occured'),)),
        onEmpty: Center(child: Text('Data is empty'),) ),

      ),
    );
  }
}
