import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/constants.dart';
import 'package:flutter_notes/models/note.dart';
import 'package:flutter_notes/workers/requests.dart';

class NoteEditor extends StatefulWidget {
  final String name;

  NoteEditor({this.name});
  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  var editTextController = new TextEditingController();

  var requestWorker = new Requests();

  _noteEditorAction(NoteModel item) async {
    var response;
    switch (item.action) {
      case NoteActions.save:
        response =
            await requestWorker.saveNote(item.note, item.time.toString());
        break;
      case NoteActions.update:
        response = await requestWorker.updateNote(
            item.name, item.note, item.time.toString());
        break;
      case NoteActions.delete:
        response = await requestWorker.deleteNote(item.name);
        break;
    }

    if (response != null) {
      await _showAlertDialog(true);
      Navigator.of(context).pop(true);
    } else {
      _showAlertDialog(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Editor"),
        actions: <Widget>[
          widget.name != null
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _noteEditorAction(new NoteModel(
                        name: widget.name, action: NoteActions.delete));
                  },
                )
              : Container()
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: editTextController,
                decoration: InputDecoration(
                  hintText: "Your Note here...",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                autofocus: true,
                maxLines: null,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.name == null) {
            _noteEditorAction(new NoteModel(
                note: editTextController.text,
                time: DateTime.now(),
                action: NoteActions.save));
          } else {
            _noteEditorAction(new NoteModel(
                name: widget.name,
                note: editTextController.text,
                time: DateTime.now(),
                action: NoteActions.update));
          }
        },
        tooltip: 'Save Note',
        child: Icon(Icons.save),
      ),
      resizeToAvoidBottomPadding: true,
    );
  }

  Future<void> _showAlertDialog(bool status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status ? "SUCCESS" : "FAILED"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Operation " + (status ? " Successful" : "Failed") + " !"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
