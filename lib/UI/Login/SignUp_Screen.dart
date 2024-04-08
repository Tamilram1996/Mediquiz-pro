import 'package:flutter/material.dart';

import '../../API_services/Api_Services.dart';
import '../../Model/Sigup_model.dart';
import '../../Utils/base.dart';
import '../../Utils/utils.dart';

class SignUp_screen extends StatefulWidget {
  const SignUp_screen({super.key});

  @override
  State<SignUp_screen> createState() => _SignUp_screenState();
}

class _SignUp_screenState extends State<SignUp_screen> {
  TextEditingController Useridcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController instituecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  TextEditingController createpasswordcontroller = TextEditingController();
  TextEditingController recreatepasswordcontroller = TextEditingController();
  bool isLoading = true;
  Sigup_Model? cSigup_Model;
  List<String>? Designationlist = ["Student", "Doctor"];

  @override
  void initState() {
    super.initState();
  }

  Signupmain() {
    isLoading = true;
    setState(() {});
    ApiServices()
        .signup(
      Useridcontroller.text,
      namecontroller.text,
      mobilecontroller.text,
      emailcontroller.text,
      instituecontroller.text,
      designationcontroller.text,
      createpasswordcontroller.text,
      recreatepasswordcontroller.text,
    )
        .then((value) {
      if (value != null && (value!.status! == true)) {
        print("login");
        print(value);
        cSigup_Model = value;
        print("object");
      } else {
        // toastMessage(context, value!.message!.toString(), Colors.red);
        toastMessage(context, "Something went wrong", Colors.red);
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
          title: Text("Sign UP")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipOval(
              child: RotatingImage(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: Useridcontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'User Id',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Name',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: mobilecontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Mobile No',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Email',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: instituecontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Institution',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Text(
                              'Select Designation',
                              style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: Base.titlefont),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors.red,
                                  )),
                            ),
                          ],
                        ),
                        content: Container(
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: Designationlist?.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = Designationlist![index];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    designationcontroller.text =
                                        Designationlist![index]!;
                                    // print("selected ID:"+_selectedId.toString());
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        child: Text(
                                          "${Designationlist![index]}",
                                          style: TextStyle(
                                              fontSize: Base.subdetailfont),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Divider(thickness: 1),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: TextField(
                  controller: designationcontroller,
                  enabled: false,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.arrow_drop_down_circle),
                    hintText: 'Designation',
                    // labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: createpasswordcontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Create New Password',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: recreatepasswordcontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Re-Enter Password',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
          child: Text(
            "Create Account",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            print(
              Useridcontroller.text,
            );
            print(
              namecontroller.text,
            );
            print(
              mobilecontroller.text,
            );
            print(
              emailcontroller.text,
            );
            print(
              instituecontroller.text,
            );
            print(
              designationcontroller.text,
            );
            print(
              createpasswordcontroller.text,
            );
            print(
              recreatepasswordcontroller.text,
            );
            Signupmain();
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
