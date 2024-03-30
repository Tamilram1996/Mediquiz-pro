class StudentList_model {
  String? userId;
  String? totalScore;

  StudentList_model({this.userId, this.totalScore});

  StudentList_model.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    totalScore = json['total_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['total_score'] = this.totalScore;
    return data;
  }
}
