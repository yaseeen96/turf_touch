class HomeScreenDataModel {
  int? id;
  List<String>? sliderImages;
  String? description;
  List<String>? amenities;
  String? phoneNo;
  String? location;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  HomeScreenDataModel(
      {this.id,
      this.sliderImages,
      this.description,
      this.amenities,
      this.phoneNo,
      this.location,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  HomeScreenDataModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["slider_images"] is List) {
      sliderImages = json["slider_images"] == null
          ? null
          : List<String>.from(json["slider_images"]);
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["amenities"] is List) {
      amenities = json["amenities"] == null
          ? null
          : List<String>.from(json["amenities"]);
    }
    if (json["phone_no"] is String) {
      phoneNo = json["phone_no"];
    }
    if (json["location"] is String) {
      location = json["location"];
    }
    if (json["latitude"] is String) {
      latitude = json["latitude"];
    }
    if (json["longitude"] is String) {
      longitude = json["longitude"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if (sliderImages != null) {
      _data["slider_images"] = sliderImages;
    }
    _data["description"] = description;
    if (amenities != null) {
      _data["amenities"] = amenities;
    }
    _data["phone_no"] = phoneNo;
    _data["location"] = location;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
