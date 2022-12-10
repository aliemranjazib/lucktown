import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bankprovider.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/checktopup/check_topup_provder.dart';
import 'package:flutter_application_lucky_town/web/menue_folder/menueProvider.dart';
import 'package:flutter_application_lucky_town/web/select_country/viewModel/selectCountry.dart';
import 'package:flutter_application_lucky_town/web/transactions/transaction_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  //////////////
  setPathUrlStrategy();
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
  // final GoRouter _router = GoRouter(
  //   routes: [
  //     GoRoute(
  //       path: "/",
  //       builder: (context, state) => WebScaffold(),
  //     ),
  //     GoRoute(
  //       path: "/login",
  //       builder: (context, state) => WebSignInPage(),
  //     ),
  //   ],
  // );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LuckTown',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoute().router,
      // onGenerateRoute: MyRoutes.genrateRoute,
      // routeInformationParser: AppRoute().router.routeInformationParser,
      // routerDelegate: AppRoute().router.routerDelegate,
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

// class CheckPage extends StatefulWidget {
//   const CheckPage({super.key});

//   @override
//   State<CheckPage> createState() => _CheckPageState();
// }

// class _CheckPageState extends State<CheckPage> {
//   bool isLoading = false;
//   // mm() {
//   //   UserSessionModel? mm = Provider.of<LuckySharedPef>(context).um;
//   //   print("make ${um!.msg}");
//   // }

//   checkNavigation() async {
//     setState(() {
//       isLoading = true;
//     });
//     String data = await LuckySharedPef.getAuthToken();
//     if (data.isEmpty) {
//       Navigator.pushNamed(
//         context,
//         web_scaffold_page,
//       );
//     } else {
//       Map<String, dynamic> info = await jsonDecode(data);
//       if (info['msg'] == "User Login Success") {
//         setState(() {
//           um = UserSessionModel.fromJson(info);
//           Navigator.pushNamedAndRemoveUntil(
//               context, web_home_Page, (route) => false);
//           print(um!.response!.authToken);
//         });
//       } else {
//         Navigator.pushNamed(
//           context,
//           web_scaffold_page,
//         );
//       }
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () async {
//       checkNavigation();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // mm();
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: isLoading
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Center(child: CircularProgressIndicator()));
//   }
// }

// class MyWidget extends StatelessWidget {

// class ResponsiveLayout extends StatelessWidget {
//   final Widget mobileScaffold;
//   final Widget? tabletScaffold;
//   final Widget webScaffold;
//   ResponsiveLayout(
//       {required this.mobileScaffold,
//       this.tabletScaffold,
//       required this.webScaffold});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         if (constraints.maxWidth < 600) {
//           return mobileScaffold;
//           // } else if (constraints.maxWidth >= 500 &&
//           //     constraints.maxWidth <= 1100) {
//           //   return tabletScaffold;
//           // }
//         } else {
//           return webScaffold;
//         }
//       },
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go("/settings"),
          child: const Text("Go to Settings page"),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text("Settings"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go("/pick"),
          child: const Text("Go to pick page"),
        ),
      ),
    );
  }
}

class PickPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text("Pick"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go("/"),
          child: const Text("Go to home page"),
        ),
      ),
    );
  }
}
