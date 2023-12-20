import 'package:flutter/material.dart';
import 'package:navigator_boilerplate/utils/navigator/navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BiliRouteDelegate _biliRouteDelegate = BiliRouteDelegate();

  MyApp({super.key});

  _appPreparing() {
    return const Duration(seconds: 3);
  }

  _loadingPage() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(_appPreparing()),
        builder: (context, snapshot) {
          // 判断future的加载状态，实现加载页的效果
          final widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _biliRouteDelegate)
              : _loadingPage();
          return MaterialApp(home: widget);
        });
  }
}
