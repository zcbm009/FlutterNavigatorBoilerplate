import 'package:flutter/material.dart';
import 'package:navigator_boilerplate/pages/index.dart';
import 'package:navigator_boilerplate/pages/profiles.dart';
import 'package:navigator_boilerplate/utils/navigator/page_routes.dart';
import 'package:navigator_boilerplate/utils/navigator/page_stack.dart';

import 'navigator_utils.dart';

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<BiliRoutePath>,
        PageStack {
  final GlobalKey<NavigatorState> navigationKey;

  // 拥有初始化列表的构造函数
  BiliRouteDelegate() : navigationKey = GlobalKey<NavigatorState>() {
    // 注册路由跳转监听器
    NavigatorUtil.getInstance().registerRouteJump(
      RouteJumpListener((routeStatus, {args}) {
        _routeStatus = routeStatus;
        if (routeStatus == RouteStatus.profile) {
          // videoModel = args?['videoModel'];
        }
        notifyListeners();
      }),
    );
  }

  RouteStatus _routeStatus = RouteStatus.home;

  late BiliRoutePath path;

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {
    path = configuration;
  }

  RouteStatus get routeStatus {
    // todo 根据routeStatus的状态进行跳转拦截
    return _routeStatus;
  }

  // bool get hasLogin => LoginDao.getToken() != null;
  bool get hasLogin => true;

  @override
  Widget build(BuildContext context) {
    List<MaterialPage> tempPages = pages;

    // 重新创建一个数组，否则会因为引用没有改变而不生效
    tempPages = handlePageChange(tempPages, routeStatus);
    // 触发新页面添加的监听器
    NavigatorUtil.getInstance().notify(tempPages, pages);
    pages = tempPages;

    return WillPopScope(
        child: Navigator(
          key: navigationKey,
          pages: pages,
          onPopPage: (route, result) {
            // tips 只剩一个页面时不会触发此回调，会被onWillPop拦截
            if (route.settings is MaterialPage) {
              // 登录判定
              // if ((route.settings as MaterialPage).child is LoginPage) {
              //   if (!hasLogin) {
              //     ToastUtils.showNormalToast("请先登录");
              //     return false;
              //   }
              // }
            }
            // print('${route.didPop(result)}');
            // 控制是否可以返回页面
            if (!route.didPop(result)) {
              return false;
            }
            // 当页面可以弹出就移除页面中的最后一个页面，当页面弹出时触发监听器
            var tempPages = [...pages];
            pages.removeLast();
            NavigatorUtil.getInstance().notify(pages, tempPages);

            return true;
          },
        ),
        // 解决安卓机物理返回按钮的兼容问题
        onWillPop: () async => !(await navigationKey.currentState!.maybePop()));
  }

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? get navigatorKey => navigationKey;
}

class BiliInformationParser extends RouteInformationParser<BiliRoutePath> {
  @override
  Future<BiliRoutePath> parseRouteInformationWithDependencies(
      RouteInformation routeInformation, BuildContext context) async {
    var uri = Uri.parse(routeInformation.location!);
    print("uri: ${uri}");
    if (uri.pathSegments.isEmpty) {
      return BiliRoutePath.home();
    }
    return BiliRoutePath.detail();
  }
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}
