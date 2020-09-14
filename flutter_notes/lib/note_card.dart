import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/constants.dart';

class NoteCard extends StatelessWidget {  

  final double _card_height = 130;

  String note = StringConstatnts.sample_text;
  DateTime time = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: _card_height,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: _card_height - 70,
                  child: Text(note,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text("Last Updated : "+time.toString()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
