import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';

/// [NavBarItem] is the smallest widget in 'AdaptiveNavBar'
///
/// This widget accepts text which will be displayed
/// as a popupmenu option in phone view
/// and as a navbar item in wide view.
class NavBarItem extends InkWell {
  /// [text] will be displayed either in popupmenu option
  /// or as a navbar item in wideview
  final String text;
  final String image;

  /// `NavBarItem`'s named constructor
  NavBarItem({
    required this.text,
    required this.image,
    Key? key,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureTapDownCallback? onTapDown,
    GestureTapCancelCallback? onTapCancel,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
    MouseCursor? mouseCursor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    MaterialStateProperty<Color?>? overlayColor,
    Color? splashColor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool? enableFeedback = true,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    ValueChanged<bool>? onFocusChange,
    bool autofocus = false,
  }) : super(
          key: key,
          child: _NavBarItemChild(
            text: text,
            image: image,
          ),
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          mouseCursor: mouseCursor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          overlayColor: overlayColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          radius: radius,
          borderRadius: borderRadius,
          customBorder: customBorder,
          enableFeedback: enableFeedback ?? true,
          excludeFromSemantics: excludeFromSemantics,
          focusNode: focusNode,
          canRequestFocus: canRequestFocus,
          onFocusChange: onFocusChange,
          autofocus: autofocus,
        );
}

/// [_NavBarItemChild] is the child of [NavBarItem]
class _NavBarItemChild extends StatelessWidget {
  /// [text] is displayed as a popupmenuitem or navbaritem in wide screen.
  final String text;
  final String image;

  /// `_NavBarItemChild`'s named constructor
  const _NavBarItemChild({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(image),
          Center(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
