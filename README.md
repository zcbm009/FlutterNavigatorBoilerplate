# navigator_boilerplate

关于Navigator2.0的示例内容。代码来自于慕课网中Flutter高级：仿B站移动端的项目。

代码仅实现了关于Navigator2.0的使用，并自己维护了一个页面栈，项目尝试将代码从页面中分离开来，添加新页面时

如果需要添加页面则需要添加page_routes.dart文件下的RouteStatus与pagesType路由列表，注意枚举值的顺序要与页面的顺序相对应。

如果要对页面进行一些拦截处理，则可能需要处理page_stack页面栈，以及对于navigator本身做一些修改。

在添加新页面时需要使用`NavigatorUtil.getInstance().onJumpTo(RouteStatus.profile)`，其中`RouteStatus.profile`是自己添加的页面状态，代表路由要跳转的页面。

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

