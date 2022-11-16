class ProfileData {
  String? msg;
  Response? response;

  ProfileData({this.msg, this.response});

  ProfileData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  List<String>? orderTransactions;
  List<WalletTransactions>? walletTransactions;
  List<GameTransactions>? gameTransactions;
  List<TopUpBankList>? topUpBankList;
  String? reference;
  List<Accounts>? accounts;
  String? walletBalance;
  String? coinBalance;
  String? interestBalance;
  List<TopUpMethodList>? topUpMethodList;
  List<CountryList>? countryList;

  Response(
      {this.orderTransactions,
      this.walletTransactions,
      this.gameTransactions,
      this.topUpBankList,
      this.reference,
      this.accounts,
      this.walletBalance,
      this.coinBalance,
      this.interestBalance,
      this.topUpMethodList,
      this.countryList});

  Response.fromJson(Map<String, dynamic> json) {
    orderTransactions = json['orderTransactions'].cast<String>();
    if (json['walletTransactions'] != null) {
      walletTransactions = <WalletTransactions>[];
      json['walletTransactions'].forEach((v) {
        walletTransactions!.add(new WalletTransactions.fromJson(v));
      });
    }
    if (json['gameTransactions'] != null) {
      gameTransactions = <GameTransactions>[];
      json['gameTransactions'].forEach((v) {
        gameTransactions!.add(new GameTransactions.fromJson(v));
      });
    }
    if (json['topUpBankList'] != null) {
      topUpBankList = <TopUpBankList>[];
      json['topUpBankList'].forEach((v) {
        topUpBankList!.add(new TopUpBankList.fromJson(v));
      });
    }
    reference = json['reference'];
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(new Accounts.fromJson(v));
      });
    }
    walletBalance = json['walletBalance'];
    coinBalance = json['coinBalance'];
    interestBalance = json['interestBalance'];
    if (json['topUpMethodList'] != null) {
      topUpMethodList = <TopUpMethodList>[];
      json['topUpMethodList'].forEach((v) {
        topUpMethodList!.add(new TopUpMethodList.fromJson(v));
      });
    }
    if (json['countryList'] != null) {
      countryList = <CountryList>[];
      json['countryList'].forEach((v) {
        countryList!.add(new CountryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderTransactions'] = this.orderTransactions;
    if (this.walletTransactions != null) {
      data['walletTransactions'] =
          this.walletTransactions!.map((v) => v.toJson()).toList();
    }
    if (this.gameTransactions != null) {
      data['gameTransactions'] =
          this.gameTransactions!.map((v) => v.toJson()).toList();
    }
    if (this.topUpBankList != null) {
      data['topUpBankList'] =
          this.topUpBankList!.map((v) => v.toJson()).toList();
    }
    data['reference'] = this.reference;
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    data['walletBalance'] = this.walletBalance;
    data['coinBalance'] = this.coinBalance;
    data['interestBalance'] = this.interestBalance;
    if (this.topUpMethodList != null) {
      data['topUpMethodList'] =
          this.topUpMethodList!.map((v) => v.toJson()).toList();
    }
    if (this.countryList != null) {
      data['countryList'] = this.countryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactions {
  String? transactionId;
  String? transactionAmount;
  String? transactionAmountPrevious;
  String? transactionAmountBalance;
  String? transactionType;
  String? walletId;
  String? transactionStatus;
  String? transactionCreatedDatetime;
  String? transactionRemark;
  String? transactionMethod;
  String? withdrawStatus;
  String? withdrawUpdateDatetime;
  String? transactionNumber;
  String? transactionUniqueKey;
  String? memberProductId;
  String? transactionMoneyType;
  String? transferFromtoMemberId;
  String? transferFromtoMemberName;
  String? transferFromtoShareholderId;
  String? transferFromtoShareholderName;
  String? doneByAdminName;
  String? doneByAdminId;
  String? doneByShareholderId;
  String? doneByShareholderName;
  String? doneByMemberId;
  String? doneByMemberName;
  String? transactionAccountDate;
  String? transactionFlowType;
  String? withdrawBankId;
  String? coinTransactionId;
  String? transactionCurrency;
  String? topupBankName;
  String? topupBankAccountNumber;
  String? topupBankRemarks;
  String? topupBankHolder;
  String? withdrawBankAccountId;
  String? transactionProductId;
  String? withdrawUsdtRate;
  String? withdrawUsdtAmount;
  String? productId;
  String? transactionExchangeRate;
  String? transactionExchangeFrom;
  String? transactionExchangeTo;
  String? productImageUrl;
  String? transferFromtoMemberAvatarUrl;
  String? productName;
  String? transactionOwner;
  JsonClickDetails? jsonClickDetails;

  WalletTransactions(
      {this.transactionId,
      this.transactionAmount,
      this.transactionAmountPrevious,
      this.transactionAmountBalance,
      this.transactionType,
      this.walletId,
      this.transactionStatus,
      this.transactionCreatedDatetime,
      this.transactionRemark,
      this.transactionMethod,
      this.withdrawStatus,
      this.withdrawUpdateDatetime,
      this.transactionNumber,
      this.transactionUniqueKey,
      this.memberProductId,
      this.transactionMoneyType,
      this.transferFromtoMemberId,
      this.transferFromtoMemberName,
      this.transferFromtoShareholderId,
      this.transferFromtoShareholderName,
      this.doneByAdminName,
      this.doneByAdminId,
      this.doneByShareholderId,
      this.doneByShareholderName,
      this.doneByMemberId,
      this.doneByMemberName,
      this.transactionAccountDate,
      this.transactionFlowType,
      this.withdrawBankId,
      this.coinTransactionId,
      this.transactionCurrency,
      this.topupBankName,
      this.topupBankAccountNumber,
      this.topupBankRemarks,
      this.topupBankHolder,
      this.withdrawBankAccountId,
      this.transactionProductId,
      this.withdrawUsdtRate,
      this.withdrawUsdtAmount,
      this.productId,
      this.transactionExchangeRate,
      this.transactionExchangeFrom,
      this.transactionExchangeTo,
      this.productImageUrl,
      this.transferFromtoMemberAvatarUrl,
      this.productName,
      this.transactionOwner,
      this.jsonClickDetails});

  WalletTransactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    transactionAmount = json['transaction_amount'];
    transactionAmountPrevious = json['transaction_amount_previous'];
    transactionAmountBalance = json['transaction_amount_balance'];
    transactionType = json['transaction_type'];
    walletId = json['wallet_id'];
    transactionStatus = json['transaction_status'];
    transactionCreatedDatetime = json['transaction_created_datetime'];
    transactionRemark = json['transaction_remark'];
    transactionMethod = json['transaction_method'];
    withdrawStatus = json['withdraw_status'];
    withdrawUpdateDatetime = json['withdraw_update_datetime'];
    transactionNumber = json['transaction_number'];
    transactionUniqueKey = json['transaction_unique_key'];
    memberProductId = json['member_product_id'];
    transactionMoneyType = json['transaction_money_type'];
    transferFromtoMemberId = json['transfer_fromto_member_id'];
    transferFromtoMemberName = json['transfer_fromto_member_name'];
    transferFromtoShareholderId = json['transfer_fromto_shareholder_id'];
    transferFromtoShareholderName = json['transfer_fromto_shareholder_name'];
    doneByAdminName = json['done_by_admin_name'];
    doneByAdminId = json['done_by_admin_id'];
    doneByShareholderId = json['done_by_shareholder_id'];
    doneByShareholderName = json['done_by_shareholder_name'];
    doneByMemberId = json['done_by_member_id'];
    doneByMemberName = json['done_by_member_name'];
    transactionAccountDate = json['transaction_account_date'];
    transactionFlowType = json['transaction_flow_type'];
    withdrawBankId = json['withdraw_bank_id'];
    coinTransactionId = json['coin_transaction_id'];
    transactionCurrency = json['transaction_currency'];
    topupBankName = json['topup_bank_name'];
    topupBankAccountNumber = json['topup_bank_account_number'];
    topupBankRemarks = json['topup_bank_remarks'];
    topupBankHolder = json['topup_bank_holder'];
    withdrawBankAccountId = json['withdraw_bank_account_id'];
    transactionProductId = json['transaction_product_id'];
    withdrawUsdtRate = json['withdraw_usdt_rate'];
    withdrawUsdtAmount = json['withdraw_usdt_amount'];
    productId = json['product_id'];
    transactionExchangeRate = json['transaction_exchange_rate'];
    transactionExchangeFrom = json['transaction_exchange_from'];
    transactionExchangeTo = json['transaction_exchange_to'];
    productImageUrl = json['product_image_url'];
    transferFromtoMemberAvatarUrl = json['transfer_fromto_member_avatar_url'];
    productName = json['product_name'];
    transactionOwner = json['transaction_owner'];
    jsonClickDetails = json['jsonClickDetails'] != null
        ? new JsonClickDetails.fromJson(json['jsonClickDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_amount_previous'] = this.transactionAmountPrevious;
    data['transaction_amount_balance'] = this.transactionAmountBalance;
    data['transaction_type'] = this.transactionType;
    data['wallet_id'] = this.walletId;
    data['transaction_status'] = this.transactionStatus;
    data['transaction_created_datetime'] = this.transactionCreatedDatetime;
    data['transaction_remark'] = this.transactionRemark;
    data['transaction_method'] = this.transactionMethod;
    data['withdraw_status'] = this.withdrawStatus;
    data['withdraw_update_datetime'] = this.withdrawUpdateDatetime;
    data['transaction_number'] = this.transactionNumber;
    data['transaction_unique_key'] = this.transactionUniqueKey;
    data['member_product_id'] = this.memberProductId;
    data['transaction_money_type'] = this.transactionMoneyType;
    data['transfer_fromto_member_id'] = this.transferFromtoMemberId;
    data['transfer_fromto_member_name'] = this.transferFromtoMemberName;
    data['transfer_fromto_shareholder_id'] = this.transferFromtoShareholderId;
    data['transfer_fromto_shareholder_name'] =
        this.transferFromtoShareholderName;
    data['done_by_admin_name'] = this.doneByAdminName;
    data['done_by_admin_id'] = this.doneByAdminId;
    data['done_by_shareholder_id'] = this.doneByShareholderId;
    data['done_by_shareholder_name'] = this.doneByShareholderName;
    data['done_by_member_id'] = this.doneByMemberId;
    data['done_by_member_name'] = this.doneByMemberName;
    data['transaction_account_date'] = this.transactionAccountDate;
    data['transaction_flow_type'] = this.transactionFlowType;
    data['withdraw_bank_id'] = this.withdrawBankId;
    data['coin_transaction_id'] = this.coinTransactionId;
    data['transaction_currency'] = this.transactionCurrency;
    data['topup_bank_name'] = this.topupBankName;
    data['topup_bank_account_number'] = this.topupBankAccountNumber;
    data['topup_bank_remarks'] = this.topupBankRemarks;
    data['topup_bank_holder'] = this.topupBankHolder;
    data['withdraw_bank_account_id'] = this.withdrawBankAccountId;
    data['transaction_product_id'] = this.transactionProductId;
    data['withdraw_usdt_rate'] = this.withdrawUsdtRate;
    data['withdraw_usdt_amount'] = this.withdrawUsdtAmount;
    data['product_id'] = this.productId;
    data['transaction_exchange_rate'] = this.transactionExchangeRate;
    data['transaction_exchange_from'] = this.transactionExchangeFrom;
    data['transaction_exchange_to'] = this.transactionExchangeTo;
    data['product_image_url'] = this.productImageUrl;
    data['transfer_fromto_member_avatar_url'] =
        this.transferFromtoMemberAvatarUrl;
    data['product_name'] = this.productName;
    data['transaction_owner'] = this.transactionOwner;
    if (this.jsonClickDetails != null) {
      data['jsonClickDetails'] = this.jsonClickDetails!.toJson();
    }
    return data;
  }
}

class JsonClickDetails {
  String? transactionNumber;
  String? transactionAmount;
  String? transactionTitle;
  String? transactionImage;
  JsonText? jsonText;
  String? detailClick;
  String? detailJson;

  JsonClickDetails(
      {this.transactionNumber,
      this.transactionAmount,
      this.transactionTitle,
      this.transactionImage,
      this.jsonText,
      this.detailClick,
      this.detailJson});

  JsonClickDetails.fromJson(Map<String, dynamic> json) {
    transactionNumber = json['transactionNumber'];
    transactionAmount = json['transactionAmount'];
    transactionTitle = json['transactionTitle'];
    transactionImage = json['transactionImage'];
    jsonText = json['jsonText'] != null
        ? new JsonText.fromJson(json['jsonText'])
        : null;
    detailClick = json['detailClick'];
    detailJson = json['detailJson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionNumber'] = this.transactionNumber;
    data['transactionAmount'] = this.transactionAmount;
    data['transactionTitle'] = this.transactionTitle;
    data['transactionImage'] = this.transactionImage;
    if (this.jsonText != null) {
      data['jsonText'] = this.jsonText!.toJson();
    }
    data['detailClick'] = this.detailClick;
    data['detailJson'] = this.detailJson;
    return data;
  }
}

class JsonText {
  String? currency;
  String? type;
  String? desc;
  String? dateTime;

  JsonText({this.currency, this.type, this.desc, this.dateTime});

  JsonText.fromJson(Map<String, dynamic> json) {
    currency = json['Currency'];
    type = json['Type'];
    desc = json['Desc'];
    dateTime = json['Date/Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Currency'] = this.currency;
    data['Type'] = this.type;
    data['Desc'] = this.desc;
    data['Date/Time'] = this.dateTime;
    return data;
  }
}

class GameTransactions {
  String? transactionId;
  String? gameTransactionValidStake;
  String? transactionNumber;
  String? transactionRemarks;
  String? transactionCreatedDatetime;
  String? productImageUrl;
  String? transactionAmount;

  GameTransactions(
      {this.transactionId,
      this.gameTransactionValidStake,
      this.transactionNumber,
      this.transactionRemarks,
      this.transactionCreatedDatetime,
      this.productImageUrl,
      this.transactionAmount});

  GameTransactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    gameTransactionValidStake = json['game_transaction_valid_stake'];
    transactionNumber = json['transaction_number'];
    transactionRemarks = json['transaction_remarks'];
    transactionCreatedDatetime = json['transaction_created_datetime'];
    productImageUrl = json['product_image_url'];
    transactionAmount = json['transaction_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['game_transaction_valid_stake'] = this.gameTransactionValidStake;
    data['transaction_number'] = this.transactionNumber;
    data['transaction_remarks'] = this.transactionRemarks;
    data['transaction_created_datetime'] = this.transactionCreatedDatetime;
    data['product_image_url'] = this.productImageUrl;
    data['transaction_amount'] = this.transactionAmount;
    return data;
  }
}

class TopUpBankList {
  String? topupBankId;
  String? topupBankName;
  String? topupBankAccountNumber;
  String? topupBankCreatedDatetime;
  String? topupBankAccountName;
  String? topupBankStatus;
  String? topupBankIconUrl;
  String? topupBankRemarks;
  String? topupBankCountry;
  String? topupBankQrcodeUrl;
  String? topupBankQrcodeStatus;

  TopUpBankList(
      {this.topupBankId,
      this.topupBankName,
      this.topupBankAccountNumber,
      this.topupBankCreatedDatetime,
      this.topupBankAccountName,
      this.topupBankStatus,
      this.topupBankIconUrl,
      this.topupBankRemarks,
      this.topupBankCountry,
      this.topupBankQrcodeUrl,
      this.topupBankQrcodeStatus});

  TopUpBankList.fromJson(Map<String, dynamic> json) {
    topupBankId = json['topup_bank_id'];
    topupBankName = json['topup_bank_name'];
    topupBankAccountNumber = json['topup_bank_account_number'];
    topupBankCreatedDatetime = json['topup_bank_created_datetime'];
    topupBankAccountName = json['topup_bank_account_name'];
    topupBankStatus = json['topup_bank_status'];
    topupBankIconUrl = json['topup_bank_icon_url'];
    topupBankRemarks = json['topup_bank_remarks'];
    topupBankCountry = json['topup_bank_country'];
    topupBankQrcodeUrl = json['topup_bank_qrcode_url'];
    topupBankQrcodeStatus = json['topup_bank_qrcode_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topup_bank_id'] = this.topupBankId;
    data['topup_bank_name'] = this.topupBankName;
    data['topup_bank_account_number'] = this.topupBankAccountNumber;
    data['topup_bank_created_datetime'] = this.topupBankCreatedDatetime;
    data['topup_bank_account_name'] = this.topupBankAccountName;
    data['topup_bank_status'] = this.topupBankStatus;
    data['topup_bank_icon_url'] = this.topupBankIconUrl;
    data['topup_bank_remarks'] = this.topupBankRemarks;
    data['topup_bank_country'] = this.topupBankCountry;
    data['topup_bank_qrcode_url'] = this.topupBankQrcodeUrl;
    data['topup_bank_qrcode_status'] = this.topupBankQrcodeStatus;
    return data;
  }
}

class Accounts {
  String? id;
  String? memberId;
  String? bankId;
  String? accountNumber;
  String? accountName;
  String? createdAt;
  String? updatedAt;
  String? bankName;
  String? bankCountry;
  String? bankType;
  String? bankIconUrl;

  Accounts(
      {this.id,
      this.memberId,
      this.bankId,
      this.accountNumber,
      this.accountName,
      this.createdAt,
      this.updatedAt,
      this.bankName,
      this.bankCountry,
      this.bankType,
      this.bankIconUrl});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    bankId = json['bank_id'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bankName = json['bank_name'];
    bankCountry = json['bank_country'];
    bankType = json['bank_type'];
    bankIconUrl = json['bank_icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['bank_id'] = this.bankId;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bank_name'] = this.bankName;
    data['bank_country'] = this.bankCountry;
    data['bank_type'] = this.bankType;
    data['bank_icon_url'] = this.bankIconUrl;
    return data;
  }
}

class TopUpMethodList {
  String? settingId;
  String? code;
  String? value;
  String? type;
  String? group;

  TopUpMethodList(
      {this.settingId, this.code, this.value, this.type, this.group});

  TopUpMethodList.fromJson(Map<String, dynamic> json) {
    settingId = json['setting_id'];
    code = json['code'];
    value = json['value'];
    type = json['type'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['setting_id'] = this.settingId;
    data['code'] = this.code;
    data['value'] = this.value;
    data['type'] = this.type;
    data['group'] = this.group;
    return data;
  }
}

class CountryList {
  String? countryId;
  String? name;
  String? code;
  String? iconUrl;
  String? status;
  String? isPlayable;
  String? createdAt;
  String? updatedAt;

  CountryList(
      {this.countryId,
      this.name,
      this.code,
      this.iconUrl,
      this.status,
      this.isPlayable,
      this.createdAt,
      this.updatedAt});

  CountryList.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    name = json['name'];
    code = json['code'];
    iconUrl = json['icon_url'];
    status = json['status'];
    isPlayable = json['is_playable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['icon_url'] = this.iconUrl;
    data['status'] = this.status;
    data['is_playable'] = this.isPlayable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
