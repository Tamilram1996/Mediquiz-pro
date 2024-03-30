import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mediquizpro/UI/Doctor/Doctor_Dashboard.dart';
import 'package:mediquizpro/UI/Student/Student_Dashboard.dart';
import 'Login/MainLogin_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: 3),
  //   );
  //   _animation = Tween(begin: 0.0, end: 2 * 3.14).animate(_controller)
  //     ..addListener(() {
  //       setState(() {});
  //     });
  //   _controller.repeat();
  //   Timer(Duration(seconds: 2), () => Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MainLogin_Screen(),
  //     ),
  //   ));
  // }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween(begin: 0.0, end: 2 * 3.14).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
    // Check authentication status after a delay
    Timer(Duration(seconds: 2), () => checkAuthentication());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String authToken = prefs.getString('token') ?? '';
    String userName = prefs.getString('userName') ?? '';
    String password = prefs.getString('Password') ?? '';

    if (userName.isNotEmpty && password.isNotEmpty) {
      // If token and user data exist, navigate to respective dashboard
      if (isDoctorUser()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Doctor_Dashboard(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Student_Dashboard(),
          ),
        );
      }
    } else {
      // If token or user data is missing, navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainLogin_Screen(),
        ),
      );
    }
  }

  bool isDoctorUser() {
    // Implement your logic to determine if the user is a doctor or not
    // For example, you can check if the user's role is 'doctor' in your backend
    // Return true if the user is a doctor, false otherwise
    return false; // Placeholder, replace with actual logic
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: _animation.value,
            child: Image.asset(
              "assets/image 20.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}
