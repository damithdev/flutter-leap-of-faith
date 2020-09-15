import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/models/note.dart';
import 'package:flutter_notes/note_card.dart';
import 'package:flutter_notes/note_editor.dart';
import 'package:flutter_notes/workers/requests.dart';

class MyHomePage extends StatefulWidget {
  final bool isIOS;
  MyHomePage({Key key, this.title, this.isIOS}) : super(key: key);

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
    } else {
      setState(() {
        _noteList = List();
      });
    }
  }

  _openCardEditor(String name, String note) async {
    var _pageRoute = widget.isIOS
        ? CupertinoPageRoute(
            builder: (context) => NoteEditor(
                  name: name,
                  note: note,
                  isIOS: widget.isIOS,
                ))
        : MaterialPageRoute(
            builder: (context) => NoteEditor(
                  name: name,
                  note: note,
                  isIOS: widget.isIOS,
                ));
    final result = await Navigator.push(context, _pageRoute);

    if (result) {
      _updateNoteList();
    }
  }

  @override
  void initState() {
    _updateNoteList();
    super.initState();
  }

  _getAppBody() {
    return Container(
      child: ListView.builder(
          itemCount: _noteList.length,
          itemBuilder: (context, index) {
            var element = _noteList.elementAt(index);
            return NoteCard(
              note: element.note,
              name: element.name,
              time: element.time,
              callback: _openCardEditor,
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.title),
          trailing: GestureDetector(
            onTap: () {
              _openCardEditor(null, null);
            },
            child: Icon(
              CupertinoIcons.add,
              color: CupertinoColors.black,
            ),
          ),
        ),
        child: _getAppBody(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _getAppBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openCardEditor(null, null);
          },
          tooltip: 'Add Note',
          child: Icon(Icons.add),
        ),
      );
    }
  }
}
