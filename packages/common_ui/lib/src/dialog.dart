import 'package:flutter/material.dart';
import 'package:separated_list/separated_list.dart';

const double _defaultButtonHeight = 42.0;

class BitCustomAlertDialog extends StatelessWidget {
  const BitCustomAlertDialog({
    Key? key,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.actions,
    this.actionsPadding = EdgeInsets.zero,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: 40.0,
      vertical: 24.0,
    ),
    this.clipBehavior = Clip.none,
    this.shape,
    this.actionsAxis = Axis.horizontal,
    this.buttonHeight = _defaultButtonHeight,
  }) : super(key: key);

  factory BitCustomAlertDialog.simple({
    String? title,
    String? content,
    VoidCallback? onPrimary,
    VoidCallback? onSecondary,
    String? primaryLabel = 'Ok',
    String? secondaryLabel = 'Cancel',
    Color? primaryColor,
    Color? secondaryColor,
    Color? primaryLabelColor,
    Color? secondaryLabelColor,
    double buttonHeight = _defaultButtonHeight,
    TextStyle? textStyle,
    Axis actionsAxis = Axis.horizontal,
  }) {
    return BitCustomAlertDialog(
      title: title != null ? Text(title) : null,
      content: content != null ? Text(content) : null,
      actionsAxis: actionsAxis,
      actions: [
        if (secondaryLabel != null)
          ElevatedButton(
            child: Text(secondaryLabel),
            onPressed: onSecondary,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, buttonHeight),
              textStyle: textStyle,
              primary: secondaryColor,
              onPrimary: secondaryLabelColor,
            ),
          ),
        if (primaryLabel != null)
          ElevatedButton(
            child: Text(primaryLabel),
            onPressed: onPrimary,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, buttonHeight),
              textStyle: textStyle,
              primary: primaryColor,
              onPrimary: primaryLabelColor,
            ),
          ),
      ],
    );
  }

  final Widget? title;
  final EdgeInsetsGeometry? titlePadding;
  final TextStyle? titleTextStyle;
  final Widget? content;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentTextStyle;
  final List<Widget>? actions;
  final EdgeInsetsGeometry actionsPadding;
  final VerticalDirection? actionsOverflowDirection;
  final double? actionsOverflowButtonSpacing;
  final EdgeInsetsGeometry? buttonPadding;
  final Color? backgroundColor;
  final double? elevation;
  final String? semanticLabel;
  final EdgeInsets insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final Axis actionsAxis;
  final double buttonHeight;

  static const double _actionsSpacing = 10;
  static const double _actionsTopSpacing = 20;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);

    String? label = semanticLabel;
    if (title == null) {
      switch (theme.platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          label = semanticLabel ??
              MaterialLocalizations.of(context).alertDialogLabel;
      }
    }

    Widget? titleWidget;
    late Widget contentWidget;
    Widget? actionsWidget;

    if (title != null) {
      double bottomPadding = 0.0;
      if (content == null && actions != null) {
        bottomPadding = _actionsTopSpacing;
      } else if (content != null) {
        bottomPadding = 10.0;
      }

      titleWidget = Padding(
        padding: titlePadding ?? EdgeInsets.only(bottom: bottomPadding),
        child: DefaultTextStyle(
          style: titleTextStyle ??
              dialogTheme.titleTextStyle ??
              theme.textTheme.headline6!,
          child: Semantics(
            child: title,
            namesRoute: true,
            container: true,
          ),
        ),
      );
    }

    if (content != null)
      contentWidget = Padding(
        padding: contentPadding ??
            EdgeInsets.only(bottom: actions != null ? _actionsTopSpacing : 0),
        child: DefaultTextStyle(
          style: contentTextStyle ??
              dialogTheme.contentTextStyle ??
              theme.textTheme.subtitle1!,
          child: content!,
        ),
      );

    if (actions != null) {
      actionsWidget = Theme(
        data: theme.copyWith(
          buttonTheme: theme.buttonTheme.copyWith(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: BeveledRectangleBorder(),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              minimumSize: Size(80, buttonHeight),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        child: Container(
          height: actionsAxis == Axis.horizontal ? buttonHeight : null,
          padding: actionsPadding,
          child: SeparatedList(
            axis: actionsAxis,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: actionsAxis == Axis.horizontal
                ? actions!.map((action) => Expanded(child: action)).toList()
                : actions!.reversed.toList(),
            separator: actionsAxis == Axis.horizontal
                ? const SizedBox(width: _actionsSpacing)
                : const SizedBox(height: _actionsSpacing),
          ),
        ),
      );
    }

    List<Widget> columnChildren;

    columnChildren = <Widget>[
      if (title != null) titleWidget!,
      if (content != null) Flexible(child: contentWidget),
      if (actions != null) actionsWidget!,
    ];

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
    );

    if (label != null)
      dialogChild = Semantics(
        namesRoute: true,
        label: label,
        child: dialogChild,
      );

    return Dialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: shape,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          actions != null ? 14 : 20,
        ),
        child: dialogChild,
      ),
    );
  }
}
