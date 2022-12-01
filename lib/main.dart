import 'dart:convert';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/product_model.dart';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/utils/routes/lucky_routes.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/ProfilePage.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/add_bank_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bankacounts_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bankprovider.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/topup_bank_transfer/bantopup_main_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/checktopup/check_topup_provder.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/currency_exchange.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/setting_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/withdraw/withdraw_page.dart';
import 'package:flutter_application_lucky_town/web/check_auth.dart';
import 'package:flutter_application_lucky_town/web/contact/contact_main.dart';
import 'package:flutter_application_lucky_town/web/contact/contacts_detail.dart';
import 'package:flutter_application_lucky_town/web/login_otp.dart';
import 'package:flutter_application_lucky_town/web/menue_folder/menueProvider.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/product_detail_page.dart';
import 'package:flutter_application_lucky_town/web/select_country/viewModel/selectCountry.dart';
import 'package:flutter_application_lucky_town/web/topUpMethod/usd_topup_method.dart';
import 'package:flutter_application_lucky_town/web/transactions/transaction_mainpage.dart';
import 'package:flutter_application_lucky_town/web/transactions/transaction_provider.dart';
import 'package:flutter_application_lucky_town/web/web_forget_page.dart';
import 'package:flutter_application_lucky_town/web/home/web_home.dart';
import 'package:flutter_application_lucky_town/web/web_otp/web_otp_screen.dart';
import 'package:flutter_application_lucky_town/web/select_country/web_main_page.dart';
import 'package:flutter_application_lucky_town/web/set_new_pin/web_set_new_pin_page.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/web_signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  //////////////
//  usePathUrlStrategy();
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
      ChangeNotifierProvider<CheckTopUpProvider>(
        create: (context) => CheckTopUpProvider(),
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
            case web_check_page:
              return CheckPage();
            case web_auth_page:
              return CheckAuth();
            case web_login_otp_page:
              return LoginOTPScreen();
            case web_product_detail:
              // return ProductDetailPage();
              ProductsModelResponseProducts data =
                  settings.arguments as ProductsModelResponseProducts;
              return ProductDetailPage(product: data);
            // return ProductDetailPage();
            case web_usd_topup:
              return TopUpMethodScreen();
            case web_forget_page:
              return WebForgetPage();
            case web_signin_page:
              return WebSignInPage();
            case web_otp_page:
              // String data = settings.arguments as String;
              return OTPScreen();
            case web_set_new_pin_page:
              // Map data = settings.arguments as Map;
              return WebSetNewPinPage();
            case web_scaffold_page:
              return WebScaffold();
            case web_topup_usdt_page:
              return TopUpMethodScreen();
            case web_profile_page:
              return ProfilePage();
            case web_contact_main_page:
              return ContactMainPage();
            case web_all_game_transaction_page:
              return AllGameTransactionPage();
            case web_transaction_page:
              return TransactionMainPage();
            case web_currency_exchange_page:
              return CurrencyExchangePage();
            case web_setting_page:
              return SettingPage();
            case web_bank_acount_page:
              return BankAcountsPage();
            case web_add_bank_acount_page:
              return AddBankPage();
            case web_bank_topup_main_page:
              return BankTopUpMainPage();
            case web_withdraw_page:
              return WithdrawPage();
            default:
              return CircularProgressIndicator();
          }
        });
      },
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
      // home: web_scaffold_page,
      // initialRoute: LuckySharedPef.getAuthToken().isEmpty
      //     ? web_scaffold_page
      //     : web_home_Page,

      // initialRoute: web_signin_page,
      // initialRoute: LuckySharedPef.getAuthToken().isNotEmpty
      //     ? jsonDecode(LuckySharedPef.getAuthToken())['msg'] ==
      //             "User Login Success"
      //         ? web_home_Page
      //         : web_scaffold_page
      //     : web_scaffold_page,
      // initialRoute: ,
      // home: ContactsDetailPage(),
      initialRoute: web_check_page,
      // home: MyWidget(),

      // initialRoute: web_topup_usdt_page,
      // initialRoute: jsonDecode(LuckySharedPef.getAuthToken())['msg']

      // .isEmpty
      //     ? web_scaffold_page
      //     : web_home_Page,

      // home: ResponsiveLayout(
      //     mobileScaffold: MobileScaffold(),
      //     tabletScaffold: TabletScaffold(),
      //     webScaffold: WebScaffold()
      //     ),
    );
  }
}

UserSessionModel? um;

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  bool isLoading = false;
  // mm() {
  //   UserSessionModel? mm = Provider.of<LuckySharedPef>(context).um;
  //   print("make ${um!.msg}");
  // }

  checkNavigation() async {
    setState(() {
      isLoading = true;
    });
    String data = await LuckySharedPef.getAuthToken();
    if (data.isEmpty) {
      Navigator.pushNamed(
        context,
        web_scaffold_page,
      );
    } else {
      Map<String, dynamic> info = await jsonDecode(data);
      if (info['msg'] == "User Login Success") {
        setState(() {
          um = UserSessionModel.fromJson(info);
          Navigator.pushNamedAndRemoveUntil(
              context, web_home_Page, (route) => false);
          print(um!.response!.authToken);
        });
      } else {
        Navigator.pushNamed(
          context,
          web_scaffold_page,
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      checkNavigation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // mm();
    return Scaffold(
        backgroundColor: Colors.black,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(child: CircularProgressIndicator()));
  }
}

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
