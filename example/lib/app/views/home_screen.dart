import 'package:app/app/views/tabs/list_view_example_tab.dart';
import 'package:app/app/views/tabs/sliver_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Flutter Favorites'),
        ),
        child: CupertinoTabScaffold(
          tabBuilder: (context, index) {
            return SafeArea(
              child: index == 0
                  ? const ListViewExampleTab()
                  : const SliverExample(),
            );
          },
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_bullet),
                label: 'ListView',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_bullet_below_rectangle),
                label: 'Sliver',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
