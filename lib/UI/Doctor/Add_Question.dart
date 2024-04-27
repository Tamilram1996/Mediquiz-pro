import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mediquizpro/Model/Count_model.dart';
import 'package:mediquizpro/Model/addcasestudy_model.dart';
import '../../API_services/Api_Services.dart';
import '../../Model/Add_questions.dart';
import '../../Utils/shared_preference.dart';
import '../../Utils/utils.dart';
import 'Doctor_Profile.dart';

// String? userid;
class Add_Question extends StatefulWidget {
  const Add_Question({super.key});

  @override
  State<Add_Question> createState() => _Add_QuestionState();
}

class _Add_QuestionState extends State<Add_Question> {
  File? _selectedFileImage;
  String? _selectedImage;
  String? casecount;
  TextEditingController casecontroller = TextEditingController();
  bool isLoading = true;
  TextEditingController Useridcontroller = TextEditingController();
  Addcasestudymodel? cAddcasestudymodel;
  CountModel? cCountModel;

  TextEditingController mainquestion1 = TextEditingController();
  TextEditingController mainquestion2 = TextEditingController();
  TextEditingController mainquestion3 = TextEditingController();
  TextEditingController mainquestion4 = TextEditingController();

  TextEditingController correctaswer1 = TextEditingController();
  TextEditingController correctaswer2 = TextEditingController();
  TextEditingController correctaswer3 = TextEditingController();
  TextEditingController correctaswer4 = TextEditingController();

  TextEditingController firstoption1 = TextEditingController();
  TextEditingController firstoption2 = TextEditingController();
  TextEditingController firstoption3 = TextEditingController();
  TextEditingController firstoption4 = TextEditingController();

  TextEditingController secondoption1 = TextEditingController();
  TextEditingController secondoption2 = TextEditingController();
  TextEditingController secondoption3 = TextEditingController();
  TextEditingController secondoption4 = TextEditingController();

  TextEditingController thirdoption1 = TextEditingController();
  TextEditingController thirdoption2 = TextEditingController();
  TextEditingController thirdoption3 = TextEditingController();
  TextEditingController thirdoption4 = TextEditingController();

  TextEditingController fourthoption1 = TextEditingController();
  TextEditingController fourthoption2 = TextEditingController();
  TextEditingController fourthoption3 = TextEditingController();
  TextEditingController fourthoption4 = TextEditingController();

  AddquestionModel? cAddquestionModel;

  void initState() {
    super.initState();
    Countmain();
  }
  Countmain() {
    isLoading = true;
    setState(() {});
    ApiServices().counter().then((value) {
      if (value != null && (value!.status! == "success")) {
        print("login");
        print(value);
        cCountModel = value;
        int currentCount = int.parse(cCountModel!.totalRows!.toString()); // Parse to integer
        int incrementedCount = currentCount + 1; // Increment
        casecount = incrementedCount.toString(); // Convert back to string
        Useridcontroller.text = casecount!.toString();
        print(Setuser);
        print("object");
      } else {
        toastMessage(context, "Something went wrong", Colors.red);
      }
      isLoading = false;
      setState(() {});
    });
  }


  // Countmain() {
  //   isLoading = true;
  //   setState(() {});
  //   ApiServices().counter().then((value) {
  //     if (value != null && (value!.status! == "success")) {
  //       print("login");
  //       print(value);
  //       cCountModel = value;
  //       casecount = cCountModel!.totalRows!.toString();
  //       Useridcontroller.text = casecount!.toString();
  //       print(Setuser);
  //       print("object");
  //     } else {
  //       toastMessage(context, "Something went wrong", Colors.red);
  //     }
  //     isLoading = false;
  //     setState(() {});
  //   });
  // }

  Addcase() async {
    isLoading = true;
    setState(() {});
    ApiServices()
        .addcasequestion(
        Useridcontroller.text, casecontroller.text, _selectedFileImage)
        .then((value) {
      if (value != null) {
        print("login");
        print(value);
        cAddcasestudymodel = value;
        Addquestions();
        toastMessage(
            context, cAddcasestudymodel!.message.toString(), Colors.green);
      } else {
        toastMessage(context, "Something went wrong", Colors.red);
      }
      isLoading = false;
      setState(() {});
    });
  }

