import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';


Widget loaderWidget() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      backgroundColor: Colors.lightBlueAccent,
    ),
  );
}
// Widget loaderWidget() {
//   return Center(
//     child: Container(
//         height: 150,
//         width: 150,
//         child: Lottie.asset("asset/fruitwalk.json")),
//     // child: CircularProgressIndicator(
//     //   color: Colors.blue,
//     // ),
//   );
// }



class RotatingImage extends StatefulWidget {
  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10), // Set duration to 10 seconds for example
    )..repeat(); // repeat the animation infinitely
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
          child: ClipOval(child: Image.asset("assets/image 20.png")),
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
      toastDuration: Duration(seconds: 3),
      gravity: ToastGravity.TOP);
}


