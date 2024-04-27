import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/Profile_Model.dart';
import 'package:mediquizpro/UI/Doctor/Doctor_Dashboard.dart';
import 'package:mediquizpro/UI/Student/Student_Dashboard.dart';
import '../../API_services/Api_Services.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';
import 'Edit_DoctorProfile.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
  String? _selectedImage="";

  @override
  void initState() {
    super.initState();
    _selectedImage="";
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
    await DefaultCacheManager().removeFile("fluttercampus");
    isLoading = true;

    setState(() {
    });
    ApiServices().Profile(userid).then((value) async{
      if (value != null &&
          (value!.status! == true)) {
        print("login");
        print(value);
        cProfile_Model = value;
        setState(() {
          _selectedImage=null;
        });
        Datas = cProfile_Model!.data;
        await CachedNetworkImage.evictFromCache(cProfile_Model!.data!.profilePhoto!.toString());
        _selectedImage = cProfile_Model!.data!.profilePhoto!.toString();
        print("_selectedImage");
        print("image:::::${_selectedImage}");
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

  GlobalKey<NavigatorState> _yourKey = GlobalKey<NavigatorState>();
  _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Doctor_Profile()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() => _backPressed(_yourKey),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile"),
          leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
              // Navigator.pop(context);
              if(designationcontroller.text == "Student"){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>Student_Dashboard(),
                  ),
                );
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>Doctor_Dashboard(),
                  ),
                );
              }

            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            Row(
              children: [
                Text("Userid:${userid}"),
                SizedBox(width: 20,)
              ],
            )
          ],
        ),
        body: isLoading ==true ? loaderWidget() : SingleChildScrollView(
          child: Column(
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
                child:_selectedImage != null && _selectedImage!.isNotEmpty
                    ? CircleAvatar(radius: 65,
                    backgroundImage: NetworkImage(_selectedImage!))
                    : CircleAvatar(radius: 65,
                  backgroundImage: AssetImage('assets/image 22.png'),
                ),
              ),
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
                  readOnly: true,
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
                  readOnly: true,
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
                  readOnly: true,
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
                  readOnly: true,
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
                  builder: (context) =>Edit_DoctorProfile(data:Datas),
                ),
              );
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => Edit_DoctorProfile(data:Datas),
              // ),
              // ).then((_selectedimage) async {
              //           if (_selectedimage != null) {
              //             bioIdFunction();
              //             ProfileMain(userid);
              //             // try{
              //             //   isLoading =true;
              //             //   setState(() {
              //             //   });
              //             //   ApiServices().Profile(userid).then((value) {
              //             //     if (value != null &&
              //             //         (value!.status! == true)) {
              //             //       print("login");
              //             //       print(value);
              //             //       cProfile_Model = value;
              //             //       Datas = cProfile_Model!.data;
              //             //       // _selectedImage = cProfile_Model!.data!.profilePhoto!.toString();
              //             //       _selectedImage =_selectedimage;
              //             //       namecontroller.text =  cProfile_Model!.data!.name.toString() ;
              //             //       mobilecontroller.text =  cProfile_Model!.data!.phoneNo.toString() ;
              //             //       emailcontroller.text =  cProfile_Model!.data!.emailId.toString() ;
              //             //       instituecontroller.text =  cProfile_Model!.data!.institution.toString() ;
              //             //       designationcontroller.text =  cProfile_Model!.data!.designation.toString() ;
              //             //       toastMessage(context, value!.message!.toString(), Colors.green);
              //             //     }
              //             //     else {
              //             //       toastMessage(context, value!.message!.toString(), Colors.red);
              //             //     }
              //             //     isLoading = false;
              //             //     setState(() {
              //             //     });
              //             //   });
              //             // }
              //             // catch(e){
              //             //   print(e);
              //             // }
              //           }
              //           else{
              //             toastMessage(context, "Not Refresh", Colors.red);
              //           }
              //         });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: Color(0xFF434B90),
            ),
          ),
        ),
      ),
    );
  }
}
