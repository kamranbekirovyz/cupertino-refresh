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
      onRefresh: () async {
        return Future.microtask(() async {
          await Future.delayed(delayDuration);
          await onRefresh.call();
        });
      },
    );
  }
}
