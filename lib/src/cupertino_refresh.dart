import 'package:cupertino_refresh/cupertino_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoRefresh extends StatefulWidget {
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
  State<CupertinoRefresh> createState() => _CupertinoRefreshState();
}

class _CupertinoRefreshState extends State<CupertinoRefresh> {
  ScrollController? _controller;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = ScrollController();
    }
  }

  ScrollController get _scrollController => widget.controller ?? _controller!;

  @override
  Widget build(BuildContext context) {
    final widget_ = CustomScrollView(
      controller: _scrollController,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      physics: widget.physics,
      slivers: [
        CupertinoRefreshSliver(
          delayDuration: widget.delayDuration,
          onRefresh: widget.onRefresh,
        ),
        SliverToBoxAdapter(child: widget.child),
      ],
    );

    return widget._hasScrollbar
        ? CupertinoScrollbar(
            controller: _scrollController,
            thumbVisibility: widget.scrollbarConfiguration.thumbVisibility,
            thickness: widget.scrollbarConfiguration.thickness,
            thicknessWhileDragging: widget.scrollbarConfiguration.thicknessWhileDragging,
            radius: widget.scrollbarConfiguration.radius,
            radiusWhileDragging: widget.scrollbarConfiguration.radiusWhileDragging,
            notificationPredicate: widget.scrollbarConfiguration.notificationPredicate,
            scrollbarOrientation: widget.scrollbarConfiguration.scrollbarOrientation,
            child: widget_,
          )
        : widget_;
  }
}
