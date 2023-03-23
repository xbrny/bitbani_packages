import 'package:flutter/material.dart';

class BitCustomBottomBar extends StatelessWidget {
  const BitCustomBottomBar({
    Key? key,
    this.child,
    this.boxShadow,
    this.color,
    this.padding,
    this.useSafeArea = true,
  }) : super(key: key);

  factory BitCustomBottomBar.withButton({
    required String text,
    VoidCallback? onPressed,
    Widget? top,
    Widget? bottom,
    ButtonStyle? buttonStyle,
    List<BoxShadow>? boxShadow,
    Color? color,
    EdgeInsetsGeometry? padding,
    bool useSafeArea = true,
  }) {
    return BitCustomBottomBar(
      boxShadow: boxShadow,
      color: color,
      padding: padding,
      useSafeArea: useSafeArea,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (top != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: top,
            ),
          FilledButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: Text(text),
          ),
          if (bottom != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: bottom,
            ),
        ],
      ),
    );
  }

  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        boxShadow: boxShadow ??
            [
              const BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(0, -0.5),
                  blurRadius: 5),
            ],
        color: color ?? Theme.of(context).canvasColor,
      ),
      child: useSafeArea ? SafeArea(top: false, child: child!) : child,
    );
  }
}
