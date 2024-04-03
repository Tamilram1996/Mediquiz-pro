import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../API_services/Api_Services.dart';
import '../../Model/Leaderboard_model.dart';
import '../../Utils/utils.dart';

class leaderboard extends StatefulWidget {
  const leaderboard({super.key});

  @override
  State<leaderboard> createState() => _leaderboardState();
}

class _leaderboardState extends State<leaderboard> {
  bool isLoading = true;
  Leaderboard_model? cLeaderboard_model;
  String? totalscore;
  String? UserId;
  List<String>? imagelist =["assets/1.png","assets/2.png","assets/3.png"];
  String? dummyimage;
  List<String> Total = [];
  List<String> User = [];

  @override
  void initState() {
    super.initState();
    LeaderBoardAPI();
  }

  LeaderBoardAPI() async {
    isLoading = true;
    setState(() {});
    ApiServices().leaderboard().then((List<Leaderboard_model> value) {
      if (value.isNotEmpty) {
        print("login");
        print(value);
        setState(() {
          // Clear previous data
          Total.clear();
          User.clear();
          cLeaderboard_model = value.first; // Assuming you want the first item in the list
          totalscore = cLeaderboard_model!.totalScore;
          UserId = cLeaderboard_model!.userId;
          // Use forEach to iterate over the list
          value.forEach((item) {
            Total.add(totalscore!);
            User.add(UserId!);
            print("TotalController");
            print(item.totalScore); // Accessing each item's totalScore
          });
          print(totalscore);
          print("totalscore");
        });
      } else {
        toastMessage(context, "Something went wrong", Colors.red);
      }
      isLoading = false;
      setState(() {});
    });
  }

  // LeaderBoardAPI() async {
  //   isLoading = true;
  //   setState(() {});
  //   ApiServices().leaderboard().then((List<Leaderboard_model> value) {
  //     if (value.isNotEmpty) {
  //       setState(() {
  //         // Clear previous data
  //         TotalController.clear();
  //         UserController.clear();
  //
  //         // Populate UI data for each item in the list
  //         value.forEach((item) {
  //           TotalController.add(TextEditingController());
  //           UserController.add(TextEditingController());
  //         });
  //       });
  //     } else {
  //       toastMessage(context, "Something went wrong", Colors.red);
  //     }
  //     isLoading = false;
  //     setState(() {});
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Leaderboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xFF434B90),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rank",style: TextStyle(
                        fontSize: 16,color: Colors.white
                    ),),
                    Text("Student",style: TextStyle(
                        fontSize: 16,color: Colors.white
                    ),),
                    Text("Score",style: TextStyle(
                        fontSize: 16,color: Colors.white
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: totalscore != null ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Total?.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("length");
                      var score = Total![index];
                      var id = User![index];
                      var overimage = imagelist![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal:0,vertical:6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            index < 3 ?  ClipOval(
                              child: Image.asset(imagelist![index],
                                height:35,
                                width: 35,
                              ),
                            ) : ClipOval(
                              child: Container(
                                height:35,
                                width: 35,
                              ),
                            ),
                        SizedBox(width: 5,),
                            Text("${id!}",style: TextStyle(color: Colors.white),),
                          SizedBox(width: 40,),
                            Text("${score}",style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      );

                      // return Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //           "${TotalController}",
                      //           style: TextStyle(color: Colors.white,fontSize: 16)),
                      //       Text("${totalscore}",
                      //           style: TextStyle(color: Colors.white,fontSize: 16)),
                      //       Text("${totalscore}",
                      //           style: TextStyle(color: Colors.white,fontSize: 16)),
                      //     ],
                      //   ),
                      // );
                    },
                  ),
                ) :
                Center(child: Text("No Data Available",style: TextStyle(fontSize: 20,color: Colors.white),))
                ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
