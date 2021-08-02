import 'package:flutter/material.dart';

class ScrollableFullHeightContainer extends StatelessWidget {
  const ScrollableFullHeightContainer({
    Key? key,
    this.child,
    this.alignment = Alignment.center,
    this.padding,
    this.color,
    this.decoration,
    this.margin,
    this.physics,
    this.withIntrinsicHeight = false,
    this.withSafeArea = false,
  }) : super(key: key);

  final Widget? child;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;
  final ScrollPhysics? physics;
  final bool withIntrinsicHeight;
  final bool withSafeArea;

  @override
  Widget build(BuildContext context) {
    Widget result = LayoutBuilder(builder: (context, constraints) {
      Widget? result = child;
      if (withIntrinsicHeight) {
        result = IntrinsicHeight(child: result);
      }

      print(constraints);
      print(MediaQuery.of(context).size.height);

      return ListView(
        physics: physics,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: result,
            alignment: alignment,
            padding: padding,
            color: color,
            decoration: decoration,
            margin: margin,
          ),
        ],
      );
    });

    if (withSafeArea) {
      result = SafeArea(child: result);
    }

    return result;
  }
}
