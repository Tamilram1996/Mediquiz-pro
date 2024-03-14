import 'package:flutter/material.dart';
import 'package:mediquizpro/API_services/Api_Services.dart';
import 'package:mediquizpro/Model/Login_Model.dart';
import '../../Utils/utils.dart';
import 'SignUp_Screen.dart';
import 'Student_Login.dart';

class Doctor_Login extends StatefulWidget {
  const Doctor_Login({super.key});

  @override
  State<Doctor_Login> createState() => _Doctor_LoginState();
}

class _Doctor_LoginState extends State<Doctor_Login> {
  TextEditingController Usernamecontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();
  bool isLoading = true;
 Login_Model? cLogin_Model;
  Data? datalist;


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
        Data? datalist;

        if(cLogin_Model!.data!.designation == "Student") {
          // Navigator.of(context).push(MaterialPageRoute(
          //   // builder: (context) => Admin_Mainscreen()));
          //     builder: (context) => ()));
        }
        if(cLogin_Model!.data!.designation == "Doctor") {
          // Navigator.of(context).push(MaterialPageRoute(
          //   // builder: (context) => Admin_Mainscreen()));
          //     builder: (context) => ()));
        }

        toastMessage(context, value!.message!.toString(), Colors.red);

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
          mainAxisAlignment: MainAxisAlignment.start,
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
        Text("Doctor Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
          // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
          hintText: 'Password',
          // labelStyle: TextStyle(color: Colors.white),
        ),
            ),
          ),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Adjust the value as needed
                ),
              ),
              onPressed: () {
                print(Usernamecontroller.text);
                print(Passwordcontroller.text);
                print("TEXT");
                ApiServices().login(Usernamecontroller.text,Passwordcontroller.text).then((value) {
                  if (value != null &&
                      (value!.status! == true)) {
                    print("login");
                    print(value);
                    cLogin_Model = value;


                    // Navigator.of(context).push(MaterialPageRoute(
                    //   // builder: (context) => Admin_Mainscreen()));
                    //     builder: (context) => ()));

                    toastMessage(context, value!.message!.toString(), Colors.green);

                  }
                  else {
                    toastMessage(context, value!.message!.toString(), Colors.red);
                  }
                  isLoading = false;
                  setState(() {
                  });
                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => Student_Login()
                //   ),
                // );
              },
              child: Text('Login'),
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width/2.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Adjust the value as needed
                ),
              ),
              onPressed: () {
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
