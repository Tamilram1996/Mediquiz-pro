import 'package:flutter/material.dart';
import 'package:mediquizpro/UI/Splash_screen.dart';

import 'Utils/base.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediQuiz Pro',
      debugShowCheckedModeBanner: false,
      // color: Colors.transparent,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          //color: Colors.white,
            iconTheme:IconThemeData(color:Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            // centerTitle: true,
            titleTextStyle: TextStyle(fontSize:Base.titlefont,color: Colors.black,fontWeight: FontWeight.bold,),
            toolbarTextStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
        // textTheme: GoogleFonts.interTextTheme(TextTheme(
        // bodyLarge:TextStyle(fontSize:Base.titlefont * MediaQuery.textScaleFactorOf(context),color: Colors.black),
        // bodyMedium: TextStyle(fontSize:Base.titlefont * MediaQuery.textScaleFactorOf(context),color: Colors.black),
        // bodySmall: TextStyle(fontSize:Base.detailfont * MediaQuery.textScaleFactorOf(context),color: Colors.black))),
        // title: TextStyle(fontSize:Base.titlefont * MediaQuery.textScaleFactorOf(context),)),
        iconTheme: IconThemeData(color: Base.primaryColor),
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Base.primaryColor).copyWith(background: Colors.white),

      ),
      home: Splashscreen(),
    );
  }
}


