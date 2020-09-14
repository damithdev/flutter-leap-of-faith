import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final double _cardHeight = 110;

  final String name;
  final String note;
  final DateTime time;

  NoteCard({this.name, this.note, this.time});

  _openCard(){

  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
      height: _cardHeight,
      width: double.maxFinite,
      child: GestureDetector(
        onTap: _openCard,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: _cardHeight - 55,
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
                  child: Text(
                    "Last Updated : " + f.format(time),
                    style: GoogleFonts.roboto(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
