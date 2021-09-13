import 'package:flutter/material.dart';

class OrganizerContainer extends StatelessWidget {
  final Widget? child;
  final double? borderRadius;
  final Color? color;
  final bool? bottomRounded;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? size;

  OrganizerContainer({
    this.child,
    this.color,
    this.borderRadius,
    this.bottomRounded,
    this.margin,
    this.padding,
    this.size
  });

  @override
  Widget build(_) {
    return Container(
      width: size,
      height: size,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? 10.0),
          topRight: Radius.circular(borderRadius ?? 10.0),
          bottomLeft: Radius.circular((bottomRounded ?? true) ? (borderRadius ?? 10.0) : 0.0),
          bottomRight: Radius.circular((bottomRounded ?? true) ? (borderRadius ?? 10.0) : 0.0),
        ),
      ),
      child: child,
    );
  }
}
