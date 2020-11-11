import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:flutter/foundation.dart';


class GlowThemeHandler {
  GlowThemeHandler({
    @required this.theme,
    this.darkTheme,
    this.themeType = GlowThemeType.system,
  });

  final GlowThemeData theme;
  final GlowThemeData darkTheme;
  final GlowThemeType themeType;

  bool get useDark =>
      darkTheme != null &&
      ( //forced to use DARK by user
          themeType == GlowThemeType.dark ||
              //The setting indicating the current brightness mode of the host platform.
              // If the platform has no preference, platformBrightness defaults to Brightness.light.
              window.platformBrightness == Brightness.dark);

  GlowThemeData get current {
    if (useDark) {
      return darkTheme;
    } else {
      return theme;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlowThemeHandler &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          darkTheme == other.darkTheme &&
          themeType == other.themeType;

  @override
  int get hashCode => theme.hashCode ^ darkTheme.hashCode ^ themeType.hashCode;

  GlowThemeHandler copyWith({
    GlowThemeData theme,
    GlowThemeData darkTheme,
    GlowThemeType themeType,
  }) =>
      GlowThemeHandler(
        theme: theme ?? this.theme,
        darkTheme: darkTheme ?? this.darkTheme,
        themeType: themeType ?? this.themeType,
      );
}

@immutable
class GlowThemeData {
  const GlowThemeData({
    this.glowColor,
    this.offset,
    this.spreadRadius,
    this.blurRadius,
  });

  factory GlowThemeData.fromBoxShadow({BoxShadow boxShadow}) => GlowThemeData(
        glowColor: boxShadow.color,
        offset: boxShadow.offset,
        spreadRadius: boxShadow.spreadRadius,
        blurRadius: boxShadow.blurRadius,
      );

  final Color glowColor;
  final Offset offset;
  final double spreadRadius;
  final double blurRadius;

  GlowThemeData copyWith({
    Color glowColor,
    Offset offset,
    double spreadRadius,
    double blurRadius,
  }) =>
      GlowThemeData(
        glowColor: glowColor ?? glowColor,
        offset: offset ?? offset,
        spreadRadius: spreadRadius ?? spreadRadius,
        blurRadius: blurRadius ?? blurRadius,
      );

  GlowThemeData copyFrom({
    GlowThemeData other,
  }) =>
      GlowThemeData(
        glowColor: other.glowColor ?? this.glowColor,
        offset: other.offset ?? this.offset,
        spreadRadius: other.spreadRadius ?? this.spreadRadius,
        blurRadius: other.blurRadius ?? this.blurRadius,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlowThemeData &&
          runtimeType == other.runtimeType &&
          glowColor == other.glowColor &&
          offset == other.offset &&
          spreadRadius == other.spreadRadius &&
          blurRadius == other.blurRadius;

  @override
  int get hashCode =>
      glowColor.hashCode ^ offset.hashCode ^ spreadRadius.hashCode ^ blurRadius.hashCode;

  @override
  String toString() {
    return 'GlowThemeData{glowColor: $glowColor, offset: $offset, spreadRadius: $spreadRadius, blurRadius: $blurRadius}';
  }
}

GlowThemeData kDefaultGlowTheme = GlowThemeData(
  glowColor: Color(0x1e000000),
  offset: Offset(0, 2),
  blurRadius: 6.0,
  spreadRadius: 0.0,
);
enum GlowThemeType { light, dark, system }

class GlowTheme extends StatefulWidget {
  const GlowTheme({
    Key key,
    @required this.child,
    this.lightTheme,
    this.darkTheme,
    this.themeType,
  }) : super(key: key);

  final Widget child;
  final GlowThemeData lightTheme;
  final GlowThemeData darkTheme;
  final GlowThemeType themeType;

  static GlowThemeInherited _inheritedThemeOf(BuildContext context) {
    try {
      return context.dependOnInheritedWidgetOfExactType<GlowThemeInherited>();
    } catch (t) {
      return null;
    }
  }

  static GlowThemeData of(BuildContext context) {
    try {
      return _inheritedThemeOf(context).current;
    } catch (t) {
      return null;
    }
  }

  static bool isUsingDark(BuildContext context) {
    return _inheritedThemeOf(context).isUsingDark;
  }

  @override
  _GlowThemeState createState() => _GlowThemeState();
}

class _GlowThemeState extends State<GlowTheme> {
  GlowThemeHandler _themeHandler;

  @override
  void initState() {
    super.initState();
    _themeHandler = GlowThemeHandler(
      theme: widget.lightTheme,
      darkTheme: widget.darkTheme,
      themeType: widget.themeType,
    );
  }

  @override
  void didUpdateWidget(GlowTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    _themeHandler = GlowThemeHandler(
      theme: widget.lightTheme,
      darkTheme: widget.darkTheme,
      themeType: widget.themeType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlowThemeInherited(
      value: _themeHandler,
      onChange: (value) {
        setState(() {
          _themeHandler = value;
        });
      },
      child: widget.child,
    );
  }
}


class GlowThemeInherited extends InheritedWidget {
  const GlowThemeInherited({
    Key key,
    @required Widget child,
    @required this.value,
    @required this.onChange,
  })  : assert(child != null),
        super(key: key, child: child);

  final GlowThemeHandler value;

  final ValueChanged<GlowThemeHandler> onChange;

  @override
  bool updateShouldNotify(GlowThemeInherited oldWidget) => value != oldWidget.value;

  GlowThemeData get current => value.current;

  bool get isUsingDark => value.useDark;

  GlowThemeType get themeType => value.themeType;

  set themeType(GlowThemeType themeType) => onChange(value.copyWith(themeType: themeType));

  set updateCurrentTheme(GlowThemeData themeData) => onChange(
        value.copyWith(
          theme: isUsingDark ? null : themeData,
          darkTheme: isUsingDark ? themeData : null,
        ),
      );
}



class GlowContainer extends StatelessWidget {
  const GlowContainer({
    Key key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.color,
    this.alignment,
    this.borderRadius,
    this.border,
    this.shape,
    this.glowColor,
    this.offset,
    this.spreadRadius,
    this.blurRadius,
    this.animationDuration,
    this.animationCurve = Curves.linear,
    this.child,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final AlignmentGeometry alignment;
  final BoxBorder border;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BoxShape shape;
  final Widget child;

  //animation
  final Duration animationDuration;
  final Curve animationCurve;

  //glow properties
  final Color glowColor;
  final Offset offset;
  final double spreadRadius;
  final double blurRadius;

  @override
  Widget build(BuildContext context) {
    final glowTheme = GlowTheme.of(context);
    return AnimatedContainer(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      alignment: alignment,
      duration: animationDuration ?? const Duration(milliseconds: 300),
      curve: animationCurve ?? Curves.linear,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: glowColor ?? glowTheme?.glowColor ?? kDefaultGlowTheme.glowColor,
            offset: offset ?? glowTheme?.offset ?? kDefaultGlowTheme.offset,
            blurRadius: blurRadius ?? glowTheme?.blurRadius ?? kDefaultGlowTheme.blurRadius,
            spreadRadius: spreadRadius ?? glowTheme?.spreadRadius ?? kDefaultGlowTheme.spreadRadius,
          ),
        ],
        border: border,
        shape: shape ?? BoxShape.rectangle,
      ),
      child: child,
    );
  }
}

class GlowCheckbox extends StatelessWidget {
  const GlowCheckbox({
    Key key,
    this.width,
    this.height,
    @required this.value,
    this.enable = true,
    this.padding,
    this.margin,
    this.color,
    this.disableColor,
    this.glowColor,
    this.offset,
    this.spreadRadius,
    this.blurRadius,
    @required this.onChange,
    this.checkColor,
    this.border,
    this.duration,
    this.curve,
    this.checkIcon,
  })  : assert(value != null),
        assert(onChange != null),
        super(key: key);

  final double width;
  final double height;
  final bool enable;
  final bool value;
  final Function(bool value) onChange;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BoxBorder border;
  final Color color;
  final Color checkColor;
  final Color disableColor;

  final IconData checkIcon;

  //animation
  final Duration duration;
  final Curve curve;

  //glow properties
  final Color glowColor;
  final Offset offset;
  final double spreadRadius;
  final double blurRadius;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final checkBoxColor = _buildCheckboxColor(context);

    final glowTheme = GlowTheme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onChange != null && enable) onChange(!value);
      },
      child: GlowContainer(
        width: width ?? 24,
        height: height ?? 24,
        margin: margin ?? EdgeInsets.all(0),
        border: border ?? Border.all(width: 2, color: checkBoxColor),
        color: value ? checkBoxColor : checkBoxColor.withOpacity(0),
        glowColor: buildGlowColor(glowTheme, checkBoxColor),
        offset: offset ?? glowTheme?.offset ?? kDefaultGlowTheme.offset,
        blurRadius: blurRadius ?? glowTheme?.blurRadius ?? kDefaultGlowTheme.blurRadius,
        spreadRadius: spreadRadius ?? glowTheme?.spreadRadius ?? kDefaultGlowTheme.spreadRadius,
        // shape: BoxShape.circle,
        animationDuration: duration ?? const Duration(milliseconds: 200),
        animationCurve: curve,
        child: value
            ? Icon(
                checkIcon ?? Icons.check,
                color: checkColor ?? theme.colorScheme.onPrimary,
                size: 18,
              )
            : SizedBox.shrink(),
      ),
    );
  }

  Color buildGlowColor(GlowThemeData glowTheme, Color checkBoxColor) {
    return value && enable
        ? glowColor ?? glowTheme?.glowColor ?? checkBoxColor ?? kDefaultGlowTheme.glowColor
        : Colors.transparent;
  }

  Color _buildCheckboxColor(BuildContext context) {
    return enable ?? true
        ? color ?? Theme.of(context).toggleableActiveColor
        : disableColor ?? Theme.of(context).disabledColor;
  }
}