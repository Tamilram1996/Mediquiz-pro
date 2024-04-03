import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/Profile_Model.dart';

import '../../API_services/Api_Services.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';
import 'Edit_DoctorProfile.dart';
String? userid;
Data? Datas;
class Doctor_Profile extends StatefulWidget {
  const Doctor_Profile({super.key});

  @override
  State<Doctor_Profile> createState() => _Doctor_ProfileState();
}

class _Doctor_ProfileState extends State<Doctor_Profile> {

  bool isLoading = true;
  TextEditingController Useridcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController instituecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  Profile_Model? cProfile_Model;
  File? _selectedFileImage;
  String? _selectedImage;

  @override
  void initState() {
    super.initState();
    bioIdFunction();
  }
  void bioIdFunction() async{
    isLoading =true;
    setState(() {
    });
    userid = await Getuserid();
    print("bioIdValue");
    Useridcontroller.text = userid.toString();
    print(Useridcontroller.text);
    print(userid);
    setState(() {
      isLoading = false;
    });
    ProfileMain(userid);
  }

  ProfileMain(userid) async {
    isLoading = true;
    setState(() {
    });
    ApiServices().Profile(userid).then((value) {
      if (value != null &&
          (value!.status! == true)) {
        print("login");
        print(value);
        cProfile_Model = value;
        Datas = cProfile_Model!.data;
        _selectedImage = cProfile_Model!.data!.profilePhoto!.toString();
            namecontroller.text =  cProfile_Model!.data!.name.toString() ;
        mobilecontroller.text =  cProfile_Model!.data!.phoneNo.toString() ;
        emailcontroller.text =  cProfile_Model!.data!.emailId.toString() ;
        instituecontroller.text =  cProfile_Model!.data!.institution.toString() ;
        designationcontroller.text =  cProfile_Model!.data!.designation.toString() ;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: isLoading ==true ? loaderWidget() : Column(
        children: [
          SizedBox(height: 100,),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black38, // Change color as needed// Change color as needed
                width: 4, // Change border width as needed
              ),
            ),
            child: _selectedFileImage != null
                ? CircleAvatar(
              radius: 65,
              backgroundImage: FileImage(_selectedFileImage!),
            )
                : _selectedImage != null && _selectedImage!.isNotEmpty
                ? CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(_selectedImage!),
            )
                : CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage('assets/image 22.png'),
            ),
          ),

          // ClipOval(
          //  child: Image.network(_selectedImage),
          // ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: namecontroller,
              readOnly: true,
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
          SizedBox(height: 20,),
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
          SizedBox(height: 20,),
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
        ],
      ),
      bottomSheet:Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
          child: Text(
            "Edit Account",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Edit_DoctorProfile(data:Datas),
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
}
