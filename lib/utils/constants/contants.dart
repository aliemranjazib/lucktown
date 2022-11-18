import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/select_country_model.dart';

//////////////// ROUTES /////////////////////
//web
const String web_auth_page = '/websauth';
const String web_usd_topup = '/webusdtopup';
const String web_login_otp_page = '/webloginotppage';
const String web_scaffold_page = '/webscaffold';
const String web_home_Page = '/webhome';
const String web_signin_page = '/websignin';
const String web_otp_page = '/web_otp';
const String web_forget_page = '/web_forget';
const String web_set_new_pin_page = '/web_set_pin';
const String web_product_detail = '/web_detail_page';
const String web_profile_page = '/web_profile_page';
const String web_topup_usdt_page = '/web_topup_usdt_page';

//mobile
// const String mobilehomePage = '/mobilehome';
// const String mobileSigninPage = '/mobilesignin';

//tablet
// const String tablethomePage = '/tablethome';
//////////////// IMAGES  ////////////////////

const String chat = "assets/images/chat.png";
const String navbar_logo = "assets/images/nav_bar_logo.png";
const String navbar_gift = "assets/images/gift.png";
const String navbar_search = "assets/images/search.png";
const String banner = "assets/images/egame_banner.png";
const String avatar = "assets/images/avatar.png";
const String qrIcon = "assets/images/qrcode.png";
const String Hnadcoin = "assets/images/coin.jpg";
const String girl = "assets/images/girl.png";
const String favourite = "assets/images/favourite.png";
/////////////// home page icons ///////////////////////
const String popular = "assets/images/popular.png";
const String Favourite = "assets/images/feavourite.png";
const String LiveCasino = "assets/images/casino.png";
const String egame = "assets/images/egame.png";
const String lottery = "assets/images/lottery.png";
const String sport = "assets/images/sport.png";

/////////////////////// PROFILE ///////////////////////////////
const String gameIcon = "assets/images/AG2.png";

//////////////////// product detail page icons ///////////////
const String detail_page_banner =
    "assets/images/product_detail_page_banner.png";
const String arrow_left = "assets/images/arrow-left.png";

const String topup = "assets/images/topup.png";
const String transaction = "assets/images/transaction.png";

const String eye_open = "assets/images/eye_open.png";
const String bg = "assets/images/bg.png";
const String logo = "assets/images/logo.png";
const String pCoin = "assets/images/coin.jpg";
const String spinMove = "assets/images/spin_move.png";
const String giftBox = "assets/images/gift_box.png";
const String mobilebg = "assets/images/Frame.png";
const String userIcon = "assets/images/user.png";
const String unlockIcon = "assets/images/unlock.png";

//country pickers
const String singapore = "assets/images/singapore.png";
const String malaysia = "assets/images/malaysia.png";
const String thailand = "assets/images/thailand.png";
const String vietnam = "assets/images/vietnam.png";

/// social
const String google = "assets/images/google.png";
const String facebook = "assets/images/facebook.png";
////////////////////////////////////////////////////////////////
const String line = "assets/images/line.png";
const String star = "assets/images/star.png";
const String info = "assets/images/subtract.png";

const String tabletsidebar = "assets/images/tablets_sidebar.png";
const String tabletrightbar = "assets/images/one.png";

const String country_picker = "assets/images/country_pick.png";
const String footerbrand = "assets/images/mask-group-1.png";

////////////////// Profile page //////////////////////

const String gift = "assets/images/gift_n.png";

////////////// COLORS //////////////////////////
const bgColor = Color(0xF5F5F5);
const primaryColor = Color(0xffFCD877);
////////////////////// FONTS  //////////////

const String gotham_light = "gotham-light";
const String gotham = "gotham";
final roboto = GoogleFonts.roboto();

///// Profile Page Icons /////

const String topUp = 'assets/images/topup.png';
const String transfer = 'assets/images/transfer.png';
const String bank = 'assets/images/icon_bank.png';
const String CurrencyExchange = 'assets/images/money-exchange.png';
const String helpDesk = 'assets/images/icon_contact.png';
const String promotion = 'assets/images/icon_promotion.png';
const String vip = 'assets/images/icon_vip.png';
const String setting = 'assets/images/setting.png';

List<SelectCountryModel> select_country = [
  SelectCountryModel(text: "Malaysia", image: malaysia),
  SelectCountryModel(text: "Singapore", image: singapore),
  SelectCountryModel(text: "Thailand", image: thailand),
  SelectCountryModel(text: "Vietnam", image: vietnam),
];

List phoneCodes = ["+60", "+92", "+65", "+66", "+855"];
