class Wronganswer_Model {
  String? status;
  String? message;
  List<UnmatchedAnswersArray>? unmatchedAnswersArray;

  Wronganswer_Model({this.status, this.message, this.unmatchedAnswersArray});

  Wronganswer_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['unmatched_answers_array'] != null) {
      unmatchedAnswersArray = <UnmatchedAnswersArray>[];
      json['unmatched_answers_array'].forEach((v) {
        unmatchedAnswersArray!.add(new UnmatchedAnswersArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.unmatchedAnswersArray != null) {
      data['unmatched_answers_array'] =
          this.unmatchedAnswersArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnmatchedAnswersArray {
  int? caseStudyID;
  String? caseStudy;
  int? questionID;
  String? question;
  String? userAnswer;
  String? matchedOption;

  UnmatchedAnswersArray(
      {this.caseStudyID,
        this.caseStudy,
        this.questionID,
        this.question,
        this.userAnswer,
        this.matchedOption});

  UnmatchedAnswersArray.fromJson(Map<String, dynamic> json) {
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
