
class GetBookedSlotsResponse {
  int? id;
  String? date;
  String? slots;
  String? createdAt;
  String? updatedAt;

  GetBookedSlotsResponse({this.id, this.date, this.slots, this.createdAt, this.updatedAt});

  GetBookedSlotsResponse.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["date"] is String) {
      date = json["date"];
    }
    if(json["slots"] is String) {
      slots = json["slots"];
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
    _data["slots"] = slots;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}