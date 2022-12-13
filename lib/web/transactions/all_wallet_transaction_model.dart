///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class AllWalletTransactionModelResponseTransactionsJsonClickDetailsJsonText {
/*
{
  "Currency": "THB",
  "Rate": null,
  "Type": "Conversion",
  "Desc": "Exchange currency from MYR to THB",
  "Date/Time": "2022-06-08 02:21:43"
} 
*/

  String? Currency;
  String? Rate;
  String? Type;
  String? Desc;
  String? DateTime;

  AllWalletTransactionModelResponseTransactionsJsonClickDetailsJsonText({
    this.Currency,
    this.Rate,
    this.Type,
    this.Desc,
    this.DateTime,
  });
  AllWalletTransactionModelResponseTransactionsJsonClickDetailsJsonText.fromJson(
      Map<String, dynamic> json) {
    Currency = json['Currency']?.toString();
    Rate = json['Rate']?.toString();
    Type = json['Type']?.toString();
    Desc = json['Desc']?.toString();
    DateTime = json['Date/Time']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Currency'] = Currency;
    data['Rate'] = Rate;
    data['Type'] = Type;
    data['Desc'] = Desc;
    data['Date/Time'] = DateTime;
    return data;
  }
}

class AllWalletTransactionModelResponseTransactionsJsonClickDetails {
/*
{
  "transactionNumber": "FXI220608022143354706",
  "transactionAmount": "2680.39",
  "transactionTitle": "LuckyTown",
  "transactionImage": "https://xxyyzz112233.s3-ap-southeast-1.amazonaws.com/product/luckytown_logo.png",
  "jsonText": {
    "Currency": "THB",
    "Rate": null,
    "Type": "Conversion",
    "Desc": "Exchange currency from MYR to THB",
    "Date/Time": "2022-06-08 02:21:43"
  },
  "detailClick": "false",
  "detailJson": null
} 
*/

  String? transactionNumber;
  String? transactionAmount;
  String? transactionTitle;
  String? transactionImage;
  AllWalletTransactionModelResponseTransactionsJsonClickDetailsJsonText?
      jsonText;
  String? detailClick;
  String? detailJson;

  AllWalletTransactionModelResponseTransactionsJsonClickDetails({
    this.transactionNumber,
    this.transactionAmount,
    this.transactionTitle,
    this.transactionImage,
    this.jsonText,
    this.detailClick,
    this.detailJson,
  });
  AllWalletTransactionModelResponseTransactionsJsonClickDetails.fromJson(
      Map<String, dynamic> json) {
    transactionNumber = json['transactionNumber']?.toString();
    transactionAmount = json['transactionAmount']?.toString();
    transactionTitle = json['transactionTitle']?.toString();
    transactionImage = json['transactionImage']?.toString();
    jsonText = (json['jsonText'] != null)
        ? AllWalletTransactionModelResponseTransactionsJsonClickDetailsJsonText
            .fromJson(json['jsonText'])
        : null;
    detailClick = json['detailClick']?.toString();
    detailJson = json['detailJson']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transactionNumber'] = transactionNumber;
    data['transactionAmount'] = transactionAmount;
    data['transactionTitle'] = transactionTitle;
    data['transactionImage'] = transactionImage;
    if (jsonText != null) {
      data['jsonText'] = jsonText!.toJson();
    }
    data['detailClick'] = detailClick;
    data['detailJson'] = detailJson;
    return data;
  }
}

