import 'package:flutter/material.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';
import '../Splash_screen.dart';
import 'Add_Question.dart';
import 'DoctorGetQuestion.dart';
import 'Doctor_Profile.dart';
import 'Leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Student_list.dart';

class Doctor_Dashboard extends StatefulWidget {
  const Doctor_Dashboard({super.key});

  @override
  State<Doctor_Dashboard> createState() => _Doctor_DashboardState();
}

class _Doctor_DashboardState extends State<Doctor_Dashboard> {
  bool isLoading =false;
  List<String>? Dashboardlist=["Add Questions","History of add Questions","Student List"];
  String? userName;


  @override
  void initState() {
    super.initState();
    dataList();
    userName = "";
  }

  void dataList() async{
    userName = await getUserName();
    print(userName.toString());
    print("userName.toString()");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      leaderboard(),
                ),
              );

print("object");
            },
            icon: Image.asset("assets/Laurel Wreath-1.png"),
          ),
          actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Doctor_Profile(),
                  ),
                );
              },
              icon:  Image.asset("assets/Male User-1.png"),
            ),
          ]
      ),
      body: isLoading == true ? loaderWidget() :
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Dashboardlist!.length,
              itemBuilder: (BuildContext context, int index) {
                var list = Dashboardlist![index];
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(Dashboardlist![index] == "Add Questions") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Add_Question(),
                              ),
                            );
                          }
                          else if(Dashboardlist![index] == "History of add Questions"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DoctorGetQuestion(),
                              ),
                            );
                          }
                          else if(Dashboardlist![index] =="Student List"){
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Student_List(),
                          ),
                          );
                          }

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 65.0),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              height: 70,
                              width: MediaQuery.of(context).size.width /1.6,
                              child: Center(
                                child: Text(list),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () async {
          logout();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Splashscreen(),
            ),
          );
        },
          child: Image.asset("assets/Logout Rounded Left.png",color: Colors.black,))
    );
  }
}
