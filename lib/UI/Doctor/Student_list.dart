import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/Leaderboard_model.dart';
import 'package:mediquizpro/UI/Doctor/Doctor_Profile.dart';

import '../../API_services/Api_Services.dart';
import '../../Model/StudentList_model.dart';
import '../../Utils/utils.dart';

class Student_List extends StatefulWidget {
  const Student_List({super.key});

  @override
  State<Student_List> createState() => _Student_ListState();
}

class _Student_ListState extends State<Student_List> {
  // List<String>? Dashboardlist=["Add Questions","History of add Questions","Student List"];
  bool isLoading = true;
  StudentList_model? cStudentList_model;
  String? Totalscore;
  List<String> totalscorelist=[];
  List<Leaderboard_model> leaderboardDetail = [];
  List<String> namelist = ["Student1", "Student2", "Student3"];
  List<String> numberlist = ["47/50", "46/50", "44/50"];
  List<Image> imageList = [
    Image.asset("assets/rank1.png"),
    Image.asset("assets/rank2.png"),
    Image.asset("assets/rank3.png"),];

  List<String> Total = [];
  List<String> User = [];
  String? totalscore;
  String? UserId;

  // StudentListAPI() async {
  //   isLoading = true;
  //   setState(() {});
  //
  //   ApiServices().studentlist().then((value) {
  //     if (value != null) {
  //       print("login");
  //       print(value);
  //       setState(() {
  //         cStudentList_model = value;
  //         // Totalscore = cStudentList_model!.totalScore;
  //         // for(int i = 0 ; i<Totalscore!.length ; i++) {
  //         }
  //       );
  //     } else {
  //       toastMessage(context, "Something went wrong", Colors.red);
  //     }
  //     isLoading = false;
  //     setState(() {});
  //   });
  // }

  @override
  void initState() {
    super.initState();
    StudentListAPI();
  }


  StudentListAPI() async {
    isLoading = true;
    setState(() {});
    ApiServices().studentlist().then((List<StudentList_model> value) {
      if (value.isNotEmpty) {
        print("login");
        print(value);
        setState(() {
          // Clear previous data
          Total.clear();
          User.clear();
          cStudentList_model = value.first; // Assuming you want the first item in the list
          totalscore = cStudentList_model!.totalScore;
          UserId = cStudentList_model!.userId;
          // Use forEach to iterate over the list
          value.forEach((item) {
            Total.add(totalscore!);
            User.add(UserId!);
            print("TotalController");
            print(item.totalScore); // Accessing each item's totalScore
          });
          print(totalscore);
          print(Total);
          print("totalscore");
        });
      } else {
        toastMessage(context, "Something went wrong", Colors.red);
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
        centerTitle: true,
        title: Text("Student List "),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: isLoading == true ? loaderWidget() : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical:10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:Total?.length,
                itemBuilder: (BuildContext context, int index) {
                  var score = Total![index];
                  var id = User![index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 8),
                  child: Card(
                      elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListTile(
                          title: Text("${id}"),
                                trailing: Text("${score}"),
                        ),
                      ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