class AllWalletTransactionModelResponseTransactions {
/*
{
  "transaction_id": "1093549",
  "transaction_amount": "2680.39",
  "transaction_amount_previous": "0.00",
  "transaction_amount_balance": "2680.39",
  "transaction_type": "conversion",
  "wallet_id": "25663",
  "transaction_status": "active",
  "transaction_created_datetime": "2022-06-08 02:21:43",
  "transaction_remark": "Exchange currency from MYR to THB",
  "transaction_method": "Manual",
  "withdraw_status": null,
  "withdraw_update_datetime": null,
  "transaction_number": "FXI220608022143354706",
  "transaction_unique_key": "vCt4Dz358OTkyQel9HW39IsmYRWnWssDZUNCKj9HIREEZtPlyoMVVLMaUfUVEMWmZQFuL1zOzlnhUNT4sTgx2Ap3MMJoac5lOMUBPhuyp4NVh1PduenaUDE7GggMXTQN8XgKcad17k5jbPFSJgFkWsJplY6wmlWCl9bRVEsrzjdhFOOfSHHz1vs30hTuO1EKYs6gOyhx",
  "member_product_id": null,
  "transaction_money_type": "money",
  "transfer_fromto_member_id": null,
  "transfer_fromto_member_name": null,
  "transfer_fromto_shareholder_id": null,
  "transfer_fromto_shareholder_name": null,
  "done_by_admin_name": null,
  "done_by_admin_id": null,
  "done_by_shareholder_id": null,
  "done_by_shareholder_name": null,
  "done_by_member_id": null,
  "done_by_member_name": null,
  "transaction_account_date": null,
  "transaction_flow_type": "in",
  "withdraw_bank_id": null,
  "coin_transaction_id": null,
  "transaction_currency": "THB",
  "topup_bank_name": null,
  "topup_bank_account_number": null,
  "topup_bank_remarks": null,
  "topup_bank_holder": null,
  "withdraw_bank_account_id": null,
  "transaction_product_id": null,
  "withdraw_usdt_rate": null,
  "withdraw_usdt_amount": null,
  "product_id": null,
  "transaction_exchange_rate": null,
  "transaction_exchange_from": null,
  "transaction_exchange_to": null,
  "transaction_amount_base": null,
  "product_image_url": "https://xxyyzz112233.s3-ap-southeast-1.amazonaws.com/product/luckytown_logo.png",
  "transfer_fromto_member_avatar_url": null,
  "product_name": "LuckyTown",
  "transaction_owner": "Techtest",
  "jsonClickDetails": {
    "transactionNumber": "FXI220608022143354706",
    "transactionAmount": "2680.39",
    "transactionTitle": "LuckyTown",
    "transactionImage": "https://xxyyzz112233.s3-ap-southeast-1.amazonaws.com/product/luckytown_logo.png",
    "jsonText": {
      "Currency": "THB",
      "Rate": null,
      "Type": "Conversion",
      "Desc": "Exchange currency from MYR to THB",
      "Date/Time": "2022-06-08 02:21:43"
    },
    "detailClick": "false",
    "detailJson": null
  }
} 
*/

  String? transaction_id;
  String? transaction_amount;
  String? transaction_amount_previous;
  String? transaction_amount_balance;
  String? transaction_type;
  String? wallet_id;
  String? transaction_status;
  String? transaction_created_datetime;
  String? transaction_remark;
  String? transaction_method;
  String? withdraw_status;
  String? withdraw_update_datetime;
  String? transaction_number;
  String? transaction_unique_key;
  String? member_product_id;
  String? transaction_money_type;
  String? transfer_fromto_member_id;
  String? transfer_fromto_member_name;
  String? transfer_fromto_shareholder_id;
  String? transfer_fromto_shareholder_name;
  String? done_by_admin_name;
  String? done_by_admin_id;
  String? done_by_shareholder_id;
  String? done_by_shareholder_name;
  String? done_by_member_id;
  String? done_by_member_name;
  String? transaction_account_date;
  String? transaction_flow_type;
  String? withdraw_bank_id;
  String? coin_transaction_id;
  String? transaction_currency;
  String? topup_bank_name;
  String? topup_bank_account_number;
  String? topup_bank_remarks;
  String? topup_bank_holder;
  String? withdraw_bank_account_id;
  String? transaction_product_id;
  String? withdraw_usdt_rate;
  String? withdraw_usdt_amount;
  String? product_id;
  String? transaction_exchange_rate;
  String? transaction_exchange_from;
  String? transaction_exchange_to;
  String? transaction_amount_base;
  String? product_image_url;
  String? transfer_fromto_member_avatar_url;
  String? product_name;
  String? transaction_owner;
  AllWalletTransactionModelResponseTransactionsJsonClickDetails?
      jsonClickDetails;

