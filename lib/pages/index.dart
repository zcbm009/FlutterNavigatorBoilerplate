import 'package:flutter/material.dart';
import 'package:navigator_boilerplate/pages/interfaces/page_content.dart';
import 'package:navigator_boilerplate/utils/navigator/navigator_utils.dart';
import 'package:navigator_boilerplate/utils/navigator/page_routes.dart';

class IndexPage extends StatelessWidget
    with BodyBoilerplate
    implements PageContent {
  const IndexPage({super.key});

  @override
  title() {
    return const Text(
      "首页",
      style: TextStyle(fontSize: 22.0),
    );
  }

  @override
  navProfile() {
    return TextButton(
        onPressed: () {
          print("nav to profile");
          NavigatorUtil.getInstance().onJumpTo(RouteStatus.profile);
        },
        child: const Text("进入个人信息页"));
  }

  @override
  Widget build(BuildContext context) {
    return body(Center(
        child: Column(
      children: [title(), navProfile()],
    )));
  }
}
