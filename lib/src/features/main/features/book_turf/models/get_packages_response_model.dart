
class GetPackagesResponseModel {
  List<Data>? data;

  GetPackagesResponseModel({this.data});

  GetPackagesResponseModel.fromJson(Map<String, dynamic> json) {
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? id;
  String? type;
  String? amount;

  Data({this.id, this.type, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["amount"] is String) {
      amount = json["amount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["type"] = type;
    _data["amount"] = amount;
    return _data;
  }
}