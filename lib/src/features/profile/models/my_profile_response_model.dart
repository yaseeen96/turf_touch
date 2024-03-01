
class MyProfileResponseModel {
  int? id;
  String? firstName;
  String? lastName;
  String? profile;
  String? phoneNo;
  String? email;
  String? createdAt;

  MyProfileResponseModel({this.id, this.firstName, this.lastName, this.profile, this.phoneNo, this.email, this.createdAt});

  MyProfileResponseModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if(json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if(json["profile"] is String) {
      profile = json["profile"];
    }
    if(json["phone_no"] is String) {
      phoneNo = json["phone_no"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["profile"] = profile;
    data["phone_no"] = phoneNo;
    data["email"] = email;
    data["created_at"] = createdAt;
    return data;
  }
}