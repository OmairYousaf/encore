class UserProfile {
  Data? data;

  UserProfile({this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? email;
  String? profileImage;
  String? role;
  String? status;
  String? otp;

  Data(
      {this.id,
      this.name,
      this.email,
      this.profileImage,
      this.role,
      this.status,
      this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    role = json['role'];
    status = json['status'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['role'] = this.role;
    data['status'] = this.status;
    data['otp'] = this.otp;
    return data;
  }
}
