import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsPageModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            decoration:
            BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
            child: IconButton(icon: Icon(Icons.offline_bolt), onPressed: null)),
        Container(
            decoration:
            BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
            child: IconButton(
                onPressed: null, icon: Icon(Icons.filter_alt_outlined))),
        Container(
            decoration:
            BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                ///put on isSearch
                provider.onSearch();
              },
              icon: Icon(Icons.search),
            ))
      ],
    );
  }
}
