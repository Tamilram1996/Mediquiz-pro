
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPref() async {
  return await SharedPreferences.getInstance();
}

Future<String> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('token') != null &&
      prefs.getString('token')!.isNotEmpty) {
    print("MyAuthToken" + "Bearer "+prefs.getString('token').toString());
  } else {
    print("Token is  Empty");
  }
  return prefs.getString('token') != null
      ? "Bearer "+prefs.getString('token').toString()
      : "";
}
//token store
setAuthToken(String data) async {
  print("tokdata" + data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', data);
}

//Usercredentialget
Future<String> Getuserid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('token') != null &&
      prefs.getString('token')!.isNotEmpty) {
    print("MyAuthToken" + prefs.getString('token').toString());
  } else {
    print("Token is  Empty");
  }
  return prefs.getString('token') != null
      ? prefs.getString('token').toString()
      : "";
}
Setuser(String data) async {
  print("tokdata" + data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', data);
}


//Usercredentialset

//Usercredentialclear - Homescreen there
setUserName(String data,String Password) async {
  print("userName" + data);
  print("Password" + Password);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userName', data);
  prefs.setString('Password', Password);
}

Future<String> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('userName') != null && prefs.getString('Password') != null &&
  prefs.getString('userName')!.isNotEmpty) {
    print("userName" + prefs.getString('userName').toString());
    print("Password" + prefs.getString('Password').toString());
  } else {
    print("Token is  Empty");
  }
  return prefs.getString('userName') != null && prefs.getString('Password') != null
      ? prefs.getString('userName').toString()
      : "";
}
Future<void> clearAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userName') && await prefs.remove('Password');
}
Future<void> logout() async {
// Clear the authentication token
  await clearAuthToken();


// Additional logout actions can be added here
// Example: navigate to the login screen
// Navigator.pushReplacementNamed(context, '/login');
}