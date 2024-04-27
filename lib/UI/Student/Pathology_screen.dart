import 'package:flutter/material.dart';
import 'package:mediquizpro/UI/Student/answer_screen.dart';
import '../../API_services/Api_Services.dart';
import '../../Model/TestMessageModel.dart';
import '../../Utils/base.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';

class Pathology_Screen extends StatefulWidget {
  const Pathology_Screen({super.key});

  @override
  State<Pathology_Screen> createState() => _Pathology_ScreenState();
}

class _Pathology_ScreenState extends State<Pathology_Screen> {

  bool isLoading = true;
  TestMessageModel? cTestMessageModel;
  TextEditingController Useridcontroller = TextEditingController();


  @override
  void initState() {
    super.initState();
    bioIdFunction();
  }

  void bioIdFunction() async {
    setState(() {});
    isLoading = true;
    userid = await Getuserid();
    Useridcontroller.text = userid.toString();
    print("edituserid");
    print(userid);
    print(Useridcontroller.text);

    setState(() {
      isLoading = false;
    });
  }

  TestMainAPI(Useridcontroller) async {
    isLoading = true;
    setState(() {});
    try {
      ApiServices().testmessager(Useridcontroller.text).then((value) {
        if (value != null && (value.status == 0)) {
          print("login");
          print(value);
          cTestMessageModel = value;
          print("over");
          // toastMessage(context, value.status!.toString(), Colors.green);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Casestudy_screen2()
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Stack(
                children: [
                  // Modal barrier to prevent interactions with widgets behind the dialog
                  ModalBarrier(
                    dismissible: false,
                    color: Colors.black54,
                  ),
                  Theme(
                    data: ThemeData.light().copyWith(
                      dialogBackgroundColor: Colors.grey.shade200,
                    ),
                    child: AlertDialog(
                      title: Text(
                        "Not Allowed : Userid -${userid}",
                        style: TextStyle(fontSize: Base.titlefont),
                      ),
                      content: Text("User ID is already exist in the \ndatabase"),
                      actions: [
                        TextButton(
                          child: Text(
                            'OK',
                            style: TextStyle(color:Color(0xFF434B90)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
          toastMessage(context, "User ID is already in the database", Colors.red);
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
            TestMainAPI(Useridcontroller);
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
