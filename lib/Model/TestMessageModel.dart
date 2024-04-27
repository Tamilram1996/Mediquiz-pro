class TestMessageModel {
  TestMessageModel({
    required this.status,
    required this.message,
  });

  final int? status;
  final String? message;

  factory TestMessageModel.fromJson(Map<String, dynamic> json){
    return TestMessageModel(
      status: json["status"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };

}
