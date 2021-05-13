import 'package:dro_pharmacy/page_models/items_page_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsPageModel>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: Container(
              child: TextField(
                ///called when the text changes
                onChanged: provider.search,
                decoration: InputDecoration(focusedBorder: InputBorder.none),
              ),
            ),
          ),
          Container(
            child: IconButton(
              onPressed: () {
                ///put isSearch to false
                provider.offSearch();
              },
              icon: Icon(Icons.clear),
            ),
          )
        ],
      ),
    );
  }

  }
