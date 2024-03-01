class GetPackagesResponseModel {
  List<Data>? data;

  GetPackagesResponseModel({this.data});

  GetPackagesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }
}

class Data {
  int? id;
  String? type;
  String? amount;

  Data({this.id, this.type, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["type"] = type;
    data["amount"] = amount;
    return data;
  }
}
