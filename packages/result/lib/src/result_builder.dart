import 'package:flutter/cupertino.dart';
import 'package:result/result.dart';

class ResultBuilder<T> extends StatelessWidget {
  const ResultBuilder({
    Key? key,
    required this.result,
    required this.onSuccess,
    this.onIdle,
    this.onLoading,
    this.onError,
    this.centered = false,
  }) : super(key: key);

  final Result<T> result;
  final WidgetBuilder? onLoading;
  final WidgetBuilder? onIdle;
  final _ValueChangedWidgetBuilder<String?>? onError;
  final _ValueChangedWidgetBuilder<T> onSuccess;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    Widget widget = SizedBox.shrink();
    if (result.isIdle) {
      widget = onIdle?.call(context) ?? widget;
    }
    if (result.isLoading) {
      widget = onLoading?.call(context) ?? CupertinoActivityIndicator();
    }
    if (result.isError) {
      widget = onError?.call(context, result.message) ??
          Text(
            result.message!,
            textAlign: centered ? TextAlign.center : TextAlign.start,
          );
    }
    if (result.isSuccess) {
      widget = onSuccess.call(context, result.data as T);
    }
    if (centered) {
      return Center(child: widget);
    }
    return widget;
  }
}

typedef _ValueChangedWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);
