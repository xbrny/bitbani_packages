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

  static InlineSpan actionTextSpan(
    BuildContext context,
    String text, {
    required VoidCallback onTap,
    required Color actionColor,
    Key? key,
    TextStyle? style,
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Text(
          text,
          style: style ?? buildActionTextStyle(context, actionColor),
        ),
      ),
    );
  }

  static TextStyle? buildNormalTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge;

  static TextStyle? buildActionTextStyle(BuildContext context, Color color) =>
      buildNormalTextStyle(context)
          ?.copyWith(color: color, fontWeight: FontWeight.w500)
          .apply(fontSizeDelta: -1);

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
    Widget result = Text.rich(
      TextSpan(
        text: normalText ?? '',
        style: normalTextStyle ?? buildNormalTextStyle(context),
        children: [
          if (normalText != null) const TextSpan(text: ' '),
          BitTapableText.actionTextSpan(
            context,
            text,
            onTap: onTap,
            actionColor: actionColor,
            style: style,
          ),
          ...(extraText ?? [])
        ],
      ),
      textAlign: textAlign,
    );

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: result,
      );
    }

    return result;
  }
}
