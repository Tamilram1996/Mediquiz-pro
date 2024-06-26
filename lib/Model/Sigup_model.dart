class SigupModel {
  SigupModel({
    required this.status,
    required this.message,
  });

  final String? status;
  final String? message;

  factory SigupModel.fromJson(Map<String, dynamic> json){
    return SigupModel(
      status: json["status"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };

}
