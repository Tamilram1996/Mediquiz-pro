import 'dart:async';
import 'package:flutter/material.dart';
import '../../Utils/utils.dart';
import 'Login/MainLogin_Screen.dart';

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
    Timer(Duration(seconds: 2), () => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainLogin_Screen(),
      ),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
