import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/constants.dart';

class NoteCard extends StatelessWidget {
  String note = StringConstatnts.sample_text;
  DateTime time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: 200,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  child: Text(note),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
