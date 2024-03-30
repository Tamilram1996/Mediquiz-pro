class HistoryQuestion_Model {
  String? status;
  String? message;
  List<Data>? data;

  HistoryQuestion_Model({this.status, this.message, this.data});

  HistoryQuestion_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? caseStudy;
  String? photo;
  List<SubQuestions>? subQuestions;

  Data({this.id, this.caseStudy, this.photo, this.subQuestions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseStudy = json['Case_Study'];
    photo = json['photo'];
    if (json['sub_questions'] != null) {
      subQuestions = <SubQuestions>[];
      json['sub_questions'].forEach((v) {
        subQuestions!.add(new SubQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Case_Study'] = this.caseStudy;
    data['photo'] = this.photo;
    if (this.subQuestions != null) {
      data['sub_questions'] =
          this.subQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubQuestions {
  int? questionId;
  String? question;

  List<Optionsdata>? options;
  int? correctAnswer;

  SubQuestions(
      {this.questionId, this.question, this.options, this.correctAnswer});

  SubQuestions.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    if (json['options'] != null) {
      options = <Optionsdata>[];
      json['options'].forEach((v) {
        options!.add(new Optionsdata.fromJson(v));
      });
    }
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question'] = this.question;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class Optionsdata {
  int? optionId;
  Map<int, int>? selectedOptions = {};
  String? optionDesc;

  Optionsdata({this.optionId, this.optionDesc, this.selectedOptions});

  Optionsdata.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionDesc = json['option_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['option_desc'] = this.optionDesc;
    return data;
  }
}
