import 'package:flutter/material.dart';

abstract class PageContent {
  title();

  navProfile();
}

mixin class BodyBoilerplate {
  body(Widget body) {
    return Scaffold(body: body);
  }
}
