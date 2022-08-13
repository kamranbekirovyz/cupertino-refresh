import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  final String favorite;
  final int index;

  const FavoriteItem(
    this.favorite, {
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '#${index + 1}',
        style: CupertinoTheme.of(context).textTheme.actionTextStyle,
      ),
      dense: true,
      title: Text(
        favorite,
        style: CupertinoTheme.of(context).textTheme.textStyle,
      ),
    );
  }
}
