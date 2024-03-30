import 'package:flutter/material.dart';
import 'package:mediquizpro/UI/Student/Casestudy_screen.dart';
import 'package:mediquizpro/UI/Student/answer_screen.dart';

class Pathology_Screen extends StatefulWidget {
  const Pathology_Screen({super.key});

  @override
  State<Pathology_Screen> createState() => _Pathology_ScreenState();
}

class _Pathology_ScreenState extends State<Pathology_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset("assets/Start-removebg-preview 1.png")
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
          child: Text(
            "Start",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Casestudy_screen2()
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF434B90),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            // backgroundColor: Color(0xFF434B90),
          ),
        ),
      ),
    );
  }
}
