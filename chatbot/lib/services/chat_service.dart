import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = "Your_API";

  Future<String> sendMessage(String text) async {
    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": text}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        return data["candidates"][0]["content"]["parts"][0]["text"] ?? "No reply";
      } catch (e) {
        return "⚠️ Parsing error.";
      }
    } else {
      return "⚠️ API Error ${response.statusCode}";
    }
  }
}
