class AvailableCreditsResponseProductDetail {
/*
{
  "product_id": "69",
  "product_name": "DG",
  "product_status": "active",
  "product_category_group": "Live",
  "product_category": "LIVECASINO",
  "product_desc": "DG",
  "product_grouping": null,
  "product_image_url": "https://xxyyzz112233.s3.ap-southeast-1.amazonaws.com/product/DreamGaming.png",
  "product_coin_entitled": "false",
  "product_provider": "DG",
  "product_percentage": "10.00",
  "product_image_url_grey": "https://xxyyzz112233.s3.ap-southeast-1.amazonaws.com/product/Bnw/DreamGaming.png",
  "product_avenger_direct": "false",
  "product_main_commission_percentage": "0.20",
  "product_upline_commission_percentage": "0.30",
  "product_self_commission_percentage": "0.50",
  "product_test": "true",
  "product_sequence": null,
  "ping_with_cron": "0",
  "product_created_datetime": "2022-04-05 12:59:02",
  "product_currency": null,
  "product_reward_entitled": "true",
  "product_country": "1",
  "product_type": "seamless",
  "product_down_time": null,
  "product_down_timed_at": null,
  "product_up_time": null,
  "product_up_timed_at": null,
  "product_down_by": null,
  "product_up_by": null,
  "product_maintenance_scheduled": "0",
  "product_maintenance_scheduled_from": null,
  "product_maintenance_scheduled_to": null,
  "member_product_id": "50388",
  "member_id": "25784",
  "member_product_created_datetime": "2022-11-10 22:48:38",
  "member_product_username": "PJGNQBNQAS95TTB",
  "member_product_password": "PJGNQBNQAS95TTB",
  "member_product_lastlogin_datetime": "2022-11-11 00:34:31",
  "member_product_total_balance": "0.00",
  "member_product_wallet": "0.00",
  "member_product_coin": "0.00",
  "member_product_return_username": "PJGNQBNQAS95TTB",
  "member_product_last_check": "2022-11-10 22:48:38",
  "member_product_status": "inactive",
  "member_product_lock": "true",
  "member_product_in": "false",
  "member_product_nickname": null,
  "lastpull_datetime": null,
  "member_product_bonus": "0.00",
  "member_product_check": "0",
  "member_product_credit_gamein_deduct": null,
  "member_product_promo_gamein_deduct": null,
  "member_product_game_start_datetime": null,
  "member_product_game_end_datetime": null,
  "auth_session": null,
  "auth_expiry": null,
  "member_product_bet_limit": null,
  "member_product_block": "false"
} 
*/

  String? productId;
  String? productName;
  String? productStatus;
  String? productCategoryGroup;
  String? productCategory;
  String? productDesc;
  String? productGrouping;
  String? productImageUrl;
  String? productCoinEntitled;
  String? productProvider;
  String? productPercentage;
  String? productImageUrlGrey;
  String? productAvengerDirect;
  String? productMainCommissionPercentage;
  String? productUplineCommissionPercentage;
  String? productSelfCommissionPercentage;
  String? productTest;
  String? productSequence;
  String? pingWithCron;
  String? productCreatedDatetime;
  String? productCurrency;
  String? productRewardEntitled;
  String? productCountry;
  String? productType;
  String? productDownTime;
  String? productDownTimedAt;
  String? productUpTime;
  String? productUpTimedAt;
  String? productDownBy;
  String? productUpBy;
  String? productMaintenanceScheduled;
  String? productMaintenanceScheduledFrom;
  String? productMaintenanceScheduledTo;
  String? memberProductId;
  String? memberId;
  String? memberProductCreatedDatetime;
  String? memberProductUsername;
  String? memberProductPassword;
  String? memberProductLastloginDatetime;
  String? memberProductTotalBalance;
  String? memberProductWallet;
  String? memberProductCoin;
  String? memberProductReturnUsername;
  String? memberProductLastCheck;
  String? memberProductStatus;
  String? memberProductLock;
  String? memberProductIn;
  String? memberProductNickname;
  String? lastpullDatetime;
  String? memberProductBonus;
  String? memberProductCheck;
  String? memberProductCreditGameinDeduct;
  String? memberProductPromoGameinDeduct;
  String? memberProductGameStartDatetime;
  String? memberProductGameEndDatetime;
  String? authSession;
  String? authExpiry;
  String? memberProductBetLimit;
  String? memberProductBlock;

