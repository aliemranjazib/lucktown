import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/error_screen/error_screen.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/models/product_model.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/ProfilePage.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/add_bank_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bankacounts_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/checktopup/checktopup_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/checktopup/checktopupmodel.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/currency_exchange.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/profile_transfer/profile_transfer_main.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/settings/forget_password/settingforget_otp_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/settings/forget_password/settingset_new_password.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/topup_bank_transfer/bantopup_main_page.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/withdraw/withdraw_page.dart';
import 'package:flutter_application_lucky_town/web/contact/contact_main.dart';
import 'package:flutter_application_lucky_town/web/home/web_home.dart';
import 'package:flutter_application_lucky_town/web/login_otp.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/product_detail_page.dart';
import 'package:flutter_application_lucky_town/web/select_country/web_main_page.dart';
import 'package:flutter_application_lucky_town/web/set_new_pin/web_set_new_pin_page.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/web_signin.dart';
import 'package:flutter_application_lucky_town/web/topUpMethod/usd_topup_method.dart';
import 'package:flutter_application_lucky_town/web/web_forget_page/forget_otp_page.dart';
import 'package:flutter_application_lucky_town/web/web_forget_page/set_new_password.dart';
import 'package:flutter_application_lucky_town/web/web_forget_page/web_forget_page.dart';
import 'package:go_router/go_router.dart';

import '../models/user_session_model.dart';
import '../web/ProfilePage/settings/forget_password/settingweb_forget_page.dart';
import '../web/ProfilePage/settings/setting_page.dart';
import '../web/transactions/transaction_mainpage.dart';
import '../web/web_otp/bind_otp_screen.dart';

class RouteCon {
  static const String check_page = 'webcheckpage';
  static const String auth_page = 'websauth';
  static const String usd_topup = 'webusdtopup';
  static const String signup_otp_page = 'webloginotppage';
  static const String scaffold_page = 'webscaffold';
  static const String home_Page = 'webhome';
  static const String signin_page = 'websignin';
  static const String bind_otp_page = 'web_otp';
  static const String set_new_pin_page = 'web_set_pin';
  static const String product_detail = 'web_detail_page';
  static const String profile_page = 'web_profile_page';
  static const String topup_usdt_page = 'web_topup_usdt_page';
  static const String contact_main_page = 'web_contact_main_page';
  static const String all_game_transaction_page =
      'web_all_game_transaction_page';
  static const String transaction_page = 'web_transaction_page';
  static const String currency_exchange_page = 'web_currency_exchange_page';
  static const String setting_page = 'web_setting_page';
  static const String bank_acount_page = 'web_bank_acount_page';
  static const String add_bank_acount_page = 'web_add_bank_acount_page';
  static const String bank_topup_main_page = 'web_bank_topup_main_page';
  static const String withdraw_page = 'web_withdraw_page';
  static const String forget_page = 'web_forget';
  static const String forget_otp = 'forget_otp';
  static const String set_new_password = 'set_new_password';
  static const String pending_top_up = 'pending_top_up';
  //////////////////////////
  static const String setting_forget_page = 'setting_forget_page';
  static const String setting_forget_otp = 'setting_forget_otp';
  static const String setting_set_new_password = 'setting_set_new_password';
  //////////profile transfer
  static const String profile_tranfer_main_page = 'profile_tranfer_main_page';

  ///

}

class AppRoute {
  GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      // case web_product_detail:
      //         // return ProductDetailPage();
      //         ProductsModelResponseProducts data =
      //             settings.arguments as ProductsModelResponseProducts;
      //         return ProductDetailPage(product: data);
      GoRoute(
        name: RouteCon.product_detail,
        path: "/productdetailpage",
        builder: (context, state) {
          ProductsModelResponseProducts pm = ProductsModelResponseProducts();
          pm = state.extra as ProductsModelResponseProducts;
          return ProductDetailPage(
            product: pm,
          );
        },
      ),

      GoRoute(
        name: RouteCon.set_new_pin_page,
        path: "/setnewpin",
        builder: (context, state) => WebSetNewPinPage(),
      ),

