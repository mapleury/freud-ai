import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../utils/constants.dart';

class HuggingFaceService {
  final String _apiKey = dotenv.env['HF_API_KEY'] ?? '';
  final String _generator =
      dotenv.env['HF_MODEL_GENERATOR'] ?? 'microsoft/GODEL-v1_1-base-seq2seq';
  final String _emotionModel =
      dotenv.env['HF_MODEL_EMOTION'] ??
      'j-hartmann/emotion-english-distilroberta-base';

  Map<String, String> get _headers => {
    'Authorization': 'Bearer $_apiKey',
    'Content-Type': 'application/json',
  };

  Future<String> generateResponse(
    String prompt, {
    List<Map<String, String>>? history,
  }) async {
    final body = {
      'inputs': prompt,
    };

    final url = Uri.parse(
      '${Constants.hfBase}/\$_generator'.replaceAll('\\', ''),
    );
    final resp = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(body),
    );

    if (resp.statusCode == 200) {
      final decoded = jsonDecode(resp.body);
      if (decoded is Map && decoded.containsKey('generated_text')) {
        return decoded['generated_text'] as String;
      }
      if (decoded is List && decoded.isNotEmpty) {
        final first = decoded[0];
        if (first is Map && first.containsKey('generated_text'))
          return first['generated_text'];
        if (first is Map && first.containsKey('content'))
          return first['content'];
        if (first is String) return first;
      }
      return resp.body;
    } else {
      throw Exception('HF generation failed: ${resp.statusCode} ${resp.body}');
    }
  }

  Future<String?> detectEmotion(String text) async {
    final url = Uri.parse(
      '${Constants.hfBase}/\$_emotionModel'.replaceAll('\\', ''),
    );
    final body = {
      'inputs': text,
      'options': {'wait_for_model': true},
    };
    final resp = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(body),
    );
    if (resp.statusCode == 200) {
      final decoded = jsonDecode(resp.body);
      if (decoded is List && decoded.isNotEmpty) {
        final first = decoded[0];
        if (first is Map && first.containsKey('label')) return first['label'];
      }
      return null;
    } else {
      return null;
    }
  }
}
