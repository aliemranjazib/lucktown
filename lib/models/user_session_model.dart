class UserSessionModel {
  String? msg;
  Response? response;

  UserSessionModel({this.msg, this.response});

  UserSessionModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? authToken;

  Response({this.user, this.authToken});

  Response.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    authToken = json['authToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['authToken'] = this.authToken;
    return data;
  }
}

class User {
  String? id;
  String? memberUniqueKey;
  String? password;
  String? salt;
  String? memberUsername;
  String? memberLevel;
  String? refUpline;
  String? memberMainId;
  String? memberPhoneCountry;
  String? memberPhone;
  Null? memberPhoneOtp;
  Null? memberPhoneOtpSalt;
  String? memberPhoneOtpStatus;
  Null? lastLogin;
  Null? userEmail;
  Null? registrationToken;
  String? accountStatus;
  String? createdDatetime;
  Null? passwordOtp;
  Null? passwordOtpSalt;
  Null? passwordExpiry;
  Null? bankAccountNumber;
  Null? bankId;
  String? shareholderUniqueKey;
  Null? bankAccountName;
  String? pinStatus;
  Null? memberNickname;
  Null? lastLoginIp;
  String? memberAvatarUrl;
  String? memberQrcodeUrl;
  String? authSession;
  String? authExpiry;
  String? memberType;
  String? adminOverride;
  Null? adminOverrideExpiryDatetime;
  String? memberDeviceId;
  Null? memberDevice;
  String? traceHistory;
  Null? shareholderTraceHistory;
  Null? jsonTraceHistory;
  Null? memberQrcodeUrlNew;
  Null? avatarLastUpdate;
  Null? jsonShareholderTraceHistory;
  Null? fcmToken;
  String? memberLanguage;
  Null? memberPermission;
  String? memberReferralUrl;
  String? memberDirectline;
  Null? memberLoginToken;
  String? memberCountry;
  Null? vipLevelId;
  String? memberCountryOrigin;
  String? walletPin;
  Null? walletPinResetOtp;
  String? isTransferring;
  Null? memberTopupBankId;
  Null? vipLastUpdate;
  String? walletId;
  String? coinWalletId;
  String? interestWalletId;
  String? walletBalance;
  String? coinBalance;
  String? interestBalance;
  String? countryId;
  String? countryName;
  String? countryCode;

