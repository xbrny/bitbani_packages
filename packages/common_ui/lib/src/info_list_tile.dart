import 'package:flutter/material.dart';

class BitInfoListTile extends StatelessWidget {
  BitInfoListTile({
    required this.title,
    this.value,
    this.padding,
    this.titleFlex = 1,
    this.valueFlex = 2,
    this.titleStyle,
    this.valueStyle,
  });

  final String title;
  final String? value;
  final EdgeInsetsGeometry? padding;
  final int titleFlex;
  final int valueFlex;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: titleFlex,
            child: Text(
              title,
              style: titleStyle ?? defaultTitleStyle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: valueFlex,
            child: Text(
              value ?? '-',
              textAlign: TextAlign.end,
              style: valueStyle ?? defaultValueStyle,
            ),
          ),
        ],
      ),
    );
  }

  static get defaultTitleStyle => TextStyle(
        color: Colors.grey.shade700,
        fontSize: 13,
      );
  static get defaultValueStyle => TextStyle(
        fontWeight: FontWeight.w500,
      );
}
