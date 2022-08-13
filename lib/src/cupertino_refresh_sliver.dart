import 'package:flutter/cupertino.dart';

class CupertinoRefreshSliver extends StatelessWidget {
  /// A void function that is called when the user has dragged the refresh control
  /// far enough to demonstrate that they want the content to be refreshed.
  final Function onRefresh;

  /// An extra duration to delay "refreshing" animation completion after
  /// [onRefresh] function ends.
  final Duration delayDuration;

  /// Creates a iOS-like refresh control as a [Sliver] so that it can be used as a
  /// child, ideally first one, of [CustomScrollView].
  ///
  /// The [onRefresh] and [child] arguments must be specified.
  const CupertinoRefreshSliver({
    Key? key,
    required this.onRefresh,
    this.delayDuration = Duration.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: () {
        return Future.microtask(() async {
          await onRefresh.call();
          await Future.delayed(delayDuration);
        });
      },
    );
  }
}
