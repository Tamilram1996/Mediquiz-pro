import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/Correctanswer_model.dart';
import 'package:mediquizpro/Model/Wronganswer_model.dart';

import '../../API_services/Api_Services.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';

String? userid;

class DrawerReview_screen extends StatefulWidget {
  const DrawerReview_screen({Key? key}) : super(key: key);

  @override
  State<DrawerReview_screen> createState() => _DrawerReview_screenState();
}

class _DrawerReview_screenState extends State<DrawerReview_screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;
  TextEditingController Useridcontroller = TextEditingController();
  CorrectanswerModel? cCorrectanswer_Model;
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
      CorrectAnswerAPI();
    } else if (_tabController.index == 1) {
      WrongAnswerAPI();
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
    CorrectAnswerAPI();
    setState(() {
      isLoading = false;
    });
  }

  CorrectAnswerAPI() async {
    isLoading = true;
    setState(() {});
    ApiServices().correctanswers(Useridcontroller.text).then((value) {
      if (value != null && value.status == "success") {
        print("login");
        print(value);
        cCorrectanswer_Model = value;
        matchedAnswerslist = cCorrectanswer_Model!.matchedAnswersArray;
        print(matchedAnswerslist);
        print("over");
        toastMessage(context, value.message!.toString(), Colors.green);
      } else {
        toastMessage(context, "Something Went Wrong correct answer", Colors.red);
        print("ghegt");
      }
      isLoading = false;
      setState(() {});
    });
  }

  WrongAnswerAPI() async {
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
        toastMessage(context, value.message!.toString(), Colors.green);
      } else {
        toastMessage(context, "Something Went Wrong wrong answer", Colors.red);
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
            matchedAnswerslist!=null ? ListView.builder(
              itemCount: matchedAnswerslist!.length,
              itemBuilder: (context, index) {
                  var list = matchedAnswerslist![index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height:35,
                                    width:MediaQuery.of(context).size.width/1.2,
                                    child: SingleChildScrollView(child: Text('${list.caseStudy}' ?? ""))),
                              ],
                            ),
                           SizedBox(height: 15,),
                            Row(
                              children: [
                                Container(
                                    height:35,
                                    width:MediaQuery.of(context).size.width/1.17,
                                    child: SingleChildScrollView(child: Text('${list.question}' ?? ""))),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                    height:35,
                                    width:MediaQuery.of(context).size.width/1.2,
                                    child: SingleChildScrollView(child: Text('${list.userAnswer}' ?? ""))),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("Correct",style: TextStyle(color: Colors.green.shade400,fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
              },
            ) : Container(child: Center(child: Text("No Data",style: TextStyle(fontSize: 20),)),),
            // Content for the 'Wrong' tab
    unmatchedAnswerslist!=null ? ListView.builder(
              itemCount: unmatchedAnswerslist!.length,
              itemBuilder: (context, index) {
                if (unmatchedAnswerslist != null && unmatchedAnswerslist!.isNotEmpty) {
                  var list = unmatchedAnswerslist![index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    height:35,
                                    width:MediaQuery.of(context).size.width/1.2,
                                    child: SingleChildScrollView(child: Text('${list.caseStudy}' ?? ""))),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Container(
                                    height:35,
                                    width:MediaQuery.of(context).size.width/1.17,
                                    child: SingleChildScrollView(child: Text('${list.question}' ?? ""))),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                    height:35,
                                    width:MediaQuery.of(context).size.width/1.2,
                                    child: SingleChildScrollView(child: Text('${list.userAnswer}' ?? ""))),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("Wrong",style: TextStyle(color: Colors.red.shade400,fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ) :  Container(child: Center(child: Text("No Data",style: TextStyle(fontSize: 20),)),),
          ],
        ),
      ),
    );
  }
}