  Addquestions() async {
    isLoading = true;
    setState(() {});
    ApiServices()
        .addquestion(
      Useridcontroller.text,
      mainquestion1.text,
      mainquestion2.text,
      mainquestion3.text,
      mainquestion4.text,
      correctaswer1.text,
      correctaswer2.text,
      correctaswer3.text,
      correctaswer4.text,
      firstoption1.text,
      firstoption2.text,
      firstoption3.text,
      firstoption4.text,
      secondoption1.text,
      secondoption2.text,
      secondoption3.text,
      secondoption4.text,
      thirdoption1.text,
      thirdoption2.text,
      thirdoption3.text,
      thirdoption4.text,
      fourthoption1.text,
      fourthoption2.text,
      fourthoption3.text,
      fourthoption4.text,
    )
        .then((value) {
      if (value != null) {
        print("login");
        print(value);
        cAddquestionModel = value;
        toastMessage(context, cAddcasestudymodel!.message.toString(), Colors.teal);
        toastMessage(context, cAddcasestudymodel!.message.toString(), Colors.blueGrey);


      } else {
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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Doctor_Profile(),
                  ),
                );
              },
              icon: Image.asset("assets/Male User-1.png"),
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Case Study${casecount}"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: casecontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter the case study',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showImagePickerDialog();
                },
                child: Container(
                  width: 100,
                  // Adjust width according to your UI requirements
                  height: 120,
                  // Adjust height according to your UI requirements
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
                      : Icon(Icons.add_a_photo,
                      size: 50, color: Colors.grey),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Question 1",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: mainquestion1,
                  decoration: InputDecoration(
                    hintText: 'Enter the Question',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Correct Answer",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: correctaswer1,
                  decoration: InputDecoration(
                    hintText: 'Enter the correct option number Ex: 1',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Options",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: firstoption1,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: firstoption2,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: firstoption3,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: firstoption4,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Question 2",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: mainquestion2,
                  decoration: InputDecoration(
                    hintText: 'Enter the Question',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Correct Answer",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: correctaswer2,
                  decoration: InputDecoration(
                    hintText: 'Enter the correct option number Ex: 1',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Options",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: secondoption1,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: secondoption2,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: secondoption3,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: secondoption4,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Question 3",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: mainquestion3,
                  decoration: InputDecoration(
                    hintText: 'Enter the Question',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Correct Answer",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: correctaswer3,
                  decoration: InputDecoration(
                    hintText: 'Enter the correct option number Ex: 1',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Options",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: thirdoption1,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: thirdoption2,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: thirdoption3,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: thirdoption4,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Question 4",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: mainquestion4,
                  decoration: InputDecoration(
                    hintText: 'Enter the Question',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Correct Answer",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: correctaswer4,
                  decoration: InputDecoration(
                    hintText: 'Enter the correct option number Ex: 1',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Options",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: fourthoption1,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: fourthoption2,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: fourthoption3,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the value to change the roundness
                  border: Border.all(
                    color: Colors.grey,
                    // You can set the color of the border here
                    width: 2, // You can adjust the width of the border here
                  ),
                ),
                child: TextField(
                  // Replaced the empty Text widget with a TextField
                  controller: fourthoption4,
                  decoration: InputDecoration(
                    hintText: 'Enter the option',
                    border: InputBorder.none,
                    // Remove the border of the TextField
                    contentPadding:
                    EdgeInsets.only(bottom: 10, left: 10), // Add padding
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
          child: Text(
            "Submit",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            print("startingcase");
            print(Useridcontroller.text);
            print(casecontroller.text);
            print(_selectedFileImage);
            //
            //
            print("first");
            print("${Useridcontroller.text}");
            print(mainquestion1.text);
            print( correctaswer1.text);
            print( firstoption1.text);
            print( secondoption1.text);
            print( thirdoption1.text);
            print( fourthoption1.text);

            print("second");
            print(mainquestion2.text);
            print( correctaswer2.text);
            print( firstoption2.text);
            print( secondoption2.text);
            print( thirdoption2.text);
            print( fourthoption2.text);
            print("third");
            print( mainquestion3.text);
            print( correctaswer3.text);
            print( firstoption3.text);
            print( secondoption3.text);
            print( thirdoption3.text);
            print( fourthoption3.text);
            print("fourth");
            print( mainquestion4.text);
            print( correctaswer4.text);
            print( firstoption4.text);
            print( secondoption4.text);
            print( thirdoption4.text);
            print( fourthoption4.text);
            print("hellooooooooo");

            Addcase();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Congratulation_screen()),
            // );
            // Navigator.pop(context);
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
