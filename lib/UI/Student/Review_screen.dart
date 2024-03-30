import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/Correctanswer_model.dart';
import 'package:mediquizpro/Model/Wronganswer_model.dart';

import '../../API_services/Api_Services.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';

String? userid;

class Review_screen extends StatefulWidget {
  const Review_screen({Key? key}) : super(key: key);

  @override
  State<Review_screen> createState() => _Review_screenState();
}

class _Review_screenState extends State<Review_screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;
  TextEditingController Useridcontroller = TextEditingController();
  Correctanswer_Model? cCorrectanswer_Model;
  Wronganswer_Model? cWronganswer_Model;
  List<MatchedAnswersArray>? matchedAnswerslist;
  List<UnmatchedAnswersArray>? unmatchedAnswerslist;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection); // Add listener for tab changes
    bioIdFunction();
  }

  void _handleTabSelection() {
    // Call the respective API function based on the selected tab index
    if (_tabController.index == 0) {
      CorrectAnswerAPI(Useridcontroller);
    } else if (_tabController.index == 1) {
      WrongAnswerAPI(Useridcontroller);
    }
  }

  void bioIdFunction() async {
    isLoading = true;
    setState(() {});
    userid = await Getuserid();
    Useridcontroller.text = userid.toString();
    print("edituserid");
    print(userid);
    print(Useridcontroller.text);
    CorrectAnswerAPI(Useridcontroller);
    setState(() {
      isLoading = false;
    });
  }

  CorrectAnswerAPI(Useridcontroller) async {
    isLoading = true;
    setState(() {});
    ApiServices().correctanswers(Useridcontroller.text).then((value) {
      if (value != null && (value.status! == "success")) {
        print("login");
        print(value);
        cCorrectanswer_Model = value;
        matchedAnswerslist = cCorrectanswer_Model!.matchedAnswersArray;
        print(matchedAnswerslist);
        print("over");
        toastMessage(context, value.status!.toString(), Colors.green);
      } else {
        toastMessage(context, "Something Went Wrong1", Colors.red);
        print("ghegt");
      }
      isLoading = false;
      setState(() {});
    });
  }

  WrongAnswerAPI(Useridcontroller) async {
    isLoading = true;
    setState(() {});
    ApiServices().wronganswer(Useridcontroller.text).then((value) {
      if (value != null && (value.status! == "success")) {
        print("login");
        print(value);
        cWronganswer_Model = value;
        unmatchedAnswerslist = cWronganswer_Model!.unmatchedAnswersArray;
        print(matchedAnswerslist);
        print("over");
        toastMessage(context, value.status!.toString(), Colors.green);
      } else {
        toastMessage(context, "Something Went Wrong2", Colors.red);
        print("ghegt");
      }
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Set the color of the outer padding here
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Review"),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Correct'),
              Tab(text: 'Wrong'),
            ],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF434B90),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            indicatorPadding: EdgeInsets.all(6),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Content for the 'Correct' tab
            ListView.builder(
              itemCount: matchedAnswerslist != null ? matchedAnswerslist!.length : 1,
              itemBuilder: (context, index) {
                if (matchedAnswerslist != null && matchedAnswerslist!.isNotEmpty) {
                  var list = matchedAnswerslist![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('${list.caseStudy}' ?? ""),
                            ],
                          ),
                          Text('${list.question}' ?? ""),
                          Text('${list.userAnswer}' ?? ""),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Correct"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Display a message when matchedAnswerslist is null or empty
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No data Available "),
                    ],
                  );
                }
              },
            ),
            // Content for the 'Wrong' tab
            ListView.builder(
              itemCount: unmatchedAnswerslist != null ? unmatchedAnswerslist!.length : 1,
              itemBuilder: (context, index) {
                if (unmatchedAnswerslist != null && unmatchedAnswerslist!.isNotEmpty) {
                  var list = unmatchedAnswerslist![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('${list.caseStudy}' ?? ""),
                            ],
                          ),
                          Text('${list.question}' ?? ""),
                          Text('${list.userAnswer}' ?? ""),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Correct"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Display a message when unmatchedAnswerslist is null or empty
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No data Available "),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
