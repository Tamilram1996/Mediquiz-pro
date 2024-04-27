import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mediquizpro/API_services/Api_Services.dart';
import 'package:mediquizpro/Model/EditDoctorProfile_Model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediquizpro/UI/Doctor/Doctor_Profile.dart';
import '../../Model/Profile_Model.dart';
import '../../Model/profilephotoModel.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';

String? userid;
class Edit_DoctorProfile extends StatefulWidget {
  Data? data;
  Edit_DoctorProfile({super.key,this.data});

  @override
  State<Edit_DoctorProfile> createState() => _Edit_DoctorProfileState();
}

class _Edit_DoctorProfileState extends State<Edit_DoctorProfile> {

  bool isLoading = true;
  TextEditingController Useridcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController instituecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController re_passwordcontroller = TextEditingController();
  File? _selectedFileImage ;
  String? _selectedImage;
  EditDoctorProfile_Model? cEditDoctorProfile_Model;
  ProfilephotoModel? cProfilephotoModel;

  @override
  void initState() {
    super.initState();
    bioIdFunction();
  }

  void bioIdFunction() async {
    isLoading = true;
    setState(() {});
    userid = await Getuserid();
    userid = await getUserName();
    Useridcontroller.text = userid.toString();
    namecontroller.text = widget!.data!.name.toString();
    mobilecontroller.text = widget!.data!.phoneNo.toString();
    emailcontroller.text = widget!.data!.emailId.toString();
    instituecontroller.text = widget!.data!.institution.toString();
    designationcontroller.text = widget!.data!.designation.toString();
    passwordcontroller.text = widget!.data!.password.toString();
    re_passwordcontroller.text = widget!.data!.password.toString();
    _selectedImage = widget!.data!.profilePhoto.toString();
    // _selectedFileImage =

    print("edituserid");
    print(userid);
    setState(() {
      isLoading = false;
    });
  }
  void reloadProfilePage() {
    setState(() {
      isLoading = true; // Set isLoading to true to show the loader
    });
    bioIdFunction(); // Call the function to reload the profile data
  }


  EditprofileAPI() {
    isLoading = true;
    setState(() {
    });

    ApiServices().Editprofile(
      Useridcontroller.text,
      namecontroller.text,
      mobilecontroller.text,
      emailcontroller.text,
      instituecontroller.text,
      designationcontroller.text,
      passwordcontroller.text,
      re_passwordcontroller.text,
      _selectedFileImage, // Pass the File object directly
    ).then((value) {
      print(value);
      print("value");
      cEditDoctorProfile_Model = value;
      if (cEditDoctorProfile_Model?.status == "success") {
        setState(() {
          _selectedImage = _selectedImage; // Get the URL from the response
        });
        print("login");
        print(value);
        // Navigator.pop(context,true);
        // reloadProfilePage() ;//
        // Navigator.pop(context,true);
        // Navigator.pop(context,_selectedImage);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>Doctor_Profile(),
          ),
        );
        // Navigator.pop(context,true);
        toastMessage(context, "User information updated successfully", Colors.green);
      } else {
        print("value");
        print(value.toString());
        toastMessage(context, "Something went wrong", Colors.red);
      }
      isLoading = false;
      setState(() {
      });
    });
  }

  // Photomain() {
  //   isLoading = true;
  //   setState(() {
  //   });
  //   ApiServices()
  //       .photoupload(
  //     Useridcontroller.text,
  //     _selectedFileImage,
  //   )
  //       .then((value) {
  //     if (value != null && (value!.status! == "success")) {
  //       print("login");
  //       print(value);
  //       cProfilephotoModel = value;
  //       print("object");
  //       toastMessage(context,value.message.toString() , Colors.green);
  //     } else {
  //       // toastMessage(context, value!.message!.toString(), Colors.red);
  //       toastMessage(context, "Something went wrong", Colors.red);
  //     }
  //     isLoading = false;
  //     setState(() {});
  //   });
  // }
  // Photomain() {
  //   isLoading = true;
  //   setState(() {});
  //   ApiServices()
  //       .photoupload(
  //     Useridcontroller.text,
  //     _selectedFileImage,
  //   )
  //       .then((value) {
  //     if (value != null && (value.status! == "success")) {
  //       print("login");
  //       print(value);
  //       cProfilephotoModel = value;
  //       print("object");
  //       toastMessage(context, value.message.toString(), Colors.green);
  //     } else {
  //       // toastMessage(context, value.message.toString(), Colors.red);
  //       toastMessage(context, "Something went wrong", Colors.red);
  //     }
  //     isLoading = false;
  //     setState(() {});
  //   }).catchError((error) {
  //     print("Error in photo upload: $error");
  //     // Handle the error case appropriately
  //     isLoading = false;
  //     setState(() {});
  //   });
  // }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black38, // Change color as needed// Change color as needed
                      width: 4, // Change border width as needed
                    ),
                  ),
                  child: _selectedFileImage != null ? CircleAvatar(
                    radius: 65, backgroundImage: FileImage(_selectedFileImage!),) :
                  _selectedImage != null && _selectedImage!.isNotEmpty
                      ? CircleAvatar(radius: 65,
                      backgroundImage: NetworkImage(_selectedImage!))
                      : CircleAvatar(radius: 65,
                      backgroundImage: AssetImage('assets/image 22.png')),
                ),
                // ClipOval(
                //     child: Image.asset("assets/image 22.png"),
                //   ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: FloatingActionButton(
                      onPressed: () {
                        _showImagePickerDialog();
                      },
                      child: Icon(Icons.edit),
                    ),
                  ),
                ),
              ],
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
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Enter the Password',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: re_passwordcontroller,
                decoration: InputDecoration(
                  // suffixIcon:Icon(Icons.cancel_outlined,color: Colors.blue.shade800),
                  hintText: 'Re-Enter the password',
                  // labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 60,),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 45,
        child: ElevatedButton(
          child: Text(
            "Save",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            if (Useridcontroller.text.isEmpty) {
              toastMessage(context, "User-id empty", Colors.red);
            }
            else if (namecontroller.text.isEmpty) {
              toastMessage(context, "Enter the name", Colors.red);
            }
            else if (mobilecontroller.text.isEmpty) {
              toastMessage(context, "Enter the Mobilenumber", Colors.red);
            }
            else if (emailcontroller.text.isEmpty) {
              toastMessage(context, "Enter the Email", Colors.red);
            }
            else if (instituecontroller.text.isEmpty) {
              toastMessage(context, "Enter the insitute name", Colors.red);
            } else if (designationcontroller.text.isEmpty) {
              toastMessage(context, "Enter the your designation", Colors.red);
            }
            else if (passwordcontroller.text.isEmpty) {
              toastMessage(context, "Enter the password", Colors.red);
            }
            else if (re_passwordcontroller.text.isEmpty) {
              toastMessage(context, "Enter the re_password", Colors.red);
            }
            else {
              print("Total");
              print(Useridcontroller.text);
              print(namecontroller.text);
              print(emailcontroller.text);
              print(mobilecontroller.text);
              print(instituecontroller.text);
              print(designationcontroller.text);
              print(passwordcontroller.text);
              print(re_passwordcontroller.text);
              print(_selectedFileImage);
              print("Total");
              EditprofileAPI();
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Color(0xFF434B90),
          ),
        ),
      ),
    );
  }


  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source, imageQuality: 50);
    if (pickedImage != null) {
      setState(() {
        _selectedFileImage = File(pickedImage.path);
        _selectedImage = pickedImage.path; // Store image path for network image
      });
    }
  }
}