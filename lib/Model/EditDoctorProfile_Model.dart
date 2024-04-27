class EditDoctorProfile_Model {
  String? status;
  String? message;
  String? filename;

  EditDoctorProfile_Model({this.status, this.message, this.filename});

  EditDoctorProfile_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['filename'] = this.filename;
    return data;
  }
}
