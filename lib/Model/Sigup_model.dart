class Sigup_Model {
  String? status;
  String? message;
  String? authKey;

  Sigup_Model({this.status, this.message, this.authKey});

  Sigup_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authKey = json['auth_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['auth_key'] = this.authKey;
    return data;
  }
}
