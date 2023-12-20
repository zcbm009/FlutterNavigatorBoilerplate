import 'package:flutter/material.dart';
import 'package:navigator_boilerplate/pages/index.dart';
import 'package:navigator_boilerplate/pages/profiles.dart';
import 'package:navigator_boilerplate/utils/navigator/page_routes.dart';

/// 获取页面在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int index = 0; index < pages.length; index++) {
    if (getRouteStatus(pages[index]) == routeStatus) {
      return index;
    }
  }
  return -1;
}

pageWrapper(Widget child) {
  // key要保证唯一
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

mixin class PageStack {
  // 路由列表
  List<MaterialPage> pages = [];

  List<MaterialPage> handlePageChange(List<MaterialPage> oldPages, RouteStatus routeStatus) {
    var pageIndex = getPageIndex(oldPages, routeStatus);
    if (pageIndex != -1) {
      // 页面在页面栈中，则弹出该页面之前的所有页面
      oldPages = oldPages.sublist(0, pageIndex);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      // 首页无法弹出，所以直接清空栈
      pages.clear();
      page = pageWrapper(const IndexPage());
    } else if (routeStatus == RouteStatus.profile) {
      page = pageWrapper(const ProfilesPage());
      // } else if (routeStatus == RouteStatus.detail && videoModel != null) {
      //   page = pageWrapper(VideoDetailsPage(videoModel: videoModel!));
    }

    // 重新创建一个数组，否则会因为引用没有改变而不生效
    return [...oldPages, page];
  }
}
