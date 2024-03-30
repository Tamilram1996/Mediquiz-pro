class Leaderboard_model {
  String? userId;
  String? totalScore;

  Leaderboard_model({this.userId, this.totalScore});

  Leaderboard_model.fromJson(Map<String, dynamic> json) {
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
