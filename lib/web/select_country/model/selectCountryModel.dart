///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class SelectCountryModelResponseList {
/*
{
  "country_id": "1",
  "name": "Malaysia",
  "code": "MYR",
  "icon_url": "https://suncity.s3.ap-southeast-1.amazonaws.com/country/MYR-flag.png",
  "status": "active",
  "is_playable": "1",
  "created_at": "2021-12-23 16:54:00",
  "updated_at": null
} 
*/

  String? countryId;
  String? name;
  String? code;
  String? iconUrl;
  String? status;
  String? isPlayable;
  String? createdAt;
  String? updatedAt;

  SelectCountryModelResponseList({
    this.countryId,
    this.name,
    this.code,
    this.iconUrl,
    this.status,
    this.isPlayable,
    this.createdAt,
    this.updatedAt,
  });
  SelectCountryModelResponseList.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id']?.toString();
    name = json['name']?.toString();
    code = json['code']?.toString();
    iconUrl = json['icon_url']?.toString();
    status = json['status']?.toString();
    isPlayable = json['is_playable']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['name'] = name;
    data['code'] = code;
    data['icon_url'] = iconUrl;
    data['status'] = status;
    data['is_playable'] = isPlayable;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SelectCountryModelResponse {
/*
{
  "list": [
    {
      "country_id": "1",
      "name": "Malaysia",
      "code": "MYR",
      "icon_url": "https://suncity.s3.ap-southeast-1.amazonaws.com/country/MYR-flag.png",
      "status": "active",
      "is_playable": "1",
      "created_at": "2021-12-23 16:54:00",
      "updated_at": null
    }
  ]
} 
*/

  List<SelectCountryModelResponseList?>? list;

  SelectCountryModelResponse({
    this.list,
  });
  SelectCountryModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      final v = json['list'];
      final arr0 = <SelectCountryModelResponseList>[];
      v.forEach((v) {
        arr0.add(SelectCountryModelResponseList.fromJson(v));
      });
      list = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (list != null) {
      final v = list;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['list'] = arr0;
    }
    return data;
  }
}

class SelectCountryModel {
  String? msg;
  SelectCountryModelResponse? response;

  SelectCountryModel({
    this.msg,
    this.response,
  });
  SelectCountryModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg']?.toString();
    response = (json['response'] != null)
        ? SelectCountryModelResponse.fromJson(json['response'])
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