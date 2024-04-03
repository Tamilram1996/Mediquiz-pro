import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mediquizpro/UI/Student/Totalscore_Screen.dart';

import '../../API_services/Api_Services.dart';
import '../../Model/History_Question.dart';
import '../../Utils/base.dart';
import '../../Utils/utils.dart';

String? subquestionid;
class Casestudy_screen extends StatefulWidget {
  const Casestudy_screen({Key? key}) : super(key: key);

  @override
  State<Casestudy_screen> createState() => _Casestudy_screenState();
}

class _Casestudy_screenState extends State<Casestudy_screen> {
  late Timer _timer;
  int _timeLeft = 30; // Initial time in seconds
  bool _automaticSubmission = false;
  HistoryQuestion_Model? cHistoryQuestion_Model;
  List<TextEditingController>? _controllers;
  List<Data>? questionlist;
  List<Data>? questionid;
  bool isLoading = true;
  TextEditingController Useridcontroller = TextEditingController();


  @override
  void initState() {
    super.initState();
    QuestionMainAPI();


  }



  QuestionMainAPI() async {
    isLoading = true;
    setState(() {});
    ApiServices().question().then((value) {
      if (value != null &&
          (value!.status! == "success")) {
        print("login");
        print(value);
        cHistoryQuestion_Model = value;
        questionlist = cHistoryQuestion_Model!.data;

        print("over");
        print("questionlist");
        print(questionlist);
        toastMessage(context, value!.message!.toString(), Colors.green);
        // _startTimer();
      }
      else {
        toastMessage(context, "Something Went Wrong please try after few minutes", Colors.red);
      }
      isLoading = false;
      setState(() {});
    });
  }


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer.cancel(); // Stop the timer when time is up
        if (!_automaticSubmission) {
          _handleSubmit(false); // Pass false for manual submission
        }
      }
    });
  }

  void _handleSubmit(bool manualSubmission) {
    // Implement your submission logic here
    print('Submitted!');
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Totalscore_Mainscreen(),
                        ),
                      );
                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
    if (manualSubmission) {
      // Cancel the timer only if the submission was manual
      _timer.cancel();
    }
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
      body: isLoading == true ? loaderWidget()
          : SingleChildScrollView(
        child: Column(
          children: [
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questionlist?.length,
        itemBuilder: (BuildContext context, int index) {
          var item = questionlist![index];
          var subQuestionlist = item.subQuestions;
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 4.0, horizontal: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0),
                  child: ListTile(
                    title: Column(
                      children: [
                        Text("${item.caseStudy}"),
                        SizedBox(height: 25),
                        Container(
                          color: Colors.teal,
                          height: 100,
                          width: 100,
                          child: Image.network("${item.photo}"),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: subQuestionlist?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var subQuestion = subQuestionlist![index];
                    var options = subQuestion.options;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${subQuestion.questionId}. ${subQuestion.question}"),
                          SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: options?.length,
                            itemBuilder: (BuildContext context,
                                int index) {
                              var option = options![index];
                              return Column(
                                children: [
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      SizedBox(width: 25),
                                      Radio<int?>(
                                        value: option.optionId,
                                        groupValue:
                                        option.selectedOptions?[subQuestion.questionId!],
                                        onChanged: (int? value) {
                                          setState(() {
                                            option.selectedOptions?[subQuestion.questionId!] = value!;

                                            // _controllers![3].text = value!.toString();



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
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      SizedBox(height: 50,),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
          child: Text(
            "Submit",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            for(int i = 0; i < questionlist!.length; i++){
              var item = questionlist![i];
              var subQuestionlist = item.subQuestions;
              for(int j = 0; j < item.subQuestions!.length; j++){
                print(_controllers![j].text);
                print("_controllers![j].text");
              }

            }
            _handleSubmit(true); // Manual submission
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Totalscore_Mainscreen()
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF434B90),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
    );
  }
}
