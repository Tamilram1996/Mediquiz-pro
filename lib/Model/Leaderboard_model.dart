class LeaderboardModel {
  LeaderboardModel({
    required this.data,
  });

  final List<leader> data;

  factory LeaderboardModel.fromJson(Map<String, dynamic> json){
    return LeaderboardModel(
      data: json["data"] == null ? [] : List<leader>.from(json["data"]!.map((x) => leader.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
  };

}

class leader {
  leader({
    required this.userId,
    required this.totalScore,
    required this.rankImage,
    required this.rank,
  });

  final String? userId;
  final String? totalScore;
  final String? rankImage;
  final int? rank;

  factory leader.fromJson(Map<String, dynamic> json){
    return leader(
      userId: json["user_id"],
      totalScore: json["total_score"],
      rankImage: json["rank_image"],
      rank: json["rank"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "total_score": totalScore,
    "rank_image": rankImage,
    "rank": rank,
  };

}
