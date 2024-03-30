class Correctanswer_Model {
  String? status;
  String? message;
  List<MatchedAnswersArray>? matchedAnswersArray;

  Correctanswer_Model({this.status, this.message, this.matchedAnswersArray});

  Correctanswer_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['matched_answers_array'] != null) {
      matchedAnswersArray = <MatchedAnswersArray>[];
      json['matched_answers_array'].forEach((v) {
        matchedAnswersArray!.add(new MatchedAnswersArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.matchedAnswersArray != null) {
      data['matched_answers_array'] =
          this.matchedAnswersArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchedAnswersArray {
  int? caseStudyID;
  String? caseStudy;
  int? questionID;
  String? question;
  String? userAnswer;
  String? matchedOption;

  MatchedAnswersArray(
      {this.caseStudyID,
        this.caseStudy,
        this.questionID,
        this.question,
        this.userAnswer,
        this.matchedOption});

  MatchedAnswersArray.fromJson(Map<String, dynamic> json) {
    caseStudyID = json['caseStudyID'];
    caseStudy = json['caseStudy'];
    questionID = json['questionID'];
    question = json['question'];
    userAnswer = json['userAnswer'];
    matchedOption = json['matchedOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caseStudyID'] = this.caseStudyID;
    data['caseStudy'] = this.caseStudy;
    data['questionID'] = this.questionID;
    data['question'] = this.question;
    data['userAnswer'] = this.userAnswer;
    data['matchedOption'] = this.matchedOption;
    return data;
  }
}
