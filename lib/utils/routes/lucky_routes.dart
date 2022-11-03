import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/mobile/mobile_scaffold.dart';
import 'package:flutter_application_lucky_town/mobile/mobile_signin.dart';
import 'package:flutter_application_lucky_town/tablet/tablet_scaffold.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/web_forget_page.dart';
import 'package:flutter_application_lucky_town/web/web_otp_screen.dart';
import 'package:flutter_application_lucky_town/web/web_scaffold.dart';
import 'package:flutter_application_lucky_town/web/web_set_new_pin_page.dart';
import 'package:flutter_application_lucky_town/web/web_signin.dart';

import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

class Routes {
  // static const String home = "/";
  // static const String post = "post";
  // static const String style = "style";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}

class MyRoutes {
  static Route<dynamic> genrateRoute(RouteSettings setting) {
    switch (setting.name) {
      //web
      case web_home_Page:
        return MaterialPageRoute(builder: (context) => WebScaffold());
      case web_otp_page:
        // var data = setting.arguments as Map;
        String data = setting.arguments as String;
        return MaterialPageRoute(builder: (context) => OTPScreen(data: data));
      case web_forget_page:
        return MaterialPageRoute(builder: (context) => WebForgetPage());
      case web_set_new_pin_page:
        return MaterialPageRoute(builder: (context) => WebSetNewPinPage());
      case web_signin_page:
        var data = setting.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => WebSignInPage(data: data));
      //mobile
      case mobilehomePage:
        return MaterialPageRoute(builder: (context) => MobileScaffold());
      case mobileSigninPage:
        // var d = setting.arguments as String;
        var data = setting.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => MobileSignInPage(data: data));
      //tablet
      case tablethomePage:
        return MaterialPageRoute(builder: (context) => TabletScaffold());
      default:
    }
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Text('no route defined'),
      ),
    );
  }
}
