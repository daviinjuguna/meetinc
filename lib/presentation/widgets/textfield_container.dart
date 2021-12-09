import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({Key? key, required this.child, this.padding})
      : super(key: key);
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: child,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 4.19,
            offset: Offset(0, 2.73),
          ),
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 14.07,
            offset: Offset(0, 9.16),
          ),
          BoxShadow(
            color: Color(0x0c000000),
            blurRadius: 63,
            offset: Offset(0, 41),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
