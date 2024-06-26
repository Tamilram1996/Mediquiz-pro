import 'dart:convert';
import 'dart:io';
import 'package:mediquizpro/Model/Correctanswer_model.dart';
import 'package:mediquizpro/Model/Leaderboard_model.dart';
import 'package:mediquizpro/Model/Profile_Model.dart';
import 'package:mediquizpro/Model/StudentList_model.dart';
import 'package:mediquizpro/Model/Wronganswer_model.dart';
import 'package:mediquizpro/Model/addcasestudy_model.dart';
import 'package:mediquizpro/Model/insert_answer.dart';
import 'package:mediquizpro/UI/Student/answer_screen.dart';
import '../Model/Add_questions.dart';
import '../Model/Count_model.dart';
import '../Model/EditDoctorProfile_Model.dart';
import '../Model/History_Question.dart';
import '../Model/Login_Model.dart';
import '../Model/Sigup_model.dart';
import '../Model/TestMessageModel.dart';
import '../Model/Totalscore_model.dart';
import '../Model/profilephotoModel.dart';
import '../Model/timermodel.dart';
import '../Utils/base.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Utils/shared_preference.dart';

class ApiServices {

  Future<Login_Model?> login(username, password) async {
    String mToken = await getAuthToken();
    print("API:::title");
    try {
      var query = {
        "user_id": username,
        "password": password
      };
      print("query");
      print(query);

      Response response = await Dio().get(
        Base.baseURL + Base.login,
        queryParameters: {
          "user_id": username,
          "password": password
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': mToken,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> resultData = response.data as Map<String, dynamic>;
        var data = Login_Model.fromJson(resultData);
        print("responsedata:::" + data.toJson().toString());
        if (data.status == true) {
          return data;
        } else {
          print("No data");
          return data; // Or handle the failure case as needed
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; // Or handle the failure case as needed
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }


  // Future<SigupModel?> signup(
  //     String Useridcontroller,
  //     String namecontroller,
  //     String mobilecontroller,
  //     String emailcontroller,
  //     String instituecontroller,
  //     String designationcontroller,
  //     String createpasswordcontroller,
  //     String recreatepasswordcontroller
  //     ,) async {
  //   String mToken = await getAuthToken();
  //   print("API:::title");
  //   try {
  //     var query = {
  //       "user_id": Useridcontroller,
  //       "name": namecontroller,
  //       "phone_no": mobilecontroller,
  //       "email_id": emailcontroller,
  //       "password": createpasswordcontroller,
  //       "re_password": recreatepasswordcontroller,
  //       "institution": instituecontroller,
  //       "designation": designationcontroller,
  //       "profile_photo":""
  //     };
  //     print("query");
  //     print(query);
  //
  //     Response response = await Dio().post(
  //       Base.baseURL + Base.signup,
  //       data: query,
  //       options: Options(headers: {
  //         "Content-Type": "application/x-www-form-urlencoded",
  //         'Authorization': mToken,
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> resultData = response.data as Map<String, dynamic>;
  //       var data = SigupModel.fromJson(resultData);
  //       print("responsedata:::" + data.toJson().toString());
  //       if (data.status == true) {
  //         return data;
  //       } else {
  //         print("No data");
  //         return data; // Or handle the failure case as needed
  //       }
  //     } else {
  //       print("Request failed with status: ${response.statusCode}");
  //       return null; // Or handle the failure case as needed
  //     }
  //   } catch (e) {
  //     // Handle errors during API call
  //     print("Error: $e");
  //     return null;
  //   }
  // }

  Future<SigupModel?> signup(
      String Useridcontroller,
      String namecontroller,
      String mobilecontroller,
      String emailcontroller,
      String instituecontroller,
      String designationcontroller,
      String createpasswordcontroller,
      String recreatepasswordcontroller,
      File? _selectedFileImage) async {
    try {
      final token = await getAuthToken();


      if (_selectedFileImage == null) {
        print("Selected file is null");
        return null;
      }

      print("File Path: ${_selectedFileImage.path}");

      var imageBytes = await _selectedFileImage.readAsBytes();

      if (imageBytes.isEmpty) {
        print("File bytes are empty");
        return null;
      }

      var imageField = http.MultipartFile.fromBytes(
        'profile_photo',
        imageBytes,
        filename: _selectedFileImage.path
            .split('/')
            .last,
      );

      final request = http.MultipartRequest(
        'POST',
        Uri.parse( Base.baseURL + Base.signup),
      );

      // Set headers
      request.headers['Authorization'] = token;

      // Set form fields
      request.fields['user_id'] = Useridcontroller;
      request.fields['name'] = namecontroller;
      request.fields['email_id'] = emailcontroller;
      request.fields['phone_no'] = mobilecontroller;
      request.fields['institution'] = instituecontroller;
      request.fields['designation'] = designationcontroller;
      request.fields['password'] = createpasswordcontroller;
      request.fields['re_password'] = recreatepasswordcontroller;

      // Add file to request
      request.files.add(imageField);

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final resultData = jsonDecode(responseData);

      if (response.statusCode == 200) {
        return SigupModel.fromJson(resultData);
      } else {
        print("Non-200 status code: ${response.statusCode}");
        // Handle the error case appropriately
        return SigupModel.fromJson(resultData);
      }
    } catch (e) {
      print("Error: $e");
      // Handle the error case appropriately
      // return EditDoctorProfile_Model.fromJson(resultData);
    }
  }


  // Future<Profile_Model?> Profile(Useridcontroller) async {
  //   String mToken = await getAuthToken();
  //   print("API:::title");
  //   print("userid");
  //   print(Useridcontroller);
  //   try {
  //     var query = {
  //       "user_id": Useridcontroller,
  //     };
  //     print("query");
  //     print(query);
  //
  //     Response response = await Dio().get(
  //       Base.baseURL + Base.profile,
  //       queryParameters: {
  //         "user_id": Useridcontroller,
  //       },
  //       options: Options(headers: {
  //         "Content-Type": "application/json",
  //         'Authorization': mToken,
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> resultData = response.data as Map<String, dynamic>;
  //       var data = Profile_Model.fromJson(resultData);
  //       print("responsedata:::" + data.toJson().toString());
  //       if (data.status == true) {
  //         return data;
  //       } else {
  //         print("No data");
  //         return data; // Or handle the failure case as needed
  //       }
  //     } else {
  //       print("Request failed with status: ${response.statusCode}");
  //       return null; // Or handle the failure case as needed
  //     }
  //   } catch (e) {
  //     // Handle errors during API call
  //     print("Error: $e");
  //     return null;
  //   }
  // }

  Future<Profile_Model?> Profile(Useridcontroller) async {
    String mToken = await getAuthToken();
    print("API:::title");
    print("userid");
    print(Useridcontroller);
    try {
      var query = {
        "user_id": Useridcontroller,
      };
      print("query");
      print(query);

      Response response = await Dio().post(
        // Base.baseURL + Base.profile,
        "http://192.168.1.10/manohar/profile.php",
        queryParameters: {
          "user_id": Useridcontroller,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': mToken,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> resultData = response.data as Map<String, dynamic>;
        var data = Profile_Model.fromJson(resultData);
        print("responsedata:::" + data.toJson().toString());
        if (data.status == true) {
          return data;
        } else {
          print("No data");
          return data; // Or handle the failure case as needed
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; // Or handle the failure case as needed
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }



  Future<ProfilephotoModel?> photoupload(String Useridcontroller, File? _selectedFileImage) async {
    try {
      final token = await getAuthToken();

      if (_selectedFileImage == null) {
        print("Selected file is null");
        return null;
      }

      print("File Path: ${_selectedFileImage.path}");

      var imageBytes = await _selectedFileImage.readAsBytes();

      if (imageBytes.isEmpty) {
        print("File bytes are empty");
        return null;
      }

      var imageField = http.MultipartFile.fromBytes(
        'profile_photo',
        imageBytes,
        filename: _selectedFileImage.path.split('/').last,
      );

      final request = http.MultipartRequest(
        'POST',
        // Uri.parse(Base.baseURL + Base.profilephoto),
        Uri.parse("http://192.168.1.10/manohar/profile_photo.php"),
      );

      // Set headers
      request.headers['Authorization'] = token;

      // Set form fields
      request.fields['user_id'] = Useridcontroller;

      // Add file to request
      request.files.add(imageField);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final resultData = jsonDecode(responseData);
        return ProfilephotoModel.fromJson(resultData);
      } else {
        print("Non-200 status code: ${response.statusCode}");
        // Handle the error case appropriately
        return null;
      }
    } catch (e) {
      print("Error: $e");
      // Handle the error case appropriately
      return null;
    }
  }

  Future<EditDoctorProfile_Model?> Editprofile(String Useridcontroller,
      String namecontroller,
      String mobilecontroller,
      String emailcontroller,
      String instituecontroller,
      String designationcontroller,
      String passwordcontroller,
      String re_passwordcontroller,
      File? _selectedFileImage) async {
    try {
      final token = await getAuthToken();


      if (_selectedFileImage == null) {
        print("Selected file is null");
        return null;
      }

      print("File Path: ${_selectedFileImage.path}");

      var imageBytes = await _selectedFileImage.readAsBytes();

      if (imageBytes.isEmpty) {
        print("File bytes are empty");
        return null;
      }

      var imageField = http.MultipartFile.fromBytes(
        'profile_photo',
        imageBytes,
        filename: _selectedFileImage.path
            .split('/')
            .last,
      );

      final request = http.MultipartRequest(
        'POST',
        // Uri.parse(Base.baseURL+Base.editprofile),
        Uri.parse("http://192.168.1.10/manohar/editprofile.php"),
      );

      // Set headers
      request.headers['Authorization'] = token;

      // Set form fields
      request.fields['user_id'] = Useridcontroller;
      request.fields['name'] = namecontroller;
      request.fields['email_id'] = emailcontroller;
      request.fields['phone_no'] = mobilecontroller;
      request.fields['institution'] = instituecontroller;
      request.fields['designation'] = designationcontroller;
      request.fields['password'] = passwordcontroller;
      request.fields['re_password'] = re_passwordcontroller;

      // Add file to request
      request.files.add(imageField);

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final resultData = jsonDecode(responseData);

      if (response.statusCode == 200) {
        return EditDoctorProfile_Model.fromJson(resultData);
      } else {
        print("Non-200 status code: ${response.statusCode}");
        // Handle the error case appropriately
        return EditDoctorProfile_Model.fromJson(resultData);
      }
    } catch (e) {
      print("Error: $e");
      // Handle the error case appropriately
      // return EditDoctorProfile_Model.fromJson(resultData);
    }
  }

  // Future<List<Leaderboard_model>> leaderboard() async {
  //   String mToken = await getAuthToken();
  //   try {
  //     final response = await http.get(
  //       Uri.parse("http://192.168.1.10/manohar/leaderboard.php"),
  //       headers: {
  //         "Authorization": mToken.toString(),
  //         "Content-Type": "application/json",
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> responseData = jsonDecode(response.body);
  //       List<Leaderboard_model> leaderboardList = responseData.map((item) =>
  //           Leaderboard_model.fromJson(item)).toList();
  //       return leaderboardList;
  //     } else {
  //       // Handle HTTP error status codes
  //       print("HTTP Error: ${response.statusCode}");
  //       return [];
  //     }
  //   } catch (e) {
  //     // Handle errors during API call
  //     print("Error: $e");
  //     return [];
  //   }
  // }
  Future<LeaderboardModel?> leaderboard() async {
    try {
      String mToken = await getAuthToken();

      final response = await http.get(
        Uri.parse( Base.baseURL + Base.leaderboard,),
        headers: {
          "Authorization": mToken.toString(),
          "Content-Type": "application/json",
        },);
      print(response.body.toString());
      print("response.body.toString()");
      var resultData = jsonDecode(response.body);
      var data = LeaderboardModel.fromJson(resultData);
      if (data!=null) {
        print(data);
        print("data111111");
        return data;
      } else {
        // Handle non-200 status code (if needed)
        print("Non-200 status code: ${data.data}");
        return data;
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }
  //
  // Future<List<StudentList_model>> studentlist() async {
  //   String mToken = await getAuthToken();
  //   try {
  //     final response = await http.get(
  //       Uri.parse(Base.baseURL + Base.student),
  //       headers: {
  //         "Authorization": mToken.toString(),
  //         "Content-Type": "application/json",
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> responseData = jsonDecode(response.body);
  //       List<StudentList_model> leaderboardList = responseData.map((item) =>
  //           StudentList_model.fromJson(item)).toList();
  //       return leaderboardList;
  //     } else {
  //       // Handle HTTP error status codes
  //       print("HTTP Error: ${response.statusCode}");
  //       return [];
  //     }
  //   } catch (e) {
  //     // Handle errors during API call
  //     print("Error: $e");
  //     return [];
  //   }
  // }
  Future<StudentListModel?> studentlist() async {
    try {
      String mToken = await getAuthToken();

      final response = await http.get(
        Uri.parse( Base.baseURL + Base.student,),
        headers: {
          "Authorization": mToken.toString(),
          "Content-Type": "application/json",
        },);

      // dynamic result = response.data;
      print(response.body.toString());
      print("response.body.toString()");
      var resultData = jsonDecode(response.body);
      var data = StudentListModel.fromJson(resultData);
      if (data!=null) {
        print(data);
        print("data111111");
        return data;
      } else {
        // Handle non-200 status code (if needed)
        print("Non-200 status code: ${data.data}");
        return data;
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }

  Future<HistoryQuestion_Model?> question() async {
    String mToken = await getAuthToken();
    print("API:::title");
    print("userid");
    try {
      var query = {
      };
      print("query");
      print(query);

      Response response = await Dio().get(
        Base.baseURL + Base.getquestion,
        queryParameters: {
        },
        options: Options(),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> resultData = response.data as Map<String, dynamic>;
        var data = HistoryQuestion_Model.fromJson(resultData);
        print("responsedata:::" + data.toJson().toString());
        if (data.status == "success") {
          return data;
        } else {
          print("No data");
          return data; // Or handle the failure case as needed
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; // Or handle the failure case as needed
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }

  Future<TotalscoreModel?> totalscores(String userid) async {
    String mToken = await getAuthToken();
    print("API:::title");
    print(userid);
    try {
      FormData formData = FormData.fromMap({
        "user_id": userid,
      });
      print(Base.baseURL + Base.Totalscore);
      Response response = await Dio().post(
        // Base.baseURL + Base.Totalscore,
        "http://192.168.1.10/manohar/total_score_android.php",
        data: formData,
        options: Options(
          headers: {
            // 'Content-Type': 'application/x-www-form-urlencoded',
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': mToken,
          },
        ),
      );
      print("userid");
      print(userid);
      print(formData);
      dynamic result = response.data;
      print("ApiResponse:::" + result.toString());
      if (response.statusCode == 200) {
        var data = TotalscoreModel.fromJson(result);
        print("responseData:::" + data.toJson().toString());
        return data;
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; // Or handle the failure case as needed
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }

  Future<CorrectanswerModel?> correctanswers(String userid) async {
    String mToken = await getAuthToken();
    print("API:::title");
    print(userid);
    try {
      FormData formData = FormData.fromMap({
        "user_id": userid,
      });
      print("query");
      Response response = await Dio().post(
        Base.baseURL + Base.correctanswer,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': mToken,
          },
        ),
      );
      print("userid");
      print(Base.baseURL + Base.correctanswer);
      print(userid);
      print(formData);
      dynamic result = response.data;

      // Check if response is successful
      if (response.statusCode == 200) {
        // Assuming response contains a JSON with a key "status"
        var data = CorrectanswerModel.fromJson(response.data);
        print("responseData:::" + data.toString());
        return data;
      } else {
        print("Request failed with status: ${response.statusCode}");
        // Handle other status messages if needed
        return null;
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }

  Future<Wronganswer_Model?> wronganswer(String userid) async {
    String mToken = await getAuthToken();
    print("API:::title");
    print(userid);
    try {
      FormData formData = FormData.fromMap({
        "user_id": userid,
      });
      print("query");
      Response response = await Dio().post(
        Base.baseURL + Base.wronganswer,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': mToken,
          },
        ),
      );
      print("userid");
      print(Base.baseURL + Base.wronganswer);
      print(userid);
      print(formData);
      dynamic result = response.data;
      if (response.statusCode == 200) {
        // Assuming response contains a JSON with a key "status"
        var data = Wronganswer_Model.fromJson(result);
        print("responseData:::" + data.toString());
        return data;
      } else {
        print("Request failed with status: ${response.statusCode}");
        // Handle other status messages if needed
        return null;
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }


  //formdata with json

  Future<Insertanswermodel?> insertanswer(String Useridcontroller,
      Questionansweid, mQuestionAnswer) async {
    String mToken = await getAuthToken();
    print("API:::title");
    try {
      String jsonFormat = jsonEncode(mQuestionAnswer);
      FormData formData = FormData.fromMap({
        "user_id": Useridcontroller,
        "case_study_id": Questionansweid,
        "question_answers": jsonFormat,
      });
      Response response = await Dio().post(
        Base.baseURL + Base.myinsert,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': mToken,
          },
        ),
      );

      print("fhghfghg");
      print(Useridcontroller);
      print(Questionansweid);
      print(jsonFormat);
      print(formData);
      dynamic result = response.data;
      print("addProfileRequest:::" + formData.toString());
      print("ApiResponse:::" + result.toString());
      if (response.statusCode == 200) {
        var data = Insertanswermodel.fromJson(result);
        print("responseData:::" + data.toJson().toString());
        return data;
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; // Or handle the failure case as needed
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }


  Future<Addcasestudymodel?> addcasequestion(String Useridcontroller,
      String casecontroller,
      File? _selectedFileImage) async {
    try {
      final token = await getAuthToken();
      if (_selectedFileImage == null) {
        print("Selected file is null");
        return null;
      }

      print("File Path: ${_selectedFileImage.path}");

      var imageBytes = await _selectedFileImage.readAsBytes();

      if (imageBytes.isEmpty) {
        print("File bytes are empty");
        return null;
      }

      var imageField = http.MultipartFile.fromBytes(
        'photo',
        imageBytes,
        filename: _selectedFileImage.path
            .split('/')
            .last,
      );
      final request = http.MultipartRequest(
        'POST',
        // Uri.parse(Base.baseURL+Base.addcasestudy),
        Uri.parse("http://192.168.1.10/manohar/insert_casestudy.php"),
      );

      print(Base.baseURL+Base.addcasestudy);
      print("addcasestudy");
      // Set headers
      request.headers['Authorization'] = token;

      // Set form fields
      request.fields['id'] = Useridcontroller;
      request.fields['Case_Study'] = casecontroller;

      // Add file to request
      request.files.add(imageField);

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final resultData = jsonDecode(responseData);

      if (response.statusCode == 200) {
        return Addcasestudymodel.fromJson(resultData);
      } else {
        print("Non-200 status code: ${response.statusCode}");
        // Handle the error case appropriately
        return Addcasestudymodel.fromJson(resultData);
      }
    } catch (e) {
      print("Error: $e");
      // Handle the error case appropriately
      // return EditDoctorProfile_Model.fromJson(resultData);
    }
  }

  Future<CountModel?> counter() async {
    String mToken = await getAuthToken();
    print("API:::title");
    try {
      var query = {
      };
      print("query");
      print(query);

      Response response = await Dio().get(
        Base.baseURL + Base.count,
        queryParameters: {
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': mToken,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> resultData = response.data as Map<String, dynamic>;
        var data = CountModel.fromJson(resultData);
        print("responsedata:::" + data.toJson().toString());
        if (data.status == true) {
          return data;
        } else {
          print("No data");
          return data; // Or handle the failure case as needed
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; // Or handle the failure case as needed
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }


  Future<AddquestionModel?> addquestion(String Useridcontroller,
      mainquestion1,
      mainquestion2,
      mainquestion3,
      mainquestion4,
      correctaswer1,
      correctaswer2,
      correctaswer3,
      correctaswer4,
      firstoption1,
      firstoption2,
      firstoption3,
      firstoption4,
      secondoption1,
      secondoption2,
      secondoption3,
      secondoption4,
      thirdoption1,
      thirdoption2,
      thirdoption3,
      thirdoption4,
      fourthoption1,
      fourthoption2,
      fourthoption3,
      fourthoption4,) async {
    String mToken = await getAuthToken();
    print("API:::title");
    try {
      var query = jsonEncode({
        "caseStudyID": Useridcontroller,
        "questions": [
          {
            "questionID": 1,
            "question": mainquestion1,
            "option1": firstoption1,
            "option2": firstoption2,
            "option3": firstoption3,
            "option4": firstoption4,
            "correctAnswer": correctaswer1
          },
          {
            "questionID": 2,
            "question": mainquestion2,
            "option1": secondoption1,
            "option2": secondoption2,
            "option3": secondoption3,
            "option4": secondoption4,
            "correctAnswer": correctaswer2
          },
          {
            "questionID": 3,
            "question": mainquestion3,
            "option1": thirdoption1,
            "option2": thirdoption2,
            "option3": thirdoption3,
            "option4": thirdoption4,
            "correctAnswer": correctaswer3
          },
          {
            "questionID": 4,
            "question": mainquestion4,
            "option1": fourthoption1,
            "option2": fourthoption2,
            "option3": fourthoption3,
            "option4": fourthoption4,
            "correctAnswer": correctaswer4
          }
        ]
      });
      print("query");
      print(query);
      Response response = await Dio().post(
        Base.baseURL + Base.insert_question,
        data: query,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': mToken,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> resultData = response.data as Map<String, dynamic>;
        var data = AddquestionModel.fromJson(resultData);
        print("responsedata:::" + data.toJson().toString());
        if (data.status == "success") {
          return data;
        } else {
          print("No data");
          return data; // Or handle the failure case as needed
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; // Or handle the failure case as needed
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }

  Future<TimerModel?> timingleft() async {
    try {
      String mToken = await getAuthToken();

      final response = await http.get(
        Uri.parse( Base.baseURL + Base.timephp,),
        headers: {
          "Authorization": mToken.toString(),
          "Content-Type": "application/json",
        },);
      print(response.body.toString());
      print("response.body.toString()");
      var resultData = jsonDecode(response.body);
      var data = TimerModel.fromJson(resultData);
      if (data!=null) {
        print(data);
        print("data111111");
        return data;
      } else {
        // Handle non-200 status code (if needed)
        print("Non-200 status code: ${data.status}");
        return data;
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }

  Future<TestMessageModel?> testmessager(String userid) async {
    String mToken = await getAuthToken();
    print("API:::title");
    print(userid);
    try {
      FormData formData = FormData.fromMap({
        "user_id": userid,
      });
      print(Base.baseURL + Base.testmessage);
      Response response = await Dio().post(
        Base.baseURL + Base.testmessage,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': mToken,
          },
        ),
      );
      print("userid");
      print(userid);
      print(formData);
      dynamic result = response.data;
      print("ApiResponse:::" + result.toString());
      if (response.statusCode == 200) {
        var data = TestMessageModel.fromJson(result);
        print("responseData:::" + data.toJson().toString());
        return data;
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; // Or handle the failure case as needed
      }
    } catch (e) {
      // Handle errors during API call
      print("Error: $e");
      return null;
    }
  }


}