  AllWalletTransactionModelResponseTransactions({
    this.transaction_id,
    this.transaction_amount,
    this.transaction_amount_previous,
    this.transaction_amount_balance,
    this.transaction_type,
    this.wallet_id,
    this.transaction_status,
    this.transaction_created_datetime,
    this.transaction_remark,
    this.transaction_method,
    this.withdraw_status,
    this.withdraw_update_datetime,
    this.transaction_number,
    this.transaction_unique_key,
    this.member_product_id,
    this.transaction_money_type,
    this.transfer_fromto_member_id,
    this.transfer_fromto_member_name,
    this.transfer_fromto_shareholder_id,
    this.transfer_fromto_shareholder_name,
    this.done_by_admin_name,
    this.done_by_admin_id,
    this.done_by_shareholder_id,
    this.done_by_shareholder_name,
    this.done_by_member_id,
    this.done_by_member_name,
    this.transaction_account_date,
    this.transaction_flow_type,
    this.withdraw_bank_id,
    this.coin_transaction_id,
    this.transaction_currency,
    this.topup_bank_name,
    this.topup_bank_account_number,
    this.topup_bank_remarks,
    this.topup_bank_holder,
    this.withdraw_bank_account_id,
    this.transaction_product_id,
    this.withdraw_usdt_rate,
    this.withdraw_usdt_amount,
    this.product_id,
    this.transaction_exchange_rate,
    this.transaction_exchange_from,
    this.transaction_exchange_to,
    this.transaction_amount_base,
    this.product_image_url,
    this.transfer_fromto_member_avatar_url,
    this.product_name,
    this.transaction_owner,
    this.jsonClickDetails,
  });
  AllWalletTransactionModelResponseTransactions.fromJson(
      Map<String, dynamic> json) {
    transaction_id = json['transaction_id']?.toString();
    transaction_amount = json['transaction_amount']?.toString();
    transaction_amount_previous =
        json['transaction_amount_previous']?.toString();
    transaction_amount_balance = json['transaction_amount_balance']?.toString();
    transaction_type = json['transaction_type']?.toString();
    wallet_id = json['wallet_id']?.toString();
    transaction_status = json['transaction_status']?.toString();
    transaction_created_datetime =
        json['transaction_created_datetime']?.toString();
    transaction_remark = json['transaction_remark']?.toString();
    transaction_method = json['transaction_method']?.toString();
    withdraw_status = json['withdraw_status']?.toString();
    withdraw_update_datetime = json['withdraw_update_datetime']?.toString();
    transaction_number = json['transaction_number']?.toString();
    transaction_unique_key = json['transaction_unique_key']?.toString();
    member_product_id = json['member_product_id']?.toString();
    transaction_money_type = json['transaction_money_type']?.toString();
    transfer_fromto_member_id = json['transfer_fromto_member_id']?.toString();
    transfer_fromto_member_name =
        json['transfer_fromto_member_name']?.toString();
    transfer_fromto_shareholder_id =
        json['transfer_fromto_shareholder_id']?.toString();
    transfer_fromto_shareholder_name =
        json['transfer_fromto_shareholder_name']?.toString();
    done_by_admin_name = json['done_by_admin_name']?.toString();
    done_by_admin_id = json['done_by_admin_id']?.toString();
    done_by_shareholder_id = json['done_by_shareholder_id']?.toString();
    done_by_shareholder_name = json['done_by_shareholder_name']?.toString();
    done_by_member_id = json['done_by_member_id']?.toString();
    done_by_member_name = json['done_by_member_name']?.toString();
    transaction_account_date = json['transaction_account_date']?.toString();
    transaction_flow_type = json['transaction_flow_type']?.toString();
    withdraw_bank_id = json['withdraw_bank_id']?.toString();
    coin_transaction_id = json['coin_transaction_id']?.toString();
    transaction_currency = json['transaction_currency']?.toString();
    topup_bank_name = json['topup_bank_name']?.toString();
    topup_bank_account_number = json['topup_bank_account_number']?.toString();
    topup_bank_remarks = json['topup_bank_remarks']?.toString();
    topup_bank_holder = json['topup_bank_holder']?.toString();
    withdraw_bank_account_id = json['withdraw_bank_account_id']?.toString();
    transaction_product_id = json['transaction_product_id']?.toString();
    withdraw_usdt_rate = json['withdraw_usdt_rate']?.toString();
    withdraw_usdt_amount = json['withdraw_usdt_amount']?.toString();
    product_id = json['product_id']?.toString();
    transaction_exchange_rate = json['transaction_exchange_rate']?.toString();
    transaction_exchange_from = json['transaction_exchange_from']?.toString();
    transaction_exchange_to = json['transaction_exchange_to']?.toString();
    transaction_amount_base = json['transaction_amount_base']?.toString();
    product_image_url = json['product_image_url']?.toString();
    transfer_fromto_member_avatar_url =
        json['transfer_fromto_member_avatar_url']?.toString();
    product_name = json['product_name']?.toString();
    transaction_owner = json['transaction_owner']?.toString();
    jsonClickDetails = (json['jsonClickDetails'] != null)
        ? AllWalletTransactionModelResponseTransactionsJsonClickDetails
            .fromJson(json['jsonClickDetails'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transaction_id'] = transaction_id;
    data['transaction_amount'] = transaction_amount;
    data['transaction_amount_previous'] = transaction_amount_previous;
    data['transaction_amount_balance'] = transaction_amount_balance;
    data['transaction_type'] = transaction_type;
    data['wallet_id'] = wallet_id;
    data['transaction_status'] = transaction_status;
    data['transaction_created_datetime'] = transaction_created_datetime;
    data['transaction_remark'] = transaction_remark;
    data['transaction_method'] = transaction_method;
    data['withdraw_status'] = withdraw_status;
    data['withdraw_update_datetime'] = withdraw_update_datetime;
    data['transaction_number'] = transaction_number;
    data['transaction_unique_key'] = transaction_unique_key;
    data['member_product_id'] = member_product_id;
    data['transaction_money_type'] = transaction_money_type;
    data['transfer_fromto_member_id'] = transfer_fromto_member_id;
    data['transfer_fromto_member_name'] = transfer_fromto_member_name;
    data['transfer_fromto_shareholder_id'] = transfer_fromto_shareholder_id;
    data['transfer_fromto_shareholder_name'] = transfer_fromto_shareholder_name;
    data['done_by_admin_name'] = done_by_admin_name;
    data['done_by_admin_id'] = done_by_admin_id;
    data['done_by_shareholder_id'] = done_by_shareholder_id;
    data['done_by_shareholder_name'] = done_by_shareholder_name;
    data['done_by_member_id'] = done_by_member_id;
    data['done_by_member_name'] = done_by_member_name;
    data['transaction_account_date'] = transaction_account_date;
    data['transaction_flow_type'] = transaction_flow_type;
    data['withdraw_bank_id'] = withdraw_bank_id;
    data['coin_transaction_id'] = coin_transaction_id;
    data['transaction_currency'] = transaction_currency;
    data['topup_bank_name'] = topup_bank_name;
    data['topup_bank_account_number'] = topup_bank_account_number;
    data['topup_bank_remarks'] = topup_bank_remarks;
    data['topup_bank_holder'] = topup_bank_holder;
    data['withdraw_bank_account_id'] = withdraw_bank_account_id;
    data['transaction_product_id'] = transaction_product_id;
    data['withdraw_usdt_rate'] = withdraw_usdt_rate;
    data['withdraw_usdt_amount'] = withdraw_usdt_amount;
    data['product_id'] = product_id;
    data['transaction_exchange_rate'] = transaction_exchange_rate;
    data['transaction_exchange_from'] = transaction_exchange_from;
    data['transaction_exchange_to'] = transaction_exchange_to;
    data['transaction_amount_base'] = transaction_amount_base;
    data['product_image_url'] = product_image_url;
    data['transfer_fromto_member_avatar_url'] =
        transfer_fromto_member_avatar_url;
    data['product_name'] = product_name;
    data['transaction_owner'] = transaction_owner;
    if (jsonClickDetails != null) {
      data['jsonClickDetails'] = jsonClickDetails!.toJson();
    }
    return data;
  }
}

class AllWalletTransactionModelResponse {
/*
{
  "transactions": [
    {
      "transaction_id": "1093549",
      "transaction_amount": "2680.39",
      "transaction_amount_previous": "0.00",
      "transaction_amount_balance": "2680.39",
      "transaction_type": "conversion",
      "wallet_id": "25663",
      "transaction_status": "active",
      "transaction_created_datetime": "2022-06-08 02:21:43",
      "transaction_remark": "Exchange currency from MYR to THB",
      "transaction_method": "Manual",
      "withdraw_status": null,
      "withdraw_update_datetime": null,
      "transaction_number": "FXI220608022143354706",
      "transaction_unique_key": "vCt4Dz358OTkyQel9HW39IsmYRWnWssDZUNCKj9HIREEZtPlyoMVVLMaUfUVEMWmZQFuL1zOzlnhUNT4sTgx2Ap3MMJoac5lOMUBPhuyp4NVh1PduenaUDE7GggMXTQN8XgKcad17k5jbPFSJgFkWsJplY6wmlWCl9bRVEsrzjdhFOOfSHHz1vs30hTuO1EKYs6gOyhx",
      "member_product_id": null,
      "transaction_money_type": "money",
      "transfer_fromto_member_id": null,
      "transfer_fromto_member_name": null,
      "transfer_fromto_shareholder_id": null,
      "transfer_fromto_shareholder_name": null,
      "done_by_admin_name": null,
      "done_by_admin_id": null,
      "done_by_shareholder_id": null,
      "done_by_shareholder_name": null,
      "done_by_member_id": null,
      "done_by_member_name": null,
      "transaction_account_date": null,
      "transaction_flow_type": "in",
      "withdraw_bank_id": null,
      "coin_transaction_id": null,
      "transaction_currency": "THB",
      "topup_bank_name": null,
      "topup_bank_account_number": null,
      "topup_bank_remarks": null,
      "topup_bank_holder": null,
      "withdraw_bank_account_id": null,
      "transaction_product_id": null,
      "withdraw_usdt_rate": null,
      "withdraw_usdt_amount": null,
      "product_id": null,
      "transaction_exchange_rate": null,
      "transaction_exchange_from": null,
      "transaction_exchange_to": null,
      "transaction_amount_base": null,
      "product_image_url": "https://xxyyzz112233.s3-ap-southeast-1.amazonaws.com/product/luckytown_logo.png",
      "transfer_fromto_member_avatar_url": null,
      "product_name": "LuckyTown",
      "transaction_owner": "Techtest",
      "jsonClickDetails": {
        "transactionNumber": "FXI220608022143354706",
        "transactionAmount": "2680.39",
        "transactionTitle": "LuckyTown",
        "transactionImage": "https://xxyyzz112233.s3-ap-southeast-1.amazonaws.com/product/luckytown_logo.png",
        "jsonText": {
          "Currency": "THB",
          "Rate": null,
          "Type": "Conversion",
          "Desc": "Exchange currency from MYR to THB",
          "Date/Time": "2022-06-08 02:21:43"
        },
        "detailClick": "false",
        "detailJson": null
      }
    }
  ],
  "fromDate": "2021-07-22",
  "toDate": "2022-07-22"
} 
*/

  List<AllWalletTransactionModelResponseTransactions?>? transactions;
  String? fromDate;
  String? toDate;

  AllWalletTransactionModelResponse({
    this.transactions,
    this.fromDate,
    this.toDate,
  });
  AllWalletTransactionModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      final v = json['transactions'];
      final arr0 = <AllWalletTransactionModelResponseTransactions>[];
      v.forEach((v) {
        arr0.add(AllWalletTransactionModelResponseTransactions.fromJson(v));
      });
      transactions = arr0;
    }
    fromDate = json['fromDate']?.toString();
    toDate = json['toDate']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (transactions != null) {
      final v = transactions;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['transactions'] = arr0;
    }
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    return data;
  }
}