  AvailableCreditsResponseProductDetail({
    this.productId,
    this.productName,
    this.productStatus,
    this.productCategoryGroup,
    this.productCategory,
    this.productDesc,
    this.productGrouping,
    this.productImageUrl,
    this.productCoinEntitled,
    this.productProvider,
    this.productPercentage,
    this.productImageUrlGrey,
    this.productAvengerDirect,
    this.productMainCommissionPercentage,
    this.productUplineCommissionPercentage,
    this.productSelfCommissionPercentage,
    this.productTest,
    this.productSequence,
    this.pingWithCron,
    this.productCreatedDatetime,
    this.productCurrency,
    this.productRewardEntitled,
    this.productCountry,
    this.productType,
    this.productDownTime,
    this.productDownTimedAt,
    this.productUpTime,
    this.productUpTimedAt,
    this.productDownBy,
    this.productUpBy,
    this.productMaintenanceScheduled,
    this.productMaintenanceScheduledFrom,
    this.productMaintenanceScheduledTo,
    this.memberProductId,
    this.memberId,
    this.memberProductCreatedDatetime,
    this.memberProductUsername,
    this.memberProductPassword,
    this.memberProductLastloginDatetime,
    this.memberProductTotalBalance,
    this.memberProductWallet,
    this.memberProductCoin,
    this.memberProductReturnUsername,
    this.memberProductLastCheck,
    this.memberProductStatus,
    this.memberProductLock,
    this.memberProductIn,
    this.memberProductNickname,
    this.lastpullDatetime,
    this.memberProductBonus,
    this.memberProductCheck,
    this.memberProductCreditGameinDeduct,
    this.memberProductPromoGameinDeduct,
    this.memberProductGameStartDatetime,
    this.memberProductGameEndDatetime,
    this.authSession,
    this.authExpiry,
    this.memberProductBetLimit,
    this.memberProductBlock,
  });
  AvailableCreditsResponseProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['product_id']?.toString();
    productName = json['product_name']?.toString();
    productStatus = json['product_status']?.toString();
    productCategoryGroup = json['product_category_group']?.toString();
    productCategory = json['product_category']?.toString();
    productDesc = json['product_desc']?.toString();
    productGrouping = json['product_grouping']?.toString();
    productImageUrl = json['product_image_url']?.toString();
    productCoinEntitled = json['product_coin_entitled']?.toString();
    productProvider = json['product_provider']?.toString();
    productPercentage = json['product_percentage']?.toString();
    productImageUrlGrey = json['product_image_url_grey']?.toString();
    productAvengerDirect = json['product_avenger_direct']?.toString();
    productMainCommissionPercentage =
        json['product_main_commission_percentage']?.toString();
    productUplineCommissionPercentage =
        json['product_upline_commission_percentage']?.toString();
    productSelfCommissionPercentage =
        json['product_self_commission_percentage']?.toString();
    productTest = json['product_test']?.toString();
    productSequence = json['product_sequence']?.toString();
    pingWithCron = json['ping_with_cron']?.toString();
    productCreatedDatetime = json['product_created_datetime']?.toString();
    productCurrency = json['product_currency']?.toString();
    productRewardEntitled = json['product_reward_entitled']?.toString();
    productCountry = json['product_country']?.toString();
    productType = json['product_type']?.toString();
    productDownTime = json['product_down_time']?.toString();
    productDownTimedAt = json['product_down_timed_at']?.toString();
    productUpTime = json['product_up_time']?.toString();
    productUpTimedAt = json['product_up_timed_at']?.toString();
    productDownBy = json['product_down_by']?.toString();
    productUpBy = json['product_up_by']?.toString();
    productMaintenanceScheduled =
        json['product_maintenance_scheduled']?.toString();
    productMaintenanceScheduledFrom =
        json['product_maintenance_scheduled_from']?.toString();
    productMaintenanceScheduledTo =
        json['product_maintenance_scheduled_to']?.toString();
    memberProductId = json['member_product_id']?.toString();
    memberId = json['member_id']?.toString();
    memberProductCreatedDatetime =
        json['member_product_created_datetime']?.toString();
    memberProductUsername = json['member_product_username']?.toString();
    memberProductPassword = json['member_product_password']?.toString();
    memberProductLastloginDatetime =
        json['member_product_lastlogin_datetime']?.toString();
    memberProductTotalBalance =
        json['member_product_total_balance']?.toString();
    memberProductWallet = json['member_product_wallet']?.toString();
    memberProductCoin = json['member_product_coin']?.toString();
    memberProductReturnUsername =
        json['member_product_return_username']?.toString();
    memberProductLastCheck = json['member_product_last_check']?.toString();
    memberProductStatus = json['member_product_status']?.toString();
    memberProductLock = json['member_product_lock']?.toString();
    memberProductIn = json['member_product_in']?.toString();
    memberProductNickname = json['member_product_nickname']?.toString();
    lastpullDatetime = json['lastpull_datetime']?.toString();
    memberProductBonus = json['member_product_bonus']?.toString();
    memberProductCheck = json['member_product_check']?.toString();
    memberProductCreditGameinDeduct =
        json['member_product_credit_gamein_deduct']?.toString();
    memberProductPromoGameinDeduct =
        json['member_product_promo_gamein_deduct']?.toString();
    memberProductGameStartDatetime =
        json['member_product_game_start_datetime']?.toString();
    memberProductGameEndDatetime =
        json['member_product_game_end_datetime']?.toString();
    authSession = json['auth_session']?.toString();
    authExpiry = json['auth_expiry']?.toString();
    memberProductBetLimit = json['member_product_bet_limit']?.toString();
    memberProductBlock = json['member_product_block']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_status'] = productStatus;
    data['product_category_group'] = productCategoryGroup;
    data['product_category'] = productCategory;
    data['product_desc'] = productDesc;
    data['product_grouping'] = productGrouping;
    data['product_image_url'] = productImageUrl;
    data['product_coin_entitled'] = productCoinEntitled;
    data['product_provider'] = productProvider;
    data['product_percentage'] = productPercentage;
    data['product_image_url_grey'] = productImageUrlGrey;
    data['product_avenger_direct'] = productAvengerDirect;
    data['product_main_commission_percentage'] =
        productMainCommissionPercentage;
    data['product_upline_commission_percentage'] =
        productUplineCommissionPercentage;
    data['product_self_commission_percentage'] =
        productSelfCommissionPercentage;
    data['product_test'] = productTest;
    data['product_sequence'] = productSequence;
    data['ping_with_cron'] = pingWithCron;
    data['product_created_datetime'] = productCreatedDatetime;
    data['product_currency'] = productCurrency;
    data['product_reward_entitled'] = productRewardEntitled;
    data['product_country'] = productCountry;
    data['product_type'] = productType;
    data['product_down_time'] = productDownTime;
    data['product_down_timed_at'] = productDownTimedAt;
    data['product_up_time'] = productUpTime;
    data['product_up_timed_at'] = productUpTimedAt;
    data['product_down_by'] = productDownBy;
    data['product_up_by'] = productUpBy;
    data['product_maintenance_scheduled'] = productMaintenanceScheduled;
    data['product_maintenance_scheduled_from'] =
        productMaintenanceScheduledFrom;
    data['product_maintenance_scheduled_to'] = productMaintenanceScheduledTo;
    data['member_product_id'] = memberProductId;
    data['member_id'] = memberId;
    data['member_product_created_datetime'] = memberProductCreatedDatetime;
    data['member_product_username'] = memberProductUsername;
    data['member_product_password'] = memberProductPassword;
    data['member_product_lastlogin_datetime'] = memberProductLastloginDatetime;
    data['member_product_total_balance'] = memberProductTotalBalance;
    data['member_product_wallet'] = memberProductWallet;
    data['member_product_coin'] = memberProductCoin;
    data['member_product_return_username'] = memberProductReturnUsername;
    data['member_product_last_check'] = memberProductLastCheck;
    data['member_product_status'] = memberProductStatus;
    data['member_product_lock'] = memberProductLock;
    data['member_product_in'] = memberProductIn;
    data['member_product_nickname'] = memberProductNickname;
    data['lastpull_datetime'] = lastpullDatetime;
    data['member_product_bonus'] = memberProductBonus;
    data['member_product_check'] = memberProductCheck;
    data['member_product_credit_gamein_deduct'] =
        memberProductCreditGameinDeduct;
    data['member_product_promo_gamein_deduct'] = memberProductPromoGameinDeduct;
    data['member_product_game_start_datetime'] = memberProductGameStartDatetime;
    data['member_product_game_end_datetime'] = memberProductGameEndDatetime;
    data['auth_session'] = authSession;
    data['auth_expiry'] = authExpiry;
    data['member_product_bet_limit'] = memberProductBetLimit;
    data['member_product_block'] = memberProductBlock;
    return data;
  }
}

