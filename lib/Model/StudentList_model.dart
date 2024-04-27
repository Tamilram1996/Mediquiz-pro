class StudentListModel {
  StudentListModel({
    required this.data,
  });

  final List<Students> data;

  factory StudentListModel.fromJson(Map<String, dynamic> json){
    return StudentListModel(
      data: json["data"] == null ? [] : List<Students>.from(json["data"]!.map((x) => Students.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
  };

}

class Students {
  Students({
    required this.userId,
    required this.totalScore,
  });

  final String? userId;
  final String? totalScore;

  factory Students.fromJson(Map<String, dynamic> json){
    return Students(
      userId: json["user_id"],
      totalScore: json["total_score"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "total_score": totalScore,
  };

}
