import 'package:cupertino_refresh/cupertino_refresh.dart';
import 'package:flutter/cupertino.dart';

class CupertinoRefresh extends StatelessWidget {
  final Function onRefresh;
  final Widget child;
  final Duration delayDuration;
  final bool _hasScrollbar;

  const CupertinoRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.delayDuration = Duration.zero,
  })  : _hasScrollbar = false,
        super(key: key);

  const CupertinoRefresh.withScrollbar({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.delayDuration = Duration.zero,
  })  : _hasScrollbar = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final child_ = SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: child,
    );

    final widget = CustomScrollView(
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
        SliverToBoxAdapter(
          child: child_,
        ),
      ],
    );

    return _hasScrollbar ? CupertinoScrollbar(child: widget) : widget;
  }
}
