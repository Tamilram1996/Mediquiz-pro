class Totalscore_Model {
  String? status;
  int? totalScore;
  int? totalWrong;

  Totalscore_Model({this.status, this.totalScore, this.totalWrong});

  Totalscore_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalScore = json['total_score'];
    totalWrong = json['total_wrong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total_score'] = this.totalScore;
    data['total_wrong'] = this.totalWrong;
    return data;
  }
}
