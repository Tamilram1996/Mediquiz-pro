import 'package:flutter/material.dart';
import 'package:mediquizpro/UI/Student/Student_Dashboard.dart';

class Congratulation_screen extends StatefulWidget {
  const Congratulation_screen({super.key});

  @override
  State<Congratulation_screen> createState() => _Congratulation_screenState();
}

class _Congratulation_screenState extends State<Congratulation_screen> {
  // GlobalKey<NavigatorState> _yourKey = GlobalKey<NavigatorState>();
  // _backPressed(GlobalKey<NavigatorState> _yourKey) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => Student_Dashboard()),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/image 18.png"),
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 45,
        child: ElevatedButton(
          child: Text(
            "Continue",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Student_Dashboard(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Color(0xFF434B90),
          ),
        ),
      ),
    );
  }
}
