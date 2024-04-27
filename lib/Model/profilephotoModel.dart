class ProfilephotoModel {
  ProfilephotoModel({
    required this.status,
    required this.message,
  });

  final String? status;
  final String? message;

  factory ProfilephotoModel.fromJson(Map<String, dynamic> json){
    return ProfilephotoModel(
      status: json["status"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };

}
