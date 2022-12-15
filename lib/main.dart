import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bankprovider.dart';
// import 'package:flutter_application_lucky_town/web/ProfilePage/checktopup/check_topup_provder.dart';
import 'package:flutter_application_lucky_town/web/menue_folder/menueProvider.dart';
import 'package:flutter_application_lucky_town/web/select_country/viewModel/selectCountry.dart';
import 'package:flutter_application_lucky_town/web/transactions/transaction_provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
// import 'package:url_strategy/url_strategy.dart';

void main() async {
  //////////////
  // setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await LuckySharedPef.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SelectCountry>(
        create: (context) => SelectCountry(),
      ),
      ChangeNotifierProvider<MenuProvider>(
        create: (context) => MenuProvider(),
      ),
      ChangeNotifierProvider<LuckySharedPef>(
        create: (context) => LuckySharedPef(),
      ),
      ChangeNotifierProvider<BankProvider>(
        create: (context) => BankProvider(),
      ),
      ChangeNotifierProvider<TransactionProvider>(
        create: (context) => TransactionProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LuckTown',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoute().router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
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
    );
  }
}

UserSessionModel? um;
