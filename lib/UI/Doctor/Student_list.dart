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
  StudentListModel? cStudentList_model;
  List<Students>? studentscore;
  @override
  void initState() {
    super.initState();
    StudentListAPI();
  }


  StudentListAPI() async {
    try {
      isLoading = true;
      setState(() {});
      // Uncomment the API call
      ApiServices().studentlist().then((value) {
        if (value != null) {
          print("login");
          print(value);
          setState(() {
            cStudentList_model = value;
            studentscore = cStudentList_model!.data;
            print(studentscore);
          });
        } else {
          toastMessage(context, "Something went wrong", Colors.red);
        }
        isLoading = false;
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
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
      body: isLoading == true ? loaderWidget() : Center(
        child: Container(
          height: MediaQuery.of(context).size.height/1.25,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Group 14.png"),
              fit: BoxFit.cover,

            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical:10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:studentscore!.length,
                    itemBuilder: (BuildContext context, int index) {
                      // var score = Total![index];
                      // var id = User![index];
                      var item = studentscore![index];
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
                                title: Text("${item.userId}"),
                                trailing: Text("${item.totalScore}"),
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
        ),
      ),
    );
  }
}
