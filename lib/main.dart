import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/product_model.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/utils/routes/lucky_routes.dart';
import 'package:flutter_application_lucky_town/web/check_auth.dart';
import 'package:flutter_application_lucky_town/web/login_otp.dart';
import 'package:flutter_application_lucky_town/web/menue_folder/menueProvider.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page.dart';
import 'package:flutter_application_lucky_town/web/select_country/viewModel/selectCountry.dart';
import 'package:flutter_application_lucky_town/web/topUpMethod/topup_method.dart';
import 'package:flutter_application_lucky_town/web/web_forget_page.dart';
import 'package:flutter_application_lucky_town/web/web_home.dart';
import 'package:flutter_application_lucky_town/web/web_otp_screen.dart';
import 'package:flutter_application_lucky_town/web/select_country/view/web_scaffold.dart';
import 'package:flutter_application_lucky_town/web/web_set_new_pin_page.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/web_signin.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  //////////////
  // setPathUrlStrategy();
  await LuckySharedPef.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SelectCountry>(
        create: (context) => SelectCountry(),
      ),
      ChangeNotifierProvider<MenuProvider>(
        create: (context) => MenuProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LuckTown',
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: MyRoutes.genrateRoute,
      onGenerateRoute: (RouteSettings settings) {
        return Routes.fadeThrough(settings, (context) {
          switch (settings.name) {
            case web_home_Page:
              return WebHomePage();
            case web_auth_page:
              return CheckAuth();
            case web_login_otp_page:
              return LoginOTPScreen();
            case web_product_detail:
              // return ProductDetailPage();
              Products data = settings.arguments as Products;
              return ProductDetailPage(product: data);
            // return ProductDetailPage();
            case web_usd_topup:
              return TopUpMethodScreen();
            case web_forget_page:
              return WebForgetPage();
            case web_signin_page:
              // var data = settings.arguments as Map;
              return WebSignInPage();
            case web_otp_page:
              String data = settings.arguments as String;
              return OTPScreen(data: data);
            case web_set_new_pin_page:
              return WebSetNewPinPage();
            case web_scaffold_page:
              return WebScaffold();
            default:
              return const SizedBox.shrink();
          }
        });
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: "gotham",
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        // maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      // home: web_scaffold_page,
      initialRoute: LuckySharedPef.getAuthToken().isEmpty
          ? web_scaffold_page
          : web_home_Page,
      // home: ResponsiveLayout(
      //     mobileScaffold: MobileScaffold(),
      //     tabletScaffold: TabletScaffold(),
      //     webScaffold: WebScaffold()
      //     ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget? tabletScaffold;
  final Widget webScaffold;
  ResponsiveLayout(
      {required this.mobileScaffold,
      this.tabletScaffold,
      required this.webScaffold});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return mobileScaffold;
          // } else if (constraints.maxWidth >= 500 &&
          //     constraints.maxWidth <= 1100) {
          //   return tabletScaffold;
          // }
        } else {
          return webScaffold;
        }
      },
    );
  }
}
