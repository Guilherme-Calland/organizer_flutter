import 'package:flutter/material.dart';

class OrganizerCard extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final Color? color;
  final double? elevation;

  OrganizerCard({
    required this.child,
    this.color,
    this.borderRadius,
    this.elevation,
  });

  @override
  Widget build(_) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: elevation ?? 10.0,
        color: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius ?? 20.0),
            topRight: Radius.circular(borderRadius ?? 20.0),
          ),
        ),
        child: child,
      ),
    );
  }
}
