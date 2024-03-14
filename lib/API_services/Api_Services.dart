import 'package:flutter/material.dart';
import '../Model/Login_Model.dart';
import '../Utils/base.dart';
import 'package:dio/dio.dart';

import '../Utils/shared_preference.dart';

class ApiServices {
//   Future<Login_Model?> login(username,password) async {
//     String mToken = await getAuthToken();
//     try{
//     var query = {
//       "user_id":username,
//       "password":password
//     };
//     Response? response = await Dio().get(
//       // Base.baseURL + Base.login,
//       "http://192.168.0.236/manohar/login.php",
//       // "Http://192.168.10.30/hrapp/login.php",
//       queryParameters: {
//       },
//       options: Options(headers: {
//         'Content-Type': 'application/json',
//         'auth_key': mToken,
//       }),
//     );
//     print("object");
//     dynamic result = response.data;
//     print("loginApiRequest:::" + query.toString());
//     print("loginApi:::" + result.toString());
//     var data = Login_Model.fromJson(result);
//     print("responsedata:::" + data.toJson().toString());
//     return data;
//   }
//   catch(e){
//     print(e);
//   }
// }

  Future<Login_Model?> login(username,password) async {
    String mToken = await getAuthToken();
    print("API:::title");
    try {
      var query = {
        "user_id":username,
        "password":password
      };
      print("query");
      print(query);

      Response response = await Dio().get(
        Base.baseURL + Base.login,
        // http://192.168.0.236/manohar/login.php
        // "http://192.168.0.40:7007/api/showtime/member/list",
        queryParameters:{
          "user_id":username,
          "password":password
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
}

