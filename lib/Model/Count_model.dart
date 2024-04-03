class CountModel {
  String? status;
  int? totalRows;

  CountModel({this.status, this.totalRows});

  CountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRows = json['total_rows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total_rows'] = this.totalRows;
    return data;
  }
}
