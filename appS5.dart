import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatBotLogic {
  final String apiKey = "API-dyali-man9adch-npartagiha";

  // Cette liste conserve le contexte de la discussion (historique)
  List<Map<String, String>> messages = [
    {"role": "system", "content": "Tu es un assistant utile et concis."},
  ];

  /// Envoie un message à l'API et retourne la réponse
  Future<String> askChatGPT(String prompt) async {
    messages.add({"role": "user", "content": prompt});

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo", // Modèle le plus courant et économique
          "messages": messages,
        }),
      );

      if (response.statusCode == 200) {
        // Décodage pour gérer correctement les accents (UTF-8)
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        String botReply = data['choices'][0]['message']['content'];

        messages.add({"role": "assistant", "content": botReply});

        return botReply;
      } else {
        return "Erreur de l'API (${response.statusCode}) : ${response.body}";
      }
    } catch (e) {
      return "Une exception s'est produite : $e";
    }
  }
}
