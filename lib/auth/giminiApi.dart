import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<String> giminiData(String text, String type, String imageQuery) async {
  var apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=AIzaSyDINE5QIQpA8PrSlfSoaCfbYJp3xztCoJE";

  Map bodyData;

  if (type != "image") {
    // TEXT ONLY
    bodyData = {
      "contents": [
        {
          "parts": [
            {"text": text},
          ],
        },
      ],
    };
  } else {
    // IMAGE + TEXT
    bodyData = {
      "contents": [
        {
          "parts": [
            {
              "inline_data": {"mime_type": "image/jpeg", "data": text},
            },
            {"text": imageQuery},
          ],
        },
      ],
    };
  }

  try {
    final fetchData = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodyData),
    );

    if (fetchData.statusCode == 200) {
      final res = jsonDecode(fetchData.body);
      return res["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      log(fetchData.statusCode.toString());
      return "Server Running Slow Please try again Later...";
    }
  } catch (e) {
    log(e.toString());
    return "Sorry, I don't know";
  }
}
