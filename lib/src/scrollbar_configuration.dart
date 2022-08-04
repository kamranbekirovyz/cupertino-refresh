import 'package:flutter/material.dart';

/// Default value for [thickness] if it's not specified in [CupertinoScrollbar].
const double defaultThickness = 3;

/// Default value for [thicknessWhileDragging] if it's not specified in
/// [CupertinoScrollbar].
const double defaultThicknessWhileDragging = 8.0;

/// Default value for [radius] if it's not specified in [CupertinoScrollbar].
const Radius defaultRadius = Radius.circular(1.5);

/// Default value for [radiusWhileDragging] if it's not specified in
/// [CupertinoScrollbar].
const Radius defaultRadiusWhileDragging = Radius.circular(4.0);

class ScrollbarConfiguration {
  final ScrollController? controller;
  final bool? thumbVisibility;
  final double thickness;
  final double thicknessWhileDragging;
  final Radius radius;
  final Radius radiusWhileDragging;
  final ScrollNotificationPredicate? notificationPredicate;
  final ScrollbarOrientation? scrollbarOrientation;

  const ScrollbarConfiguration({
    this.controller,
    this.thumbVisibility,
    this.thickness = defaultThickness,
    this.thicknessWhileDragging = defaultThicknessWhileDragging,
    this.radius = defaultRadius,
    this.radiusWhileDragging = defaultRadiusWhileDragging,
    this.notificationPredicate,
    this.scrollbarOrientation,
  });
}
