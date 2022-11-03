class UserModel {
  Data? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? phoneNumber;
  String? countryCode;
  String? password;
  String? confirmPassword;
  String? refUsername;
  int? countryId;

  Data(
      {this.username,
      this.phoneNumber,
      this.countryCode,
      this.password,
      this.confirmPassword,
      this.refUsername,
      this.countryId});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    refUsername = json['refUsername'];
    countryId = json['countryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phoneNumber'] = this.phoneNumber;
    data['countryCode'] = this.countryCode;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['refUsername'] = this.refUsername;
    data['countryId'] = this.countryId;
    return data;
  }
}
