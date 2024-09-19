import 'dart:convert';

import 'package:http/http.dart' as http;

import '../screen/home/model/gemini_model.dart';

class APIHelper {
  static APIHelper helper = APIHelper._();

  APIHelper._();

  Future<GeminiModel?> getData(String search) async {
    String link =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyAk9L-loz4U3hLZTa-meB6T8lhZISdJvuk";
    var responces = await http.post(
      Uri.parse(link),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "contents": [
            {
              "parts": [
                {"text": "${search}"},
              ],
            },
          ],
        },
      ),
    );

    if (responces.statusCode == 200) {
      var json = jsonDecode(responces.body);
      print("========================${json}");
      GeminiModel model = GeminiModel.fromJson(json);

      print(model.candidates![0].content!.parts![0].text);

      return model;
    }
    return null;
  }
}