      GoRoute(
          name: RouteCon.profile_page,
          path: "/profile",
          builder: (context, state) => ProfilePage(),
          routes: [
            GoRoute(
              name: RouteCon.setting_page,
              path: "settings",
              builder: (context, state) {
                return SettingPage();
              },
            ),
            GoRoute(
              name: RouteCon.currency_exchange_page,
              path: "currency_exchange",
              builder: (context, state) {
                return CurrencyExchangePage();
              },
            ),
            GoRoute(
              name: RouteCon.profile_tranfer_main_page,
              path: "profile_tranfer_main_page",
              builder: (context, state) {
                return ProfileTransferPage();
              },
            ),
            GoRoute(
              name: RouteCon.bank_topup_main_page,
              path: "topupbank",
              builder: (context, state) => BankTopUpMainPage(),
            ),
            GoRoute(
              name: RouteCon.add_bank_acount_page,
              path: "addbank",
              builder: (context, state) => AddBankPage(),
            ),
            GoRoute(
              name: RouteCon.withdraw_page,
              path: "withdraw",
              builder: (context, state) => WithdrawPage(),
            ),
            GoRoute(
              name: RouteCon.pending_top_up,
              path: "pendingtopup",
              builder: (context, state) {
                PendtingTopUpModel ptm = state.extra as PendtingTopUpModel;
                return PendingTopUpPage(
                  ptm: ptm,
                );
              },
            ),
            GoRoute(
                name: RouteCon.setting_forget_page,
                path: "recoverpasswords",
                builder: (context, state) => SeetingWebForgetPage(),
                routes: [
                  GoRoute(
                    name: RouteCon.setting_forget_otp,
                    path: "forgetotps:userToken",
                    builder: (context, state) {
                      return SettingsForgetOtpPage(
                        userToken: state.params["userToken"]!,
                      );
                    },
                  ),
                  GoRoute(
                    name: RouteCon.setting_set_new_password,
                    path: "setnewpasswords",
                    builder: (context, state) {
                      SeetingTokenAndOtp two =
                          state.extra as SeetingTokenAndOtp;
                      return SettingsSetNewPasswordPage(
                        tokenAndOtp: two,
                      );
                    },
                  ),
                ]),
          ]),
      GoRoute(
        name: RouteCon.transaction_page,
        path: "/transactions",
        builder: (context, state) => TransactionMainPage(),
      ),
      GoRoute(
          name: RouteCon.forget_page,
          path: "/recoverpassword",
          builder: (context, state) => WebForgetPage(),
          routes: [
            GoRoute(
              name: RouteCon.forget_otp,
              path: "forgetotp:userToken",
              builder: (context, state) {
                return ForgetOtpPage(
                  userToken: state.params["userToken"]!,
                );
              },
            ),
            GoRoute(
              name: RouteCon.set_new_password,
              path: "setnewpassword",
              builder: (context, state) {
                TokenAndOtp two = state.extra as TokenAndOtp;
                return SetNewPasswordPage(
                  tokenAndOtp: two,
                );
              },
            ),
          ]),

      GoRoute(
        name: RouteCon.signup_otp_page,
        path: "/otp",
        builder: (context, state) => SignUpOTPScreen(),
      ),
      GoRoute(
        name: RouteCon.usd_topup,
        path: "/topupmehods",
        builder: (context, state) => TopUpMethodScreen(),
      ),
      GoRoute(
          name: RouteCon.home_Page,
          path: '/',
          builder: (context, state) => WebHomePage(),
          // pageBuilder: (context, state) => MaterialPage(child: WebScaffold()),
          redirect: (context, state) async {
            String data = await LuckySharedPef.getAuthToken();
            if (data.isEmpty) {
              return '/selectcountry';
            } else {
              Map<String, dynamic> info = await jsonDecode(data);
              if (info['msg'] == "User Login Success") {
                um = UserSessionModel.fromJson(info);
                return '/';
              } else
                return '/selectcountry';
            }
          },
          routes: []),
      GoRoute(
        name: RouteCon.contact_main_page,
        path: "/contacts",
        builder: (context, state) => ContactMainPage(),
      ),
      GoRoute(
        name: RouteCon.scaffold_page,
        path: "/selectcountry",
        builder: (context, state) => WebScaffold(),
      ),

      GoRoute(
        name: RouteCon.signin_page,
        path: "/auth",
        builder: (context, state) {
          return WebSignInPage();
        },
      ),
      GoRoute(
        name: RouteCon.bind_otp_page,
        path: "/bindotp",
        builder: (context, state) {
          return BindOTPScreen();
        },
      ),

      GoRoute(
        name: RouteCon.bank_acount_page,
        path: "/bankaccountpage",
        builder: (context, state) {
          return BankAcountsPage();
        },
      ),

      // GoRoute(
      //   name: RouteCon.web_scaffold_page,
      //   path: "/login",
      //   builder: (context, state) => WebSignInPage(),
      // ),
      // GoRoute(
      //   path: "/login",
      //   builder: (context, state) => WebSignInPage(),
      // ),
      // GoRoute(
      //   path: "/login",
      //   builder: (context, state) => WebSignInPage(),
      // ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}

// onGenerateRoute: (RouteSettings settings) {
//         return Routes.fadeThrough(settings, (context) {
//           switch (settings.name) {
//             case web_home_Page:
//               return WebHomePage();
//             case web_check_page:
//               return CheckPage();
//             case web_auth_page:
//               return CheckAuth();
//             case web_login_otp_page:
//               return LoginOTPScreen();
//             case web_product_detail:
//               // return ProductDetailPage();
//               ProductsModelResponseProducts data =
//                   settings.arguments as ProductsModelResponseProducts;
//               return ProductDetailPage(product: data);
//             // return ProductDetailPage();
//             case web_usd_topup:
//               return TopUpMethodScreen();
//             case web_forget_page:
//               return WebForgetPage();
//             case web_signin_page:
//               return WebSignInPage();
//             case web_otp_page:
//               // String data = settings.arguments as String;
//               return OTPScreen();
//             case web_set_new_pin_page:
//               // Map data = settings.arguments as Map;
//               return WebSetNewPinPage();
//             case web_scaffold_page:
//               return WebScaffold();
//             case web_topup_usdt_page:
//               return TopUpMethodScreen();
//             case web_profile_page:
//               return ProfilePage();
//             case web_contact_main_page:
//               return ContactMainPage();
//             case web_all_game_transaction_page:
//               return AllGameTransactionPage();
//             case web_transaction_page:
//               return TransactionMainPage();
//             case web_currency_exchange_page:
//               return CurrencyExchangePage();
//             case web_setting_page:
//               return SettingPage();
//             case web_bank_acount_page:
//               return BankAcountsPage();
//             case web_add_bank_acount_page:
//               return AddBankPage();
//             case web_bank_topup_main_page:
//               return BankTopUpMainPage();
//             case web_withdraw_page:
//               return WithdrawPage();
//             default:
//               return CircularProgressIndicator();
//           }
//         });
//       },
