import 'package:flutter/material.dart';

class CommonRow extends StatelessWidget {
  final Widget? child1;
  final Widget? child2;
  final Widget? child3;

  CommonRow({this.child1, this.child2, this.child3});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: child1,
        ),
        Container(
          child: child2,
        ),
        Container(
          child: child3,
        ),
      ],
    );
  }
}
