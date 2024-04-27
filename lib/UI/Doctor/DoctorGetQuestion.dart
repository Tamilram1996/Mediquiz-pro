import 'package:flutter/material.dart';

import '../../API_services/Api_Services.dart';
import '../../Model/History_Question.dart';
import '../../Utils/utils.dart';
import 'Doctor_Profile.dart';

String? optionidlist;
String? optiondesclist;
List<String>? subid;
String? subquestionid;
String? subquestiondesc;
class DoctorGetQuestion extends StatefulWidget {
  const DoctorGetQuestion({super.key});

  @override
  State<DoctorGetQuestion> createState() => _DoctorGetQuestionState();
}

class _DoctorGetQuestionState extends State<DoctorGetQuestion> {

  bool isLoading = true;
  HistoryQuestion_Model? cHistoryQuestion_Model;
  List<Data>? questionlist;

  // List<SubQuestions>? subQuestionlist;


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
        // for (int i =0 ; i< subQuestionlist!.length; i++){
        //   subquestionid = cHistoryQuestion_Model!.data![i].subQuestions![i].questionId.toString();
        //   print(subquestionid);
        print("over");
        //   print("fuzcsgdsgdsgdsg");
        //
        // }

        print("questionlist");
        print(questionlist);
        toastMessage(context, value!.message!.toString(), Colors.green);
      }
      else {
        toastMessage(context, "Something Went Wrong", Colors.red);
      }
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("History of Add Questions"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Doctor_Profile(),
                ),
              );
            },
            icon: Image.asset("assets/Male User-1.png"),
          ),
        ],
      ),
      body: isLoading
          ? loaderWidget()
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
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0),
                            child: ListTile(
                              title: Column(
                                children: [
                                  Text("${item.caseStudy}"),
                                  SizedBox(height: 25),
                                  Container(
                                    color: Colors.teal,
                                    // height: MediaQuery
                                    //     .of(context)
                                    //     .size
                                    //     .height / 2,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    child: Image.network("${item.photo}"),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Displaying Sub-Questions and Options
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: subQuestionlist?.length,
                        itemBuilder: (BuildContext context, int index) {
                          var subQuestion = subQuestionlist![index];
                          var options = subQuestion.options;
                          return Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50.withOpacity(1),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${subQuestion
                                        .questionId}. ${subQuestion.question}"),
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
                                                SizedBox(width:25),
                                                Text("${option.optionId})."),
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
                              ),
                            ),
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
      ),
    );
  }
}

