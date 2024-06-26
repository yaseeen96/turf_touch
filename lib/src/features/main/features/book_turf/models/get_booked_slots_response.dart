class GetBookedSlotsResponse {
  int? id;
  String? date;
  List<String>? slots;
  String? createdAt;
  String? updatedAt;

  GetBookedSlotsResponse(
      {this.id, this.date, this.slots, this.createdAt, this.updatedAt});

  GetBookedSlotsResponse.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["slots"] is List) {
      slots = json["slots"] == null ? null : List<String>.from(json["slots"]);
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["date"] = date;
    if (slots != null) {
      data["slots"] = slots;
    }
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
