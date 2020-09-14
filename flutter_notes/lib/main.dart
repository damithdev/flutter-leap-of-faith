import 'dart:io';
import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isIOS = false;
    try {
      isIOS = Platform.isIOS;
    } catch (e) {}
     
    if (isIOS) {
      return CupertinoApp(
        title: 'Flutter Demo',
        home: MyHomePage(
          title: 'Flutter Notes',
          isIOS: isIOS,
        ),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Notes',isIOS: isIOS,),
      );
    }
  }
}
