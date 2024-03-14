import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text("Sign UP")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipOval(
              child: Center(child: Image.asset("assets/image 20.png")),
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
            SizedBox(
              height: 20,
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
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 20,
            ),
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
            SizedBox(height: 20,),
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
              child: TextField(
                controller: designationcontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Designation',
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
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16),
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Creategroup()),
            // );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero),
            // backgroundColor: Color(0xFF434B90),
          ),
        ),
      ),
    );
  }
}
