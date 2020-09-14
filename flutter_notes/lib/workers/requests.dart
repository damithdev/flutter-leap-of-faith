import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Requests {
  saveNote(String note, String time) async {
    var response = await http.post(
        "https://flutter-leap-of-faith.firebaseio.com/notes.json",
        body: json.encode({'note': note, 'time': time}));

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['name'];
    } else {
      return null;
    }
  }

  updateNote(String name, String note, String time) async {
    var response = await http.patch(
        "https://flutter-leap-of-faith.firebaseio.com/notes/$name/.json",
        body: json.encode({'note': note, 'time': time}));

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['note'];
    } else {
      return null;
    }
  }

  deleteNote(String name) async {
    var response = await http.delete(
        "https://flutter-leap-of-faith.firebaseio.com/notes/$name/.json");

    if (response.statusCode == 200) {
      return "SUCCESS";
    } else {
      return null;
    }
  }

  getNotes() async {
    var response = await http
        .get("https://flutter-leap-of-faith.firebaseio.com/notes.json");

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return null;
    }
  }
}
