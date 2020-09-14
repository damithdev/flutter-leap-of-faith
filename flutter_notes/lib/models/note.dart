import 'package:flutter_notes/constants.dart';

class NoteModel{

  NoteModel({this.name,this.note,this.time,this.action});
  String name;
  String note;
  DateTime time;
  NoteActions action;
}