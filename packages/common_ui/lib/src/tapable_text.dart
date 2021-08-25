import 'package:flutter/material.dart';

class BitTapableText extends StatelessWidget {
  const BitTapableText(
    this.text, {
    Key? key,
    required this.onTap,
    required this.actionColor,
    this.normalText,
    this.extraText,
    this.style,
    this.normalTextStyle,
    this.margin,
    this.center = false,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  static InlineSpan inlineSpan(
    BuildContext context,
    String text, {
    required VoidCallback onTap,
    required Color actionColor,
    Key? key,
    TextStyle? style,
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Text(
          text,
          style: style ?? buildActiontextStyle(context, actionColor),
        ),
      ),
    );
  }

  static buildNormalTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyText1;

  static buildActiontextStyle(BuildContext context, Color color) =>
      buildNormalTextStyle(context)
          ?.copyWith(color: color, fontWeight: FontWeight.w500);

  final String? normalText;
  final String text;
  final List<InlineSpan>? extraText;
  final TextStyle? style;
  final TextStyle? normalTextStyle;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;
  final bool center;
  final TextAlign textAlign;
  final Color actionColor;

  @override
  Widget build(BuildContext context) {
    Widget result = RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: normalText ?? '',
        style: normalTextStyle ?? buildNormalTextStyle(context),
        children: [
          if (normalText != null) TextSpan(text: ' '),
          BitTapableText.inlineSpan(
            context,
            text,
            onTap: onTap,
            actionColor: actionColor,
          ),
          ...(extraText ?? [])
        ],
      ),
    );

    if (margin != null)
      return Padding(
        padding: margin!,
        child: result,
      );

    return result;
  }
}
