import 'package:flutter/material.dart';

class BitTextDivider extends StatelessWidget {
  final String text;
  final double indent;
  final double height;
  final double horizontalSpace;

  const BitTextDivider(
    this.text, {
    Key? key,
    this.indent = 16.0,
    this.height = 48.0,
    this.horizontalSpace = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Divider(indent: indent, height: height)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalSpace),
          child: Text(text),
        ),
        Expanded(child: Divider(endIndent: indent, height: height)),
      ],
    );
  }
}
