// ignore_for_file: no_leading_underscores_for_local_identifiers

class CountryListResponseModel {
  String? status;
  String? response;
  String? message;
  List<CountryListResponseData>? countryListResponseData;

  CountryListResponseModel(
      {this.status, this.response, this.message, this.countryListResponseData});

  CountryListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["response"] is String) {
      response = json["response"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      countryListResponseData = json["data"] == null
          ? null
          : (json["data"] as List)
              .map((e) => CountryListResponseData.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["response"] = response;
    _data["message"] = message;
    if (countryListResponseData != null) {
      _data["data"] = countryListResponseData?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class CountryListResponseData {
  String? id;
  String? name;

  CountryListResponseData({this.id, this.name});

  CountryListResponseData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}
