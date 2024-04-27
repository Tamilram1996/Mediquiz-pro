import 'package:flutter/material.dart';
import 'package:mediquizpro/UI/Login/Doctor_Login.dart';
import '../../Utils/utils.dart';
import 'Student_Login.dart';

class MainLogin_Screen extends StatefulWidget {
  const MainLogin_Screen({super.key});

  @override
  State<MainLogin_Screen> createState() => _MainLogin_ScreenState();
}
class _MainLogin_ScreenState extends State<MainLogin_Screen> {
  late AnimationController _controller;
  bool isLoading = true;
  List<String>? loginlist=["Student Login","Doctor Login"];


  @override
  void initState() {
    super.initState();
    RotatingImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(child:
          RotatingImage()),
          // SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: loginlist!.length,
              itemBuilder: (BuildContext context, int index) {
                var list = loginlist![index];
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(loginlist![index] == "Student Login") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Student_Login(
                                      title: list,
                                    ),
                              ),
                            );
                          }
                          else if(loginlist![index] == "Doctor Login"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Doctor_Login(
                                      title: list,
                                    ),
                              ),
                            );
                          }
                          else{
                            toastMessage(context, "Error", Colors.red);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
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
    );
  }
}