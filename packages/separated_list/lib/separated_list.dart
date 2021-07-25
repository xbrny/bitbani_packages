library separated_list;

import 'dart:math' as math;

import 'package:flutter/material.dart';

class SeparatedList extends StatelessWidget {
  const SeparatedList({
    Key? key,
    this.axis = Axis.horizontal,
    this.children = const <Widget>[],
    this.separator,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
  }) : super(key: key);

  final Axis axis;
  final List<Widget> children;
  final Widget? separator;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    late Widget _separator;
    Widget result;

    if (separator == null) {
      _separator = Axis.horizontal == axis
          ? const SizedBox(width: 8)
          : const SizedBox(height: 8);
    } else {
      _separator = separator!;
    }
    final childCount = _computeActualChildCount(children.length);

    final modifiedChildren = List.generate(childCount, (index) {
      final itemIndex = index ~/ 2;
      Widget widget;
      if (index.isEven) {
        widget = children[itemIndex];
      } else {
        widget = _separator;
      }
      return widget;
    });

    switch (axis) {
      case Axis.horizontal:
        result = Row(
          children: modifiedChildren,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
        );
        break;
      case Axis.vertical:
        result = Column(
          children: modifiedChildren,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
        );
        break;
    }

    if (padding != null && children.isNotEmpty) {
      return Padding(
        padding: padding!,
        child: result,
      );
    }

    return result;
  }

  int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
