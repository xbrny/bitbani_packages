import 'package:flutter/widgets.dart';

class Unfocus extends StatelessWidget {
  const Unfocus({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: hideKeyboard,
      child: child,
    );
  }
}
