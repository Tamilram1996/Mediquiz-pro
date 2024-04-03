import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/Totalscore_model.dart';
import 'package:mediquizpro/UI/Student/Congartulation_screen.dart';
import '../../API_services/Api_Services.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';

String? userid;
String? Correctanswer;
String? Wronganswer;
class Totalscore_Mainscreen extends StatefulWidget {
  const Totalscore_Mainscreen({Key? key}) : super(key: key);

  @override
  State<Totalscore_Mainscreen> createState() => _Totalscore_MainscreenState();
}

class _Totalscore_MainscreenState extends State<Totalscore_Mainscreen> {
  bool isLoading = true;
  Totalscore_Model? cTotalscore_Model;
  TextEditingController Useridcontroller = TextEditingController();
  dynamic present = 20;
  String? Correctanswer;
  String? Wronganswer;

  @override
  void initState() {
    super.initState();
    bioIdFunction();
  }

  void bioIdFunction() async {
    isLoading = true;
    setState(() {});
    userid = await Getuserid();
    Useridcontroller.text = userid.toString();
    print("edituserid");
    print(userid);
    print(Useridcontroller.text);
    TotalscoreMainAPI(Useridcontroller);
    setState(() {
      isLoading = false;
    });
  }

  TotalscoreMainAPI(Useridcontroller) async {
    isLoading = true;
    setState(() {});
    ApiServices().totalscores(Useridcontroller.text).then((value) {
      if (value != null && (value.status! == "success")) {
        print("login");
        print(value);
        cTotalscore_Model = value;
        Correctanswer = cTotalscore_Model!.totalScore.toString();
        Wronganswer = cTotalscore_Model!.totalWrong.toString();
        print(Correctanswer);
        print("over");
        toastMessage(context, value.status!.toString(), Colors.green);
      } else {
        toastMessage(context, "Something Went Wrong", Colors.red);
        print("ghegt");
      }
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Total Score"),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularProgressWithLabel(0.4),
          CircularProgressWithLabel(0.6),
          // CircularProgresser(20),
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
          child: Text(
            "Next",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            print("Congratulation_screen");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Congratulation_screen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Color(0xFF434B90),
          ),
        ),
      ),
    );
  }
}

// class CircularProgressWithLabel extends StatelessWidget {
//   final double value;
//
//   const CircularProgressWithLabel(this.value);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Center(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height / 3.6,
//             width: MediaQuery.of(context).size.width / 1.75,
//             child: CircularProgressIndicator(
//               value: value,
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//               backgroundColor: Colors.red,
//               strokeWidth:25,
//             ),
//           ),
//         ),
//         Text(
//           '${(value * 100).toInt()}%',
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }

class CircularProgressWithLabel extends StatefulWidget {
  final double value;

  const CircularProgressWithLabel(this.value);

  @override
  _CircularProgressWithLabelState createState() =>
      _CircularProgressWithLabelState();
}

class _CircularProgressWithLabelState extends State<CircularProgressWithLabel>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation =
    Tween<double>(begin: 0, end: widget.value).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3.6,
            width: MediaQuery.of(context).size.width / 1.75,
            child: CircularProgressIndicator(
              value: _animation.value,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: Colors.red,
              strokeWidth: 25,
            ),
          ),
        ),
        Text(
          '${(_animation.value * 10).toInt()}%',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}