class AvailableCreditsResponse {
/*
{
  "avaiableTransfer": 0,
  "coinAvailable": "0.00",
  "coinEntitle": "false",
  "ptsCopyWriting": "1.00:1.00 PTS",
  "selfCommission": "0.50%",
  "username": "PJGNQBNQAS95TTB",
  "password": "PJGNQBNQAS95TTB",
  "productDetail": {
    "product_id": "69",
    "product_name": "DG",
    "product_status": "active",
    "product_category_group": "Live",
    "product_category": "LIVECASINO",
    "product_desc": "DG",
    "product_grouping": null,
    "product_image_url": "https://xxyyzz112233.s3.ap-southeast-1.amazonaws.com/product/DreamGaming.png",
    "product_coin_entitled": "false",
    "product_provider": "DG",
    "product_percentage": "10.00",
    "product_image_url_grey": "https://xxyyzz112233.s3.ap-southeast-1.amazonaws.com/product/Bnw/DreamGaming.png",
    "product_avenger_direct": "false",
    "product_main_commission_percentage": "0.20",
    "product_upline_commission_percentage": "0.30",
    "product_self_commission_percentage": "0.50",
    "product_test": "true",
    "product_sequence": null,
    "ping_with_cron": "0",
    "product_created_datetime": "2022-04-05 12:59:02",
    "product_currency": null,
    "product_reward_entitled": "true",
    "product_country": "1",
    "product_type": "seamless",
    "product_down_time": null,
    "product_down_timed_at": null,
    "product_up_time": null,
    "product_up_timed_at": null,
    "product_down_by": null,
    "product_up_by": null,
    "product_maintenance_scheduled": "0",
    "product_maintenance_scheduled_from": null,
    "product_maintenance_scheduled_to": null,
    "member_product_id": "50388",
    "member_id": "25784",
    "member_product_created_datetime": "2022-11-10 22:48:38",
    "member_product_username": "PJGNQBNQAS95TTB",
    "member_product_password": "PJGNQBNQAS95TTB",
    "member_product_lastlogin_datetime": "2022-11-11 00:34:31",
    "member_product_total_balance": "0.00",
    "member_product_wallet": "0.00",
    "member_product_coin": "0.00",
    "member_product_return_username": "PJGNQBNQAS95TTB",
    "member_product_last_check": "2022-11-10 22:48:38",
    "member_product_status": "inactive",
    "member_product_lock": "true",
    "member_product_in": "false",
    "member_product_nickname": null,
    "lastpull_datetime": null,
    "member_product_bonus": "0.00",
    "member_product_check": "0",
    "member_product_credit_gamein_deduct": null,
    "member_product_promo_gamein_deduct": null,
    "member_product_game_start_datetime": null,
    "member_product_game_end_datetime": null,
    "auth_session": null,
    "auth_expiry": null,
    "member_product_bet_limit": null,
    "member_product_block": "false"
  },
  "inGameStatus": "",
  "type": "web",
  "todayStake": 0,
  "yesterdayStake": 0,
  "hasViewOptions": false
} 
*/

