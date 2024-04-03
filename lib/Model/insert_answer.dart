class Insertanswermodel {
  Insertanswermodel({
    required this.status,
    required this.message,
  });

  final String? status;
  final String? message;

  factory Insertanswermodel.fromJson(Map<String, dynamic> json){
    return Insertanswermodel(
      status: json["status"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };

}