  User(
      {this.id,
      this.memberUniqueKey,
      this.password,
      this.salt,
      this.memberUsername,
      this.memberLevel,
      this.refUpline,
      this.memberMainId,
      this.memberPhoneCountry,
      this.memberPhone,
      this.memberPhoneOtp,
      this.memberPhoneOtpSalt,
      this.memberPhoneOtpStatus,
      this.lastLogin,
      this.userEmail,
      this.registrationToken,
      this.accountStatus,
      this.createdDatetime,
      this.passwordOtp,
      this.passwordOtpSalt,
      this.passwordExpiry,
      this.bankAccountNumber,
      this.bankId,
      this.shareholderUniqueKey,
      this.bankAccountName,
      this.pinStatus,
      this.memberNickname,
      this.lastLoginIp,
      this.memberAvatarUrl,
      this.memberQrcodeUrl,
      this.authSession,
      this.authExpiry,
      this.memberType,
      this.adminOverride,
      this.adminOverrideExpiryDatetime,
      this.memberDeviceId,
      this.memberDevice,
      this.traceHistory,
      this.shareholderTraceHistory,
      this.jsonTraceHistory,
      this.memberQrcodeUrlNew,
      this.avatarLastUpdate,
      this.jsonShareholderTraceHistory,
      this.fcmToken,
      this.memberLanguage,
      this.memberPermission,
      this.memberReferralUrl,
      this.memberDirectline,
      this.memberLoginToken,
      this.memberCountry,
      this.vipLevelId,
      this.memberCountryOrigin,
      this.walletPin,
      this.walletPinResetOtp,
      this.isTransferring,
      this.memberTopupBankId,
      this.vipLastUpdate,
      this.walletId,
      this.coinWalletId,
      this.interestWalletId,
      this.walletBalance,
      this.coinBalance,
      this.interestBalance,
      this.countryId,
      this.countryName,
      this.countryCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberUniqueKey = json['member_unique_key'];
    password = json['password'];
    salt = json['salt'];
    memberUsername = json['member_username'];
    memberLevel = json['member_level'];
    refUpline = json['ref_upline'];
    memberMainId = json['member_main_id'];
    memberPhoneCountry = json['member_phone_country'];
    memberPhone = json['member_phone'];
    memberPhoneOtp = json['member_phone_otp'];
    memberPhoneOtpSalt = json['member_phone_otp_salt'];
    memberPhoneOtpStatus = json['member_phone_otp_status'];
    lastLogin = json['last_login'];
    userEmail = json['user_email'];
    registrationToken = json['registration_token'];
    accountStatus = json['account_status'];
    createdDatetime = json['created_datetime'];
    passwordOtp = json['password_otp'];
    passwordOtpSalt = json['password_otp_salt'];
    passwordExpiry = json['password_expiry'];
    bankAccountNumber = json['bank_account_number'];
    bankId = json['bank_id'];
    shareholderUniqueKey = json['shareholder_unique_key'];
    bankAccountName = json['bank_account_name'];
    pinStatus = json['pin_status'];
    memberNickname = json['member_nickname'];
    lastLoginIp = json['last_login_ip'];
    memberAvatarUrl = json['member_avatar_url'];
    memberQrcodeUrl = json['member_qrcode_url'];
    authSession = json['auth_session'];
    authExpiry = json['auth_expiry'];
    memberType = json['member_type'];
    adminOverride = json['admin_override'];
    adminOverrideExpiryDatetime = json['admin_override_expiry_datetime'];
    memberDeviceId = json['member_device_id'];
    memberDevice = json['member_device'];
    traceHistory = json['trace_history'];
    shareholderTraceHistory = json['shareholder_trace_history'];
    jsonTraceHistory = json['json_trace_history'];
    memberQrcodeUrlNew = json['member_qrcode_url_new'];
    avatarLastUpdate = json['avatar_last_update'];
    jsonShareholderTraceHistory = json['json_shareholder_trace_history'];
    fcmToken = json['fcm_token'];
    memberLanguage = json['member_language'];
    memberPermission = json['member_permission'];
    memberReferralUrl = json['member_referral_url'];
    memberDirectline = json['member_directline'];
    memberLoginToken = json['member_login_token'];
    memberCountry = json['member_country'];
    vipLevelId = json['vip_level_id'];
    memberCountryOrigin = json['member_country_origin'];
    walletPin = json['wallet_pin'];
    walletPinResetOtp = json['wallet_pin_reset_otp'];
    isTransferring = json['is_transferring'];
    memberTopupBankId = json['member_topup_bank_id'];
    vipLastUpdate = json['vip_last_update'];
    walletId = json['wallet_id'];
    coinWalletId = json['coin_wallet_id'];
    interestWalletId = json['interest_wallet_id'];
    walletBalance = json['walletBalance'];
    coinBalance = json['coinBalance'];
    interestBalance = json['interestBalance'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_unique_key'] = this.memberUniqueKey;
    data['password'] = this.password;
    data['salt'] = this.salt;
    data['member_username'] = this.memberUsername;
    data['member_level'] = this.memberLevel;
    data['ref_upline'] = this.refUpline;
    data['member_main_id'] = this.memberMainId;
    data['member_phone_country'] = this.memberPhoneCountry;
    data['member_phone'] = this.memberPhone;
    data['member_phone_otp'] = this.memberPhoneOtp;
    data['member_phone_otp_salt'] = this.memberPhoneOtpSalt;
    data['member_phone_otp_status'] = this.memberPhoneOtpStatus;
    data['last_login'] = this.lastLogin;
    data['user_email'] = this.userEmail;
    data['registration_token'] = this.registrationToken;
    data['account_status'] = this.accountStatus;
    data['created_datetime'] = this.createdDatetime;
    data['password_otp'] = this.passwordOtp;
    data['password_otp_salt'] = this.passwordOtpSalt;
    data['password_expiry'] = this.passwordExpiry;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_id'] = this.bankId;
    data['shareholder_unique_key'] = this.shareholderUniqueKey;
    data['bank_account_name'] = this.bankAccountName;
    data['pin_status'] = this.pinStatus;
    data['member_nickname'] = this.memberNickname;
    data['last_login_ip'] = this.lastLoginIp;
    data['member_avatar_url'] = this.memberAvatarUrl;
    data['member_qrcode_url'] = this.memberQrcodeUrl;
    data['auth_session'] = this.authSession;
    data['auth_expiry'] = this.authExpiry;
    data['member_type'] = this.memberType;
    data['admin_override'] = this.adminOverride;
    data['admin_override_expiry_datetime'] = this.adminOverrideExpiryDatetime;
    data['member_device_id'] = this.memberDeviceId;
    data['member_device'] = this.memberDevice;
    data['trace_history'] = this.traceHistory;
    data['shareholder_trace_history'] = this.shareholderTraceHistory;
    data['json_trace_history'] = this.jsonTraceHistory;
    data['member_qrcode_url_new'] = this.memberQrcodeUrlNew;
    data['avatar_last_update'] = this.avatarLastUpdate;
    data['json_shareholder_trace_history'] = this.jsonShareholderTraceHistory;
    data['fcm_token'] = this.fcmToken;
    data['member_language'] = this.memberLanguage;
    data['member_permission'] = this.memberPermission;
    data['member_referral_url'] = this.memberReferralUrl;
    data['member_directline'] = this.memberDirectline;
    data['member_login_token'] = this.memberLoginToken;
    data['member_country'] = this.memberCountry;
    data['vip_level_id'] = this.vipLevelId;
    data['member_country_origin'] = this.memberCountryOrigin;
    data['wallet_pin'] = this.walletPin;
    data['wallet_pin_reset_otp'] = this.walletPinResetOtp;
    data['is_transferring'] = this.isTransferring;
    data['member_topup_bank_id'] = this.memberTopupBankId;
    data['vip_last_update'] = this.vipLastUpdate;
    data['wallet_id'] = this.walletId;
    data['coin_wallet_id'] = this.coinWalletId;
    data['interest_wallet_id'] = this.interestWalletId;
    data['walletBalance'] = this.walletBalance;
    data['coinBalance'] = this.coinBalance;
    data['interestBalance'] = this.interestBalance;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['country_code'] = this.countryCode;
    return data;
  }
}
