
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


setBioId(String data) async {
  print("tokdata" + data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', data);
}

Future<String> getBioId() async {
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