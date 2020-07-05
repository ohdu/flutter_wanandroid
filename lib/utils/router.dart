import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wan_android/pages/index_page.dart';
import 'package:wan_android/pages/main_page/home_page.dart';
import 'package:wan_android/pages/person_page/user_login_page.dart';
import 'route_paths.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.loginPage:
        return MaterialPageRoute(builder: (_) => UserLoginPage());
      case RoutePaths.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RoutePaths.indexPage:
        return MaterialPageRoute(builder: (_) => IndexPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('没有找到对应的页面：${settings.name}'),
                  ),
                ));
    }
  }
}
