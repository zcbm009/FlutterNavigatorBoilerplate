import 'package:flutter/material.dart';
import 'package:navigator_boilerplate/pages/interfaces/page_content.dart';
import 'package:navigator_boilerplate/utils/navigator/page_routes.dart';

import '../utils/navigator/navigator_utils.dart';

class ProfilesPage extends StatelessWidget
    with BodyBoilerplate
    implements PageContent {
  const ProfilesPage({super.key});

  @override
  title() {
    return const Text(
      "个人信息页",
      style: TextStyle(fontSize: 22.0),
    );
  }

  @override
  navProfile() {
    return TextButton(
        onPressed: () {
          print("nav to index");
          NavigatorUtil.getInstance().onJumpTo(RouteStatus.home);
        },
        child: const Text("进入首页"));
  }

  @override
  Widget build(BuildContext context) {
    return body(Center(
      child: Column(
        children: [title(), navProfile()],
      ),
    ));
  }
}
