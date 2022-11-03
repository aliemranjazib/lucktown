class ProductsModel {
  String? msg;
  Response? response;

  ProductsModel({this.msg, this.response});

  ProductsModel.fromJson(Map<String, dynamic> json) {
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
  List<Products>? products;
  String? walletBalance;
  String? coinBalance;
  String? interestBalance;

  Response(
      {this.products,
      this.walletBalance,
      this.coinBalance,
      this.interestBalance});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    walletBalance = json['walletBalance'];
    coinBalance = json['coinBalance'];
    interestBalance = json['interestBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['walletBalance'] = this.walletBalance;
    data['coinBalance'] = this.coinBalance;
    data['interestBalance'] = this.interestBalance;
    return data;
  }
}

class Products {
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
  Null? productCurrency;
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
  String? inGameStatus;
  bool? termStatus;
  String? termText;

  Products(
      {this.productId,
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
      this.inGameStatus,
      this.termStatus,
      this.termText});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productStatus = json['product_status'];
    productCategoryGroup = json['product_category_group'];
    productCategory = json['product_category'];
    productDesc = json['product_desc'];
    productGrouping = json['product_grouping'];
    productImageUrl = json['product_image_url'];
    productCoinEntitled = json['product_coin_entitled'];
    productProvider = json['product_provider'];
    productPercentage = json['product_percentage'];
    productImageUrlGrey = json['product_image_url_grey'];
    productAvengerDirect = json['product_avenger_direct'];
    productMainCommissionPercentage =
        json['product_main_commission_percentage'];
    productUplineCommissionPercentage =
        json['product_upline_commission_percentage'];
    productSelfCommissionPercentage =
        json['product_self_commission_percentage'];
    productTest = json['product_test'];
    productSequence = json['product_sequence'];
    pingWithCron = json['ping_with_cron'];
    productCreatedDatetime = json['product_created_datetime'];
    productCurrency = json['product_currency'];
    productRewardEntitled = json['product_reward_entitled'];
    productCountry = json['product_country'];
    productType = json['product_type'];
    productDownTime = json['product_down_time'];
    productDownTimedAt = json['product_down_timed_at'];
    productUpTime = json['product_up_time'];
    productUpTimedAt = json['product_up_timed_at'];
    productDownBy = json['product_down_by'];
    productUpBy = json['product_up_by'];
    productMaintenanceScheduled = json['product_maintenance_scheduled'];
    productMaintenanceScheduledFrom =
        json['product_maintenance_scheduled_from'];
    productMaintenanceScheduledTo = json['product_maintenance_scheduled_to'];
    inGameStatus = json['inGameStatus'];
    termStatus = json['termStatus'];
    termText = json['termText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_status'] = this.productStatus;
    data['product_category_group'] = this.productCategoryGroup;
    data['product_category'] = this.productCategory;
    data['product_desc'] = this.productDesc;
    data['product_grouping'] = this.productGrouping;
    data['product_image_url'] = this.productImageUrl;
    data['product_coin_entitled'] = this.productCoinEntitled;
    data['product_provider'] = this.productProvider;
    data['product_percentage'] = this.productPercentage;
    data['product_image_url_grey'] = this.productImageUrlGrey;
    data['product_avenger_direct'] = this.productAvengerDirect;
    data['product_main_commission_percentage'] =
        this.productMainCommissionPercentage;
    data['product_upline_commission_percentage'] =
        this.productUplineCommissionPercentage;
    data['product_self_commission_percentage'] =
        this.productSelfCommissionPercentage;
    data['product_test'] = this.productTest;
    data['product_sequence'] = this.productSequence;
    data['ping_with_cron'] = this.pingWithCron;
    data['product_created_datetime'] = this.productCreatedDatetime;
    data['product_currency'] = this.productCurrency;
    data['product_reward_entitled'] = this.productRewardEntitled;
    data['product_country'] = this.productCountry;
    data['product_type'] = this.productType;
    data['product_down_time'] = this.productDownTime;
    data['product_down_timed_at'] = this.productDownTimedAt;
    data['product_up_time'] = this.productUpTime;
    data['product_up_timed_at'] = this.productUpTimedAt;
    data['product_down_by'] = this.productDownBy;
    data['product_up_by'] = this.productUpBy;
    data['product_maintenance_scheduled'] = this.productMaintenanceScheduled;
    data['product_maintenance_scheduled_from'] =
        this.productMaintenanceScheduledFrom;
    data['product_maintenance_scheduled_to'] =
        this.productMaintenanceScheduledTo;
    data['inGameStatus'] = this.inGameStatus;
    data['termStatus'] = this.termStatus;
    data['termText'] = this.termText;
    return data;
  }
}
