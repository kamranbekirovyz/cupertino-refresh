import 'package:app/app/data/flutter_favorites.dart';
import 'package:app/app/widgets/favorite_item.dart';
import 'package:cupertino_refresh/cupertino_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverExample extends StatefulWidget {
  const SliverExample({Key? key}) : super(key: key);

  @override
  State<SliverExample> createState() => _SliverExampleState();
}

class _SliverExampleState extends State<SliverExample> {
  final _flutterFavorites = <String>[];

  @override
  void initState() {
    super.initState();
    _flutterFavorites.addAll(flutterFavorites);
  }

  Future<void> _fetch() async {
    await Future.delayed(const Duration(milliseconds: 750));
    _flutterFavorites.shuffle();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        /// Using [CupertinoRefreshSliver] is pretty straightforward as the rest
        /// of the [CustomScrollView] children are up to you to be built using[] Sliver]s
        CupertinoRefreshSliver(onRefresh: _fetch),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16.0),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: _flutterFavorites.length,
              (_, int index) {
                final favorite = _flutterFavorites.elementAt(index);

                return FavoriteItem(favorite, index: index);
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16.0),
        ),
      ],
    );
  }
}
