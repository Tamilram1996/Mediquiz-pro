import 'package:flutter/material.dart';
import 'package:mediquizpro/API_services/Api_Services.dart';
import 'package:mediquizpro/Model/Login_Model.dart';
import 'package:mediquizpro/Utils/shared_preference.dart';
import '../../Utils/utils.dart';
import '../Doctor/Doctor_Dashboard.dart';
import '../Student/Student_Dashboard.dart';
import 'SignUp_Screen.dart';

class Doctor_Login extends StatefulWidget {
  String? title;
  Doctor_Login({super.key,this.title });

  @override
  State<Doctor_Login> createState() => _Doctor_LoginState();
}

class _Doctor_LoginState extends State<Doctor_Login> {
  TextEditingController Usernamecontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();
  bool isLoading = true;
  Login_Model? cLogin_Model;
  Data? datalist;
  String? designation;

  @override
  void initState() {
    super.initState();
  }

  Loginmain() {
    isLoading = true;
    setState(() {
    });
    ApiServices().login(Usernamecontroller.text,Passwordcontroller.text).then((value) {
      if (value != null &&
          (value!.status! == true)) {
        print("login");
        print(value);
        cLogin_Model = value;
        setUserName(Usernamecontroller.text.toString(),Passwordcontroller.text.toString());
        Setuser(Usernamecontroller.text.toString());
        designation = cLogin_Model!.data!.designation;
        print(Setuser);
        print("object");
        print(designation);
        if(cLogin_Model!.data!.designation == "Student") {
          toastMessage(context, "Use Doctor id to login", Colors.red);
        }
        else if(cLogin_Model!.data!.designation == "Doctor") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Doctor_Dashboard(),
            ),
          );
        }
      }
      else {
        toastMessage(context, value!.message!.toString(), Colors.red);
      }
      isLoading = false;
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 25,
                    width: 25,
                    child: Image.asset("assets/image 20.png")),
                Text("WELCOME TO MEDIQUIZ PRO",style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height:MediaQuery.of(context).size.height/11),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${widget.title}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ],
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:40.0),
              child: TextField(
                controller: Usernamecontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Email or Phone',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:40.0),
              child: TextField(
                controller: Passwordcontroller,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 60,)
          ],
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width/2.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF434B90),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Adjust the value as needed
                ),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                print(Usernamecontroller.text);
                print(Passwordcontroller.text);
                print("TEXT");

                Loginmain();
              },
              child: Text('Login'),
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width/2.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF434B90),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Adjust the value as needed
                ),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUp_screen()
                  ),
                );
              },
              child: Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
