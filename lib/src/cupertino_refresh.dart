import 'package:cupertino_refresh/cupertino_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoRefresh extends StatelessWidget {
  /// The widget that is being wrapped around refresh control and is below this
  /// widget in the widget tree.
  ///
  /// [child] argument must not necessarily be a scrollable widget as any kind of
  /// widget can be assigned.
  final Widget child;

  /// A void function that is called when the user has dragged the refresh control
  /// far enough to demonstrate that they want the content to be refreshed.
  final Function onRefresh;

  /// An extra duration to delay "refreshing" animation completion after
  /// [onRefresh] function ends.
  final Duration delayDuration;

  /// Optional [ScrollController] which will be assigned to the [CustomScrollView]
  ///
  /// If you want to assign [ScrollController] to the [Scrollbar] instead,
  /// use [scrollController] argument of [ScrollbarConfiguration]
  final ScrollController? controller;

  /// [ScrollViewKeyboardDismissBehavior] the defines how this [ScrollView] will
  /// dismiss the keyboard automatically.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// How the scroll view should respond to user input.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// Configurations for [Scrollbar]
  ///
  /// Only has any effects when [CupertinoRefresh.withScrollbar] is being used
  final ScrollbarConfiguration scrollbarConfiguration;

  /// flag for whether [CupertinoRefresh] has [Scrollbar] or not
  final bool _hasScrollbar;

  /// Creates a iOS-styled refresh control.
  ///
  /// The [onRefresh] and [child] arguments must be specified.
  const CupertinoRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.controller,
    this.physics,
    this.delayDuration = Duration.zero,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.scrollbarConfiguration = const ScrollbarConfiguration(),
  })  : _hasScrollbar = false,
        super(key: key);

  /// Creates an iOS-styled refresh control with iOS-styled scrollbar.
  ///
  /// The [onRefresh] and [child] arguments must be specified.
  const CupertinoRefresh.withScrollbar({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.controller,
    this.physics,
    this.delayDuration = Duration.zero,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.scrollbarConfiguration = const ScrollbarConfiguration(),
  })  : _hasScrollbar = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final child_ = SingleChildScrollView(
      keyboardDismissBehavior: keyboardDismissBehavior,
      physics: physics,
      child: child,
    );

    final widget = CustomScrollView(
      controller: controller,
      keyboardDismissBehavior: keyboardDismissBehavior,
      physics: physics,
      slivers: [
        CupertinoRefreshSliver(
          delayDuration: delayDuration,
          onRefresh: onRefresh,
        ),
        SliverToBoxAdapter(child: child_),
      ],
    );

    return _hasScrollbar
        ? CupertinoScrollbar(
            controller: scrollbarConfiguration.controller,
            thumbVisibility: scrollbarConfiguration.thumbVisibility,
            thickness: scrollbarConfiguration.thickness,
            thicknessWhileDragging:
                scrollbarConfiguration.thicknessWhileDragging,
            radius: scrollbarConfiguration.radius,
            radiusWhileDragging: scrollbarConfiguration.radiusWhileDragging,
            notificationPredicate: scrollbarConfiguration.notificationPredicate,
            scrollbarOrientation: scrollbarConfiguration.scrollbarOrientation,
            child: widget,
          )
        : widget;
  }
}
