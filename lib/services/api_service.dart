import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_summary.dart';
import '../models/character_detail.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<CharacterSummary>> fetchCharactersBySeries(int animeId) async {
    final res = await http.get(Uri.parse('$animeCharactersEP/$animeId/characters'));
    if (res.statusCode == 200) {
      final m = json.decode(res.body) as Map<String, dynamic>;
      final list = m['data'] as List<dynamic>;
      return list
          .map((e) => CharacterSummary.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error loading characters for anime $animeId');
  }

  Future<CharacterDetail> fetchCharacterDetail(int charId) async {
    final res = await http.get(Uri.parse('$characterDetailEP/$charId'));
    if (res.statusCode == 200) {
      return CharacterDetail.fromJson(json.decode(res.body) as Map<String, dynamic>);
    }
    throw Exception('Error loading character detail $charId');
  }
}
