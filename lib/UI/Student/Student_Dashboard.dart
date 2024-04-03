import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediquizpro/UI/Doctor/Doctor_Profile.dart';
import 'package:mediquizpro/UI/Student/Totalscore_Screen.dart';
import 'package:mediquizpro/Utils/shared_preference.dart';
import 'package:mediquizpro/main.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';
import '../Doctor/Leaderboard.dart';
import '../Splash_screen.dart';
import 'Drawer_Totalscreen.dart';
import 'Pathology_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Review_screen.dart';


class Student_Dashboard extends StatefulWidget {
  const Student_Dashboard({Key? key}) : super(key: key);

  @override
  State<Student_Dashboard> createState() => _Student_DashboardState();
}

class _Student_DashboardState extends State<Student_Dashboard> {
  List<String> namelist = ["Profile", "Leader Board", "Score", "Review answer", "Logout"];
  List<String> imagelist = ["assets/Male User.png", "assets/Laurel Wreath.png", "assets/Scorecard.png", "assets/Order Completed.png",
    "assets/Logout Rounded Left.png"];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  GlobalKey<NavigatorState> _yourKey = GlobalKey<NavigatorState>();
  _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Student_Dashboard()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() => _backPressed(_yourKey),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Image.asset("assets/Menu.png"),
          ),
          centerTitle: true,
          title: Text("Home"),
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width/1.7, // Half the screen width
          height: MediaQuery.of(context).size.height/1.1,
      child: ClipRRect(
      borderRadius: BorderRadius.only(
      topRight: Radius.circular(30.0), // Adjust the radius as needed
      bottomRight: Radius.circular(30.0), // Adjust the radius as needed
      ),
          child: Drawer(
            backgroundColor:Color(0xFF434B90),
        child: ListView.builder(
      itemCount: namelist.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            if(namelist![index] == "Profile") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Doctor_Profile(),
                ),
              );
            }
           else if(namelist![index] == "Leader Board") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      leaderboard(),
                ),
              );
            }
            else if(namelist![index] == "Score") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Drwaer_Totalscore(),
                ),
              );
            }
            else if(namelist![index] == "Review answer") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Review_screen(),
                ),
              );
            }
            else if (namelist![index] == "Logout") {
              logout();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Splashscreen(),
                ),
              );
            }

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: index < imagelist.length
                  ? Image.asset(
                                imagelist[index],
                                width: 50, // Adjust size as needed
                                height: 50, // Adjust size as needed
                              )
                    : null,
              title: Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child: Text(namelist[index],style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        );
      }
        )
          ),
        ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Pathology_Screen()
                      ),
                    );
                    print("object");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width /1.05,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Adjust the border radius here
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400.withOpacity(0.2), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 1, // Blur radius
                          offset: Offset(0, 0), // Offset of the shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Adjust the border radius here
                      child: Center(
                        child: Text("Pathology",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1),),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width / 1.05,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Icon(Icons.sticky_note_2_outlined,color: Colors.grey),
                              SizedBox(width: 7,),
                              Text("Instructions",style: TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("This is a pocket friendly digital based mobile app created for the Pathology postgraduates to self evaluate their knowledge in the field of Dermatopathology."),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(width:10,),
                              Expanded(child: Text("1.A total of 50 case scenarios with related microscopic images are displayed for interpretation.")),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width:10,),
                              Expanded(child: Text("2.Each case contains 4 related subquestions and each carries 4 marks and the total marks for 200.")),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width:10,),
                              Text("3.There are no negative markings."),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width:10,),
                              Text("4.The duration of the test is alloted for 120 minutes."),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width:7,),
                              Text(" 5.Only single attempt is allowed after logging in."),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width:7,),
                              Text(" 6.Scroll up and down to view the entire page."),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width:10,),
                              Text("7.One can review the question and change the answers\n"
                                  " multiple times but within the alloted time frame."),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width:10,),
                              Text("8.On completion of the test,click submit all and exit."),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width:10,),
                              Text("9.The answer key can be viewed and the test scores will\n be displayed in the score card."),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
          ),
        ),
      ),
    );
  }
  void restartApp() {
    // Method to restart the application
    runApp(MyApp());
    // Close the current application
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
