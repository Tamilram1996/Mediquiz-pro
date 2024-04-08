class TotalscoreModel {
  TotalscoreModel({
    required this.status,
    required this.totalScore,
    required this.totalWrong,
    required this.totalQuestion,
  });

  final String? status;
  final int? totalScore;
  final int? totalWrong;
  final int? totalQuestion;

  factory TotalscoreModel.fromJson(Map<String, dynamic> json){
    return TotalscoreModel(
      status: json["status"],
      totalScore: json["total_score"],
      totalWrong: json["total_wrong"],
      totalQuestion: json["total_question"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "total_score": totalScore,
    "total_wrong": totalWrong,
    "total_question": totalQuestion,
  };

}
