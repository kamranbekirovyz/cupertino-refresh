import 'package:cupertino_refresh/cupertino_refresh.dart';
import 'package:flutter/cupertino.dart';

class CupertinoRefresh extends StatelessWidget {
  final Function onRefresh;
  final Widget child;
  final Duration delayDuration;
  final ScrollController? controller;

  final ScrollbarConfiguration _scrollbarConfiguration;
  final bool _hasScrollbar;

  const CupertinoRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.delayDuration = Duration.zero,
    this.controller,
    ScrollbarConfiguration? scrollbarConfiguration,
  })  : _hasScrollbar = false,
        _scrollbarConfiguration = const ScrollbarConfiguration(),
        super(key: key);

  const CupertinoRefresh.withScrollbar({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.controller,
    ScrollbarConfiguration? scrollbarConfiguration,
    this.delayDuration = Duration.zero,
  })  : _hasScrollbar = true,
        _scrollbarConfiguration = scrollbarConfiguration ?? const ScrollbarConfiguration(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.hashCode == _scrollbarConfiguration.controller.hashCode;

    final child_ = SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: child,
    );

    final widget = CustomScrollView(
      controller: controller,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: [
        CupertinoRefreshSliver(
          delayDuration: delayDuration,
          onRefresh: () async {
            return Future.microtask(() async {
              await Future.delayed(delayDuration);
              await onRefresh.call();
            });
          },
        ),
        SliverToBoxAdapter(child: child_),
      ],
    );

    return _hasScrollbar
        ? CupertinoScrollbar(
            controller: _scrollbarConfiguration.controller,
            thumbVisibility: _scrollbarConfiguration.thumbVisibility,
            thickness: _scrollbarConfiguration.thickness,
            thicknessWhileDragging: _scrollbarConfiguration.thicknessWhileDragging,
            radius: _scrollbarConfiguration.radius,
            radiusWhileDragging: _scrollbarConfiguration.radiusWhileDragging,
            notificationPredicate: _scrollbarConfiguration.notificationPredicate,
            scrollbarOrientation: _scrollbarConfiguration.scrollbarOrientation,
            child: widget,
          )
        : widget;
  }
}
