import 'package:app/app/data/flutter_favorites.dart';
import 'package:app/app/widgets/favorite_item.dart';
import 'package:cupertino_refresh/cupertino_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewExampleTab extends StatefulWidget {
  const ListViewExampleTab({Key? key}) : super(key: key);

  @override
  State<ListViewExampleTab> createState() => _ListViewExampleTabState();
}

class _ListViewExampleTabState extends State<ListViewExampleTab> {
  final _flutterFavorites = <String>[];

  @override
  void initState() {
    super.initState();
    _flutterFavorites.addAll(flutterFavorites);
  }

  Future<void> _fetch() async {
    await Future.delayed(const Duration(milliseconds: 750));
    flutterFavorites.shuffle();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoRefresh.withScrollbar(
      onRefresh: _fetch,

      /// The child of [CupertinoRefresh] widget must not be necessarily a
      /// scrollable widget as it can be any widget
      child: Column(
        children: [
          const SizedBox(height: 16.0),

          /// While using with [SingleChildScrollView] is seamless,
          /// [ListView] has its limitations as commented below:
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),

            // [itemCount] must be specified/can not be infinite
            itemCount: flutterFavorites.length,

            /// [shrinkWrap] must be set as "true", otherwise you'll get [RenderViewport] issue
            shrinkWrap: true,

            /// For better control set [NeverScrollableScrollPhysics] to [physics]
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, int index) {
              final favorite = flutterFavorites.elementAt(index);

              return FavoriteItem(favorite, index: index);
            },
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
