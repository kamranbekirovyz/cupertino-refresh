import 'package:app/app/views/home_screen.dart';
import 'package:flutter/cupertino.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'cupertino_refresh',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
