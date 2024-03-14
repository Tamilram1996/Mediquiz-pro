class Login_Model {
  bool? status;
  String? message;
  Data? data;
  String? authKey;

  Login_Model({this.status, this.message, this.data, this.authKey});

  Login_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    authKey = json['auth_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['auth_key'] = this.authKey;
    return data;
  }
}

class Data {
  String? userId;
  String? name;
  String? password;
  String? emailId;
  String? phoneNo;
  String? institution;
  String? designation;
  String? profilePhoto;
  String? createdOn;

  Data(
      {this.userId,
        this.name,
        this.password,
        this.emailId,
        this.phoneNo,
        this.institution,
        this.designation,
        this.profilePhoto,
        this.createdOn});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    password = json['password'];
    emailId = json['email_id'];
    phoneNo = json['phone_no'];
    institution = json['institution'];
    designation = json['designation'];
    profilePhoto = json['profile_photo'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['password'] = this.password;
    data['email_id'] = this.emailId;
    data['phone_no'] = this.phoneNo;
    data['institution'] = this.institution;
    data['designation'] = this.designation;
    data['profile_photo'] = this.profilePhoto;
    data['created_on'] = this.createdOn;
    return data;
  }
}