  int? avaiableTransfer;
  String? coinAvailable;
  String? coinEntitle;
  String? ptsCopyWriting;
  String? selfCommission;
  String? username;
  String? password;
  AvailableCreditsResponseProductDetail? productDetail;
  String? inGameStatus;
  String? type;
  int? todayStake;
  int? yesterdayStake;
  bool? hasViewOptions;

  AvailableCreditsResponse({
    this.avaiableTransfer,
    this.coinAvailable,
    this.coinEntitle,
    this.ptsCopyWriting,
    this.selfCommission,
    this.username,
    this.password,
    this.productDetail,
    this.inGameStatus,
    this.type,
    this.todayStake,
    this.yesterdayStake,
    this.hasViewOptions,
  });
  AvailableCreditsResponse.fromJson(Map<String, dynamic> json) {
    avaiableTransfer = json['avaiableTransfer']?.toInt();
    coinAvailable = json['coinAvailable']?.toString();
    coinEntitle = json['coinEntitle']?.toString();
    ptsCopyWriting = json['ptsCopyWriting']?.toString();
    selfCommission = json['selfCommission']?.toString();
    username = json['username']?.toString();
    password = json['password']?.toString();
    productDetail = (json['productDetail'] != null)
        ? AvailableCreditsResponseProductDetail.fromJson(json['productDetail'])
        : null;
    inGameStatus = json['inGameStatus']?.toString();
    type = json['type']?.toString();
    todayStake = json['todayStake']?.toInt();
    yesterdayStake = json['yesterdayStake']?.toInt();
    hasViewOptions = json['hasViewOptions'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['avaiableTransfer'] = avaiableTransfer;
    data['coinAvailable'] = coinAvailable;
    data['coinEntitle'] = coinEntitle;
    data['ptsCopyWriting'] = ptsCopyWriting;
    data['selfCommission'] = selfCommission;
    data['username'] = username;
    data['password'] = password;
    if (productDetail != null) {
      data['productDetail'] = productDetail!.toJson();
    }
    data['inGameStatus'] = inGameStatus;
    data['type'] = type;
    data['todayStake'] = todayStake;
    data['yesterdayStake'] = yesterdayStake;
    data['hasViewOptions'] = hasViewOptions;
    return data;
  }
}

class AvailableCredits {
/*
{
  "msg": "Get Available Crrdit Success",
  "response": {
    "avaiableTransfer": 0,
    "coinAvailable": "0.00",
    "coinEntitle": "false",
    "ptsCopyWriting": "1.00:1.00 PTS",
    "selfCommission": "0.50%",
    "username": "PJGNQBNQAS95TTB",
    "password": "PJGNQBNQAS95TTB",
    "productDetail": {
      "product_id": "69",
      "product_name": "DG",
      "product_status": "active",
      "product_category_group": "Live",
      "product_category": "LIVECASINO",
      "product_desc": "DG",
      "product_grouping": null,
      "product_image_url": "https://xxyyzz112233.s3.ap-southeast-1.amazonaws.com/product/DreamGaming.png",
      "product_coin_entitled": "false",
      "product_provider": "DG",
      "product_percentage": "10.00",
      "product_image_url_grey": "https://xxyyzz112233.s3.ap-southeast-1.amazonaws.com/product/Bnw/DreamGaming.png",
      "product_avenger_direct": "false",
      "product_main_commission_percentage": "0.20",
      "product_upline_commission_percentage": "0.30",
      "product_self_commission_percentage": "0.50",
      "product_test": "true",
      "product_sequence": null,
      "ping_with_cron": "0",
      "product_created_datetime": "2022-04-05 12:59:02",
      "product_currency": null,
      "product_reward_entitled": "true",
      "product_country": "1",
      "product_type": "seamless",
      "product_down_time": null,
      "product_down_timed_at": null,
      "product_up_time": null,
      "product_up_timed_at": null,
      "product_down_by": null,
      "product_up_by": null,
      "product_maintenance_scheduled": "0",
      "product_maintenance_scheduled_from": null,
      "product_maintenance_scheduled_to": null,
      "member_product_id": "50388",
      "member_id": "25784",
      "member_product_created_datetime": "2022-11-10 22:48:38",
      "member_product_username": "PJGNQBNQAS95TTB",
      "member_product_password": "PJGNQBNQAS95TTB",
      "member_product_lastlogin_datetime": "2022-11-11 00:34:31",
      "member_product_total_balance": "0.00",
      "member_product_wallet": "0.00",
      "member_product_coin": "0.00",
      "member_product_return_username": "PJGNQBNQAS95TTB",
      "member_product_last_check": "2022-11-10 22:48:38",
      "member_product_status": "inactive",
      "member_product_lock": "true",
      "member_product_in": "false",
      "member_product_nickname": null,
      "lastpull_datetime": null,
      "member_product_bonus": "0.00",
      "member_product_check": "0",
      "member_product_credit_gamein_deduct": null,
      "member_product_promo_gamein_deduct": null,
      "member_product_game_start_datetime": null,
      "member_product_game_end_datetime": null,
      "auth_session": null,
      "auth_expiry": null,
      "member_product_bet_limit": null,
      "member_product_block": "false"
    },
    "inGameStatus": "",
    "type": "web",
    "todayStake": 0,
    "yesterdayStake": 0,
    "hasViewOptions": false
  }
} 
*/

  String? msg;
  AvailableCreditsResponse? response;

  AvailableCredits({
    this.msg,
    this.response,
  });
  AvailableCredits.fromJson(Map<String, dynamic> json) {
    msg = json['msg']?.toString();
    response = (json['response'] != null)
        ? AvailableCreditsResponse.fromJson(json['response'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}
