import 'package:flutter/material.dart';
import 'package:navigator_boilerplate/utils/navigator/page_routes.dart';

typedef OnJumpTo = Function(RouteStatus routeStatus, {Map? args});

typedef RouteChangeListener = Function(
    RouteStatusInfo current, RouteStatusInfo? pre);

abstract class _RouteJumpListener {
  onJumpTo(RouteStatus status, {Map args});
}

class NavigatorUtil extends _RouteJumpListener {
  static NavigatorUtil? _instance;
  RouteJumpListener? _routeJumpListener;

  // 页面监听器
  final List<RouteChangeListener> _listeners = [];

  // 当前页面的路由状态信息
  RouteStatusInfo? _current;
  RouteStatusInfo? _bottomTab;

  NavigatorUtil._();

  static NavigatorUtil getInstance() {
    _instance ??= NavigatorUtil._();
    return _instance!;
  }

  // 监听主页底部tab栏的切换
  void onBottomTanChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJumpListener = routeJumpListener;
  }

  void addListener(RouteChangeListener routeChangeListener) {
    _listeners.add(routeChangeListener);
  }

  void removeListener(RouteChangeListener? routeChangeListener) {
    _listeners.remove(routeChangeListener);
  }

  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current = RouteStatusInfo(
        getRouteStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo routeStatusInfo) {
    // if (_current?.page is BottomNavigator && _bottomTab != null) {
    //   _current = _bottomTab;
    // }
    print("currentPage: ${routeStatusInfo.page}");
    print("prePage: ${_current?.page}");
    for (var element in _listeners) {
      element(routeStatusInfo, _current);
    }
    _current = routeStatusInfo;
  }

  @override
  onJumpTo(RouteStatus status, {Map<dynamic, dynamic>? args}) {
    _routeJumpListener?.onJumpTo(status, args: args);
  }
}

class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener(this.onJumpTo);
}
