import 'package:flutter/material.dart';
import 'package:navigator_boilerplate/pages/index.dart';
import 'package:navigator_boilerplate/pages/profiles.dart';

/**
 * 在此添加页面路由
 */

/// 路由状态与页面绑定对象
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

enum RouteStatus {
  profile(pageName: "个人信息页"),
  home(pageName: "首页"),
  unknown(pageName: "未知");

  final String pageName;

  const RouteStatus({required this.pageName});
}

List<Type> pagesType = [ProfilesPage, IndexPage];

/// 根据页面返回路由状态
RouteStatus getRouteStatus(MaterialPage page) {
  for (int index = 0; index < pagesType.length; index++) {
    if (page.runtimeType == pagesType[index]) {
      return RouteStatus.values[index];
    }
  }
  return RouteStatus.unknown;

  // if (page.child is IndexPage) {
  //   return RouteStatus.home;
  // } else if (page.child is ProfilesPage) {
  //   return RouteStatus.profile;
  // } else {
  //   return RouteStatus.unknown;
  // }
}
