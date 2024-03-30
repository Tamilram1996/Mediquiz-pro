import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'Doctor_Profile.dart';

class Add_Question extends StatefulWidget {
  const Add_Question({super.key});

  @override
  State<Add_Question> createState() => _Add_QuestionState();
}

class _Add_QuestionState extends State<Add_Question> {

  File? _selectedFileImage;
  String? _selectedImage;
  TextEditingController casecontroller = TextEditingController();

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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Doctor_Profile(),
                  ),
                );
              },
              icon: Image.asset("assets/Male User-1.png"),
            ),
          ]
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Case Study"),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 70,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Adjust the value to change the roundness
                border: Border.all(
                  color: Colors.grey,
                  // You can set the color of the border here
                  width: 2, // You can adjust the width of the border here
                ),
              ),
              child: Text(""
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                _showImagePickerDialog();
              },
              child: Container(
                width: 100, // Adjust width according to your UI requirements
                height: 120, // Adjust height according to your UI requirements
                child: _selectedFileImage != null
                    ? Image.file(
                  _selectedFileImage!,
                  fit: BoxFit.cover, // Adjust the BoxFit as needed
                )
                    : _selectedImage != null && _selectedImage!.isNotEmpty
                    ? Image.network(
                  _selectedImage!,
                  fit: BoxFit.cover, // Adjust the BoxFit as needed
                )
                    : Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
              ),
            ),
              Row(
                children: [
                  Text("Question 1",style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Adjust the value to change the roundness
                border: Border.all(
                  color: Colors.grey,
                  // You can set the color of the border here
                  width: 2, // You can adjust the width of the border here
                ),
              ),
              child: Text(""),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Correct Answer",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 60,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Adjust the value to change the roundness
                border: Border.all(
                  color: Colors.grey,
                  // You can set the color of the border here
                  width: 2, // You can adjust the width of the border here
                ),
              ),
              child: Text(""),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Options",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Adjust the value to change the roundness
                border: Border.all(
                  color: Colors.grey,
                  // You can set the color of the border here
                  width: 2, // You can adjust the width of the border here
                ),
              ),
              child: Text(""),
            ),
            SizedBox(height: 10,),
            Container(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Adjust the value to change the roundness
                border: Border.all(
                  color: Colors.grey,
                  // You can set the color of the border here
                  width: 2, // You can adjust the width of the border here
                ),
              ),
              child: Text(""),
            ),
            SizedBox(height: 10,),
            Container(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Adjust the value to change the roundness
                border: Border.all(
                  color: Colors.grey,
                  // You can set the color of the border here
                  width: 2, // You can adjust the width of the border here
                ),
              ),
              child: Text(""),
            ),
            SizedBox(height: 10,),
            Container(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Adjust the value to change the roundness
                border: Border.all(
                  color: Colors.grey,
                  // You can set the color of the border here
                  width: 2, // You can adjust the width of the border here
                ),
              ),
              child: Text(""),
            ),



          ],
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
    final pickedImage =
    await picker.pickImage(source: source, imageQuality: 50);
    if (pickedImage != null) {
      setState(() {
        _selectedFileImage = File(pickedImage.path);
        _selectedImage = pickedImage.path; // Store image path for network image
      });
    }
  }
}