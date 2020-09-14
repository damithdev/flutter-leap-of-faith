import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/constants.dart';
import 'package:flutter_notes/models/note.dart';
import 'package:flutter_notes/workers/requests.dart';

class NoteEditor extends StatefulWidget {
  final isIOS;
  final String title = "Note Editor";
  final String name;
  final String note;

  NoteEditor({this.name, this.note,this.isIOS});
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
  void initState() {
    if (widget.note != null) editTextController.text = widget.note;
    super.initState();
  }

  _pageBody(Widget textField) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[textField],
        ),
      ),
    );
  }

  _saveAction() {
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
  }

  _deleteAction() {
    _noteEditorAction(
        new NoteModel(name: widget.name, action: NoteActions.delete));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isIOS) {
      var textField = Container(
        margin: EdgeInsets.only(top: 50),
        child: CupertinoTextField(
          controller: editTextController,
          scrollPadding: EdgeInsets.all(20.0),
          keyboardType: TextInputType.multiline,
          autofocus: true,
          maxLines: null,
        ),
      );
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: GestureDetector(
            onTap: () {
              if (editTextController.text != widget.note) {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text("Changes Exist"),
                      content: Text("Do you want to save the changes?"),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('Yes'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _saveAction();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Row(
              children: <Widget>[
                Icon(CupertinoIcons.left_chevron),
                Text(
                  'Back',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                  ),
                ),
              ],
            ),
          ),
          middle: Text(widget.title),
          trailing: GestureDetector(
            onTap: () {
              _deleteAction();
            },
            child: Icon(
              CupertinoIcons.delete,
              color: CupertinoColors.black,
            ),
          ),
        ),
        child: _pageBody(textField),
      );
    } else {
      var textField = TextField(
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
      );
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            widget.name != null
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _deleteAction();
                    },
                  )
                : Container()
          ],
        ),
        body: _pageBody(textField),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _saveAction();
          },
          tooltip: 'Save Note',
          child: Icon(Icons.save),
        ),
        resizeToAvoidBottomPadding: true,
      );
    }
  }

  Future<void> _showAlertDialog(bool status) async {
    String _title = status ? "SUCCESS" : "FAILED";
    String _description =
        "Operation " + (status ? " Successful" : "Failed") + " !";
    if (widget.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(_title),
            content: Text(_description),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(_description),
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
}
