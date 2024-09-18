import 'dart:convert';

import 'package:http/http.dart' as http;

import '../screen/home/model/gemini_model.dart';
class APIHelper
{

  Future<GeminiModel?> getData()
 async {
    String link = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyAk9L-loz4U3hLZTa-meB6T8lhZISdJvuk";
    var responces =await http.post(Uri.parse(link),headers: {"Content-Type": "application/json"},body: jsonEncode({"contents":[{"parts":[{"text":"How are you?"}]}]}));

    if(responces.statusCode == 200)
      {
        var json = jsonDecode(responces.body);
        GeminiModel model = GeminiModel.mapToModel(json);

        return model;
      }
    return null;
  }
}