import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/insert_answer.dart';
import 'package:mediquizpro/UI/Student/Totalscore_Screen.dart';

import '../../API_services/Api_Services.dart';
import '../../Model/History_Question.dart';
import '../../Utils/base.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';

// String? subquestionid;
String? userid;
String? Caseid ;
String? Useranswer1;
String? Useranswer2;
String? Useranswer3;
String? Useranswer4;
class Casestudy_screen2 extends StatefulWidget {
  const Casestudy_screen2({Key? key}) : super(key: key);

  @override
  State<Casestudy_screen2> createState() => _Casestudy_screen2State();
}

class _Casestudy_screen2State extends State<Casestudy_screen2> {
  late Timer _timer;
  int _timeLeft = 0; // Initial time in seconds
  bool _automaticSubmission = false;
  HistoryQuestion_Model? cHistoryQuestion_Model;
  List<TextEditingController>? _controllers;
  List<Data>? questionlist;

  // List<Data>? questionid;
  bool isLoading = false;
  Data? currentQuestion;
  int currentIndex = 0;
  TextEditingController Useridcontroller = TextEditingController();
Insertanswermodel? cInsertanswermodel;
  List<QuestionAnswer>? mQuestionAnswer=[];
  QuestionAnswer? mSelectedanswer;
  ChapterGrouplistModel? mChapterGrouplistModel;
bool manualSubmission = false;

  @override
  void initState() {
    super.initState();
    // QuestionMainAPI();
    bioIdFunction();
  }

  void bioIdFunction() async {
    setState(() {
      isLoading = true;
    });
    userid = await Getuserid();
    Useridcontroller.text = userid.toString();

    print("edituserid");
    print(userid);
    print(Useridcontroller.text);
    QuestionMainAPI();
  }

  Answermain() {
    isLoading = true;
    setState(() {});
    ApiServices()
        .insertanswer(
      Useridcontroller.text,
        Caseid,
        mQuestionAnswer).then((value) {
      if (value != null && (value!.status! == "success")) {
        print("login");
        print(value);
        cInsertanswermodel = value;
        print("objecdvvdvbdbvfvbt");
        print(Caseid);
        toastMessage(context, value!.message!.toString(), Colors.green);

      } else {

        toastMessage(context, "Something went wrong", Colors.red);
        // toastMessage(context, "User already exists in the database. No new data submitted", Colors.red);
      }
      isLoading = false;
      setState(() {});
    });
  }

  QuestionMainAPI() async {
    setState(() {
      isLoading = true;
    });
    ApiServices().question().then((value) async {
      if (value != null &&
          (value!.status! == "success"))  {
        print("login");
        print(value);
        cHistoryQuestion_Model = value;
        questionlist = cHistoryQuestion_Model!.data;
        if (cHistoryQuestion_Model!.data!.length > 0) {
          currentQuestion = cHistoryQuestion_Model!.data![0];
          String Questionansweid = currentQuestion!.id.toString();
          // if(currentQuestion!.id != null)
          print("mSelectedanswer");
          print(mSelectedanswer);
          if(currentQuestion!.subQuestions !=null) {
            for (int i = 0; i < currentQuestion!.subQuestions!.length; i++) {
              // var Data =mQuestionAnswer![i].questionId![i].isEmpty;
              mQuestionAnswer!.add(
                  QuestionAnswer(questionId: currentQuestion!.subQuestions![i].questionId.toString(), userAnswer: "0"));
              selectedOptionIdForSubQuestion!.add(0);
              print(selectedOptionIdForSubQuestion!.length);
              print("selectedOptionIdForSubQuestion");
            }
          }
          Caseid = currentQuestion!.id.toString();

          print("Questionansweid");
          print(Questionansweid);
        }
        print("over");
        print("questionlist");
        print(questionlist);
        toastMessage(context, value!.message!.toString(), Colors.green);
        _startTimer();
      }
      else {
        toastMessage(
            context, "Something Went Wrong please try after few minutes",
            Colors.red);
      }
      setState(() {
        isLoading = false;
      });


    });
  }


