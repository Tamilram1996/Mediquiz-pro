import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/Totalscore_model.dart';
import 'package:mediquizpro/UI/Student/Congartulation_screen.dart';
import 'package:mediquizpro/UI/Student/DrawerReview_screen.dart';
import '../../API_services/Api_Services.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';
import 'Reviewscreen.dart';

String? userid;
String? Correctanswer;
String? Wronganswer;
class Totalscore_Mainscreen extends StatefulWidget {
  const Totalscore_Mainscreen({Key? key}) : super(key: key);

  @override
  State<Totalscore_Mainscreen> createState() => _Totalscore_MainscreenState();
}

class _Totalscore_MainscreenState extends State<Totalscore_Mainscreen> with TickerProviderStateMixin{
  bool isLoading = true;
  TotalscoreModel? cTotalscore_Model;
  TextEditingController Useridcontroller = TextEditingController();
  dynamic present = 20;
  double? Correctanswer;
  dynamic? Wronganswer;
  dynamic? Totalquestion;
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  double? correctRatio;
  double? TotalRatio;
  double? wrongRatio;

  @override
  void initState() {
    super.initState();
    bioIdFunction();
    print(Totalquestion);
  }

  void bioIdFunction() async {
    setState(() {});
    isLoading = true;
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
    try {
      ApiServices().totalscores(Useridcontroller.text).then((value) {
        if (value != null && (value.status! == "success")) {
          print("login");
          print(value);
          cTotalscore_Model = value;
          Correctanswer = double.tryParse(cTotalscore_Model!.totalScore.toString());
          Wronganswer = double.tryParse(cTotalscore_Model!.totalWrong.toString());
          Totalquestion = double.tryParse(cTotalscore_Model!.totalQuestion.toString());
          TotalRatio = Totalquestion!.toInt().toDouble();
          correctRatio = Correctanswer!.toInt().toDouble();
          wrongRatio = Wronganswer!.toInt().toDouble();
          print(TotalRatio);
          print(correctRatio);
          print(wrongRatio);
          correctanimation();
          // wronganimation2();
          _animationController2 = AnimationController(
            vsync: this,
            duration: Duration(seconds: 2), // Adjust duration as needed
          );
          _animation2 = Tween<double>(
            begin: 0.0,
            end: wrongRatio!.toDouble() / TotalRatio!.toDouble(),
          ).animate(_animationController2)
            ..addListener(() {
              setState(() {});
            });
          _animationController2.forward();
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
    catch (e) {}
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
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Reviewscreen(),
                ),
              );
            },
            child: Text("Review",
            style: TextStyle(color: Color(0xFF434B90)),
            ),
          )
        ],
      ),
      body: Totalquestion ==null ? loaderWidget() : Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 60,),
          _buildStackForCorrectAnswer(),
          SizedBox(height: 10,),
          Text(
            'Correct Answer',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 60,),
          _buildStackForWrongAnswer(),
          SizedBox(height: 10,),
          Text(
            'Wrong Answer',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 90,),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Color(0xFF434B90),
          ),
        ),
      ),
    );
  }

  Widget _buildStackForCorrectAnswer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height /4.5,
            width: MediaQuery.of(context).size.width / 2.25,
            child: CircularProgressIndicator(
              value: _animation.value,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // Change color to green for correct answer
              strokeWidth: 25,
            ),
          ),
        ),
        Text(
          '${_animation.value * 100}%',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStackForWrongAnswer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 4.5,
            width: MediaQuery.of(context).size.width / 2.25,
            child: CircularProgressIndicator(
              value: _animation2.value,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red), // Change color to red for wrong answer
              strokeWidth: 25,
            ),
          ),
        ),
        Text(
          '${_animation2.value * 100}%',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void correctanimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust duration as needed
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: correctRatio!.toDouble() / TotalRatio!.toDouble(),
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  void wronganimation2() {
    _animationController2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust duration as needed
    );
    _animation2 = Tween<double>(
      begin: 0.0,
      end: wrongRatio!.toDouble() / TotalRatio!.toDouble(),
    ).animate(_animationController2)
      ..addListener(() {
        setState(() {});
      });
    _animationController2.forward();
  }
}
