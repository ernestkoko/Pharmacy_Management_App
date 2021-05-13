import 'package:flutter/material.dart';

class MyCustomMultiChildLayout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
   //  Size leader = Size.zero;
   // // if(hasChild(childId))
    
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
   return false;
  }


}