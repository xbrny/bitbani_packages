library separated_list;

import 'dart:math' as math;

import 'package:flutter/material.dart';

const _kSeparatorSize = 8.0;

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
    late Widget safeSeparator;

    late Widget result;

    if (separator == null) {
      safeSeparator = Axis.horizontal == axis
          ? const SizedBox(width: _kSeparatorSize)
          : const SizedBox(height: _kSeparatorSize);
    } else {
      safeSeparator = separator!;
    }

    final childCount = _computeActualChildCount(children.length);

    final modifiedChildren = List.generate(childCount, (index) {
      final itemIndex = index ~/ 2;

      late Widget widget;

      if (index.isEven) {
        widget = children[itemIndex];
      } else {
        widget = safeSeparator;
      }

      return widget;
    });

    result = Flex(
      direction: axis,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: modifiedChildren,
    );

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
