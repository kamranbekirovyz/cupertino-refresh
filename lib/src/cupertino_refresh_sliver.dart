import 'package:flutter/cupertino.dart';

class CupertinoRefreshSliver extends StatelessWidget {
  final Function onRefresh;
  final Duration delayDuration;

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
