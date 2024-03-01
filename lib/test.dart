
class Test {
  int? id;
  String? date;
  List<String>? slots;
  String? createdAt;
  String? updatedAt;

  Test({this.id, this.date, this.slots, this.createdAt, this.updatedAt});

  Test.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["date"] is String) {
      date = json["date"];
    }
    if(json["slots"] is List) {
      slots = json["slots"] == null ? null : List<String>.from(json["slots"]);
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["date"] = date;
    if(slots != null) {
      _data["slots"] = slots;
    }
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}