class TimerModel {
  TimerModel({
    required this.status,
    required this.timer,
  });

  final String? status;
  final int? timer;

  factory TimerModel.fromJson(Map<String, dynamic> json){
    return TimerModel(
      status: json["status"],
      timer: json["timer"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "timer": timer,
  };

}
