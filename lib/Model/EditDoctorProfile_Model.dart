class EditDoctorProfile_Model {
  String? status;
  String? message;

  EditDoctorProfile_Model({this.status, this.message});

  EditDoctorProfile_Model.fromJson(Map<String, dynamic> json) {
    // Handle the case where values might be of different types
    status = json['status']?.toString();
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
