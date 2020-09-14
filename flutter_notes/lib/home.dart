import 'package:flutter/material.dart';
import 'package:flutter_notes/models/note.dart';
import 'package:flutter_notes/note_card.dart';
import 'package:flutter_notes/note_editor.dart';
import 'package:flutter_notes/workers/requests.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NoteModel> _noteList = List();
  var requestWorker = new Requests();

  _updateNoteList() async {
    var response = await requestWorker.getNotes();

    if (response != null) {
      var results = response as Map;
      List<NoteModel> _list = new List();
      for (var item in results.keys) {
        print(item);
        Map noteItem = results[item];
        _list.add(new NoteModel(
            name: item,
            note: noteItem['note'],
            time: DateTime.parse(noteItem['time'])));
      }

      setState(() {
        _noteList = _list.reversed.toList();
      });
    }
  }

  _openCardEditor(String name, String note) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoteEditor(name: name, note: note)));

    if (result) {
      _updateNoteList();
    }
  }

  @override
  void initState() {
    _updateNoteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _noteList.length,
            itemBuilder: (context, index) {
              var element = _noteList.elementAt(index);
              return NoteCard(
                  note: element.note, name: element.name, time: element.time,callback: _openCardEditor,);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _openCardEditor(null, null);
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}