class AllWalletTransactionModel {
/*
{
  "msg": "Get All Wallet Transactions Success.",
  "response": {
    "transactions": [
      {
        "transaction_id": "1093549",
        "transaction_amount": "2680.39",
        "transaction_amount_previous": "0.00",
        "transaction_amount_balance": "2680.39",
        "transaction_type": "conversion",
        "wallet_id": "25663",
        "transaction_status": "active",
        "transaction_created_datetime": "2022-06-08 02:21:43",
        "transaction_remark": "Exchange currency from MYR to THB",
        "transaction_method": "Manual",
        "withdraw_status": null,
        "withdraw_update_datetime": null,
        "transaction_number": "FXI220608022143354706",
        "transaction_unique_key": "vCt4Dz358OTkyQel9HW39IsmYRWnWssDZUNCKj9HIREEZtPlyoMVVLMaUfUVEMWmZQFuL1zOzlnhUNT4sTgx2Ap3MMJoac5lOMUBPhuyp4NVh1PduenaUDE7GggMXTQN8XgKcad17k5jbPFSJgFkWsJplY6wmlWCl9bRVEsrzjdhFOOfSHHz1vs30hTuO1EKYs6gOyhx",
        "member_product_id": null,
        "transaction_money_type": "money",
        "transfer_fromto_member_id": null,
        "transfer_fromto_member_name": null,
        "transfer_fromto_shareholder_id": null,
        "transfer_fromto_shareholder_name": null,
        "done_by_admin_name": null,
        "done_by_admin_id": null,
        "done_by_shareholder_id": null,
        "done_by_shareholder_name": null,
        "done_by_member_id": null,
        "done_by_member_name": null,
        "transaction_account_date": null,
        "transaction_flow_type": "in",
        "withdraw_bank_id": null,
        "coin_transaction_id": null,
        "transaction_currency": "THB",
        "topup_bank_name": null,
        "topup_bank_account_number": null,
        "topup_bank_remarks": null,
        "topup_bank_holder": null,
        "withdraw_bank_account_id": null,
        "transaction_product_id": null,
        "withdraw_usdt_rate": null,
        "withdraw_usdt_amount": null,
        "product_id": null,
        "transaction_exchange_rate": null,
        "transaction_exchange_from": null,
        "transaction_exchange_to": null,
        "transaction_amount_base": null,
        "product_image_url": "https://xxyyzz112233.s3-ap-southeast-1.amazonaws.com/product/luckytown_logo.png",
        "transfer_fromto_member_avatar_url": null,
        "product_name": "LuckyTown",
        "transaction_owner": "Techtest",
        "jsonClickDetails": {
          "transactionNumber": "FXI220608022143354706",
          "transactionAmount": "2680.39",
          "transactionTitle": "LuckyTown",
          "transactionImage": "https://xxyyzz112233.s3-ap-southeast-1.amazonaws.com/product/luckytown_logo.png",
          "jsonText": {
            "Currency": "THB",
            "Rate": null,
            "Type": "Conversion",
            "Desc": "Exchange currency from MYR to THB",
            "Date/Time": "2022-06-08 02:21:43"
          },
          "detailClick": "false",
          "detailJson": null
        }
      }
    ],
    "fromDate": "2021-07-22",
    "toDate": "2022-07-22"
  }
} 
*/

  String? msg;
  AllWalletTransactionModelResponse? response;

  AllWalletTransactionModel({
    this.msg,
    this.response,
  });
  AllWalletTransactionModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg']?.toString();
    response = (json['response'] != null)
        ? AllWalletTransactionModelResponse.fromJson(json['response'])
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