  void _startTimer() {
    // _timer.cancel();
    _timeLeft = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer.cancel(); // Stop the timer when time is up
        if (!_automaticSubmission) {
          cHistoryQuestion_Model!.data!.length - 1 == currentIndex
              ? _handleSubmit() :
          next();
          // Pass false for manual submission
        }
      }
    });
  }

  void _handleSubmit() {
    print('Submitted!');
    _timer.cancel();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Modal barrier to prevent interactions with widgets behind the dialog
            ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
            Theme(
              data: ThemeData.light().copyWith(
                dialogBackgroundColor: Colors.grey.shade200,
              ),
              child: AlertDialog(
                title: Text(
                  "Test Finished",
                  style: TextStyle(fontSize: Base.titlefont),
                ),
                content: Text("Test Finished Successfully"),
                actions: [
                  TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(color: Base.primaryColor),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Totalscore_Mainscreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr =
    (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';
    return '$minutesStr:$secondsStr';
  }
List<int>? selectedOptionIdForSubQuestion=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Case Study"),
        centerTitle: true,
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20, // Adjusted height
                width: 80, // Adjusted width
                decoration: BoxDecoration(
                  color: Color(0xFF434B90),
                  borderRadius: BorderRadius.circular(30), // Rounded shape
                ),
                child: Center(
                  child: Text(
                    _formatTime(_timeLeft), // Show remaining time
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: isLoading == true || cHistoryQuestion_Model == null || currentQuestion == null
          ? loaderWidget()
          : SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0),
                  child: ListTile(
                    title: Column(
                      children: [
                        Text("${currentQuestion!.caseStudy}"),
                        SizedBox(height: 25),
                        Container(
                          color: Colors.teal,
                          height: 100,
                          width: 100,
                          child: Image.network("${currentQuestion!.photo}"),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: currentQuestion!.subQuestions!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var subQuestion = currentQuestion!.subQuestions![index];
                    var options = subQuestion.options;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${subQuestion.questionId}. ${subQuestion
                              .question}"),
                          SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: options?.length,
                            itemBuilder: (BuildContext context, int optionIndex) {
                              var option = options![optionIndex];
                              return Column(
                                children: [
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      SizedBox(width: 25),
                                      // Checkbox(
                                      //   value: selectedOptionIdForSubQuestion![index] == option.optionId,
                                      //   onChanged: (bool? checked) {
                                      //     setState(() {
                                      //       if (checked!) {
                                      //         // Update the selected option ID for the current sub-question
                                      //         selectedOptionIdForSubQuestion![index] = option.optionId!;
                                      //         // Set the selected option in the question answer list
                                      //         mQuestionAnswer![index].questionId = subQuestion.questionId.toString();
                                      //         mQuestionAnswer![index].userAnswer = option.optionId.toString();
                                      //       } else {
                                      //         // If unchecked, remove the selected option
                                      //         selectedOptionIdForSubQuestion![index] = 0;
                                      //         // Clear the selected option in the question answer list
                                      //         mQuestionAnswer![index].userAnswer = "0";
                                      //       }
                                      //     });
                                      //   },
                                      // ),
                                      Radio<int?>(
                                        value: option.optionId,
                                        groupValue: selectedOptionIdForSubQuestion![index],
                                        onChanged: (int? value) {

                                          setState(() {
                                            // Update the selected option ID for the current sub-question
                                            selectedOptionIdForSubQuestion![index] = value!;
                                            // subQuestion.selectedOptionId = value; // Update the selected option ID in the sub-question
                                            print("Selected option ID for sub-question ${subQuestion.questionId}: $value");
                                            mQuestionAnswer![index].questionId=subQuestion.questionId.toString();
                                            mQuestionAnswer![index].userAnswer=value.toString() ;
                                            option.selectedOptions?[subQuestion.questionId!] = value!;
                                            Useranswer1=value.toString();
                                            print("value++++");
                                            print(subQuestion
                                                .questionId!);
                                            print(option.selectedOptions?[subQuestion
                                                .questionId!]);
                                            print(currentQuestion!.id);
                                            print(value);
                                            print("value");
                                          });
                                        },
                                      ),
                                      SizedBox(width: 5),
                                      Text(option.optionDesc ?? "No Description"),
                                    ],
                                  ),
                                ],
                              );
                            },
                          )
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   itemCount: options?.length,
                          //   itemBuilder: (BuildContext context,
                          //       int optionIndex) {
                          //     var option = options![optionIndex];
                          //     return Column(
                          //       children: [
                          //         SizedBox(height: 15),
                          //         Row(
                          //           children: [
                          //             SizedBox(width: 25),
                          //             Radio<int?>(
                          //               value: option.optionId,
                          //
                          //               groupValue://option.selectedOptions?[index],
                          //               option.selectedOptions?[subQuestion
                          //                   .questionId!],
                          //               onChanged: (int? value) {
                          //                 setState(() {
                          //
                          //                   mQuestionAnswer![index].questionId=subQuestion.questionId.toString();
                          //                   mQuestionAnswer![index].userAnswer=value.toString();
                          //                   option.selectedOptions?[subQuestion
                          //                       .questionId!] = value!;
                          //                   Useranswer1=value.toString();
                          //                   print("value++++");
                          //                   print(subQuestion
                          //                       .questionId!);
                          //                   print(option.selectedOptions?[subQuestion
                          //                       .questionId!]);
                          //                   print(currentQuestion!.id);
                          //                   print(value);
                          //                   print("value");
                          //                   for(int i=0;i<options.length;i++){
                          //                     if(i==optionIndex){
                          //                       print("value++++++++++++");
                          //                       option.selectedOptions![i]=1;
                          //                     }else{
                          //                       option.selectedOptions![i]=0;
                          //                     }
                          //                     print("optionIndex");
                          //                     print(optionIndex);
                          //                   }
                          //                   // Useranswer1=value.toString();
                          //                   // _controllers![3].text = value!.toString();
                          //
                          //
                          //                 });
                          //               },
                          //             ),
                          //             SizedBox(width: 5),
                          //             Text(option.optionDesc ??
                          //                 "No Description"),
                          //           ],
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
      bottomSheet: cHistoryQuestion_Model == null ?
          loaderWidget()
          :Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 45,
        child: cHistoryQuestion_Model!.data!.length-1 == currentIndex ?
        ElevatedButton(
          child: Text(
            "Submit",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            setState(() {
              submit();
            });
            _handleSubmit();// Manual submission
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF434B90),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ) : ElevatedButton(
          child: Text(
            "Next",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),

          onPressed: () {
            next();
            // currentIndex = currentIndex + 1;
            // setState(() {
              // _startTimer();
              _timeLeft = 60;
            // });
            // print(currentIndex);
            // currentQuestion = cHistoryQuestion_Model!.data![currentIndex];
            // print(currentQuestion);
            print("mQuestionAnswer+++");
            String jsonFormat = jsonEncode(mQuestionAnswer);
            print(jsonFormat);
            print(mQuestionAnswer);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF434B90),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
    );
  }

  void next() {
    Answermain();
      // Reset selectedOptionIdForSubQuestion to deselect radio buttons
    currentIndex = currentIndex + 1;
    setState(() {
      selectedOptionIdForSubQuestion = List.generate(currentQuestion!.subQuestions!.length, (index) => 0);
    });
    setState(() {
      // _startTimer();
      _timeLeft = 60;
    });

    print(currentIndex);
    currentQuestion = cHistoryQuestion_Model!.data![currentIndex];
    Caseid="";
    Caseid = currentQuestion!.id.toString();
    print(Caseid);
    print(currentQuestion);
  }
  void submit(){
    Answermain();

  }


}

class ChapterGrouplistModel {
  ChapterGrouplistModel({
    required this.userId,
    required this.caseStudyId,
    required this.questionAnswers,
  });


  final int? userId;
  final int? caseStudyId;
  final List<QuestionAnswer> questionAnswers;

  factory ChapterGrouplistModel.fromJson(Map<String, dynamic> json){
    return ChapterGrouplistModel(
      userId: json["user_id"],
      caseStudyId: json["case_study_id"],
      questionAnswers: json["question_answers"] == null ? [] : List<QuestionAnswer>.from(json["question_answers"]!.map((x) => QuestionAnswer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "case_study_id": caseStudyId,
    "question_answers": questionAnswers.map((x) => x?.toJson()).toList(),
  };

}

class QuestionAnswer {
  QuestionAnswer({
    required this.questionId,
    required this.userAnswer,
  });

   String? questionId;
   String? userAnswer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json){
    return QuestionAnswer(
      questionId: json["question_id"],
      userAnswer: json["user_answer"],
    );
  }

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "user_answer": userAnswer,
  };

}





