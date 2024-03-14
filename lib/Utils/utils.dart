import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget loaderWidget() {
  AnimationController _controller = AnimationController(
    vsync: AnimatedTickerProvider(),
    duration: Duration(seconds: 1), // You can adjust the duration as needed
  )..repeat();

  return Center(
    child: AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.14, // 2.0 * 3.14 represents a full rotation
          child: Container(
            height: 120,
            width: 120,
            child: ClipOval(
                child: Image.asset("assets/image 20.png")),
          ),
        );
      },
    ),
  );
}

class RotatingImage extends StatefulWidget {
  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
    AnimationController(vsync: this, duration: Duration(minutes:10))
      ..repeat(); // repeat the animation infinitely
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 6.0 * 3.1415926535897932, // Angle is in radians, thus 2*pi
            child: child,
          );
        },
        child: Center(
          child: Image.asset("assets/image 20.png"),
        ),
      ),
    );
  }
}
class AnimatedTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'ticker');
  }
}

Future<String> fileToBase64(String filePath) async {
  File file = File(filePath);
  List<int> imageBytes = await file.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}
void toastMessage(BuildContext context, String msg, Color color) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: color,
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check,
          color: Colors.white,
        ),
        SizedBox(width: 12.0),
        Expanded(
            child: Text(
              msg,
              style: TextStyle(color: Colors.white),
            ))
      ],
    ),
  );
  return fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 4),
      gravity: ToastGravity.TOP);
}

