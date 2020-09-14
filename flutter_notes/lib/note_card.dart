import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final double _card_height = 110;

  String note = StringConstatnts.sample_text;
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    final TextStyle cardText = Theme.of(context).textTheme.caption;

    return Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 0),
        height: _card_height,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: _card_height - 55,
                  child: Text(
                    note,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text("Last Updated : " + f.format(time),
                  style: GoogleFonts.roboto(fontStyle: FontStyle.italic,color: Colors.grey),),
                )
              ],
            ),
          ),
        ),
      );
  }
}
