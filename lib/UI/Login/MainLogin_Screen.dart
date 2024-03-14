import 'package:flutter/material.dart';
import '../../Utils/utils.dart';
import 'Login_screen.dart';

class MainLogin_Screen extends StatefulWidget {
  const MainLogin_Screen({super.key});

  @override
  State<MainLogin_Screen> createState() => _MainLogin_ScreenState();
}


class _MainLogin_ScreenState extends State<MainLogin_Screen> {
  late AnimationController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ClipOval(
          //   child: Center(
          //       child: Image.asset("assets/image 20.png")),
          // ),
          ClipOval(child: RotatingImage()),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              // Doctor_Login
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Doctor_Login()),
              );
            },
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the radius value for the desired curvature
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                height: 65,
                width: MediaQuery.of(context).size.width / 2,
                child: Center(child: Text("Doctor Login")),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Student_Login()),
                );
              },
              child: Card(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    // Adjust the radius value for the desired curvature
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 65,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(child: Text("Student Login")),
                ),
              )),
          // Text("Student Login"),
        ],
      ),
    );
  }
}
