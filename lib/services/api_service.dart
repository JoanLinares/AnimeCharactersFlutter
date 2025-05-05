import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import '../models/crew.dart';
import '../models/devil_fruit.dart';
import '../models/haki.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Character>> fetchCharacters() async {
    final res = await http.get(Uri.parse(charsEP));
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error loading characters');
  }

  Future<List<Character>> fetchCharactersByCrew(int crewId) async {
    final res = await http.get(Uri.parse('$crewById/$crewId'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error loading crew #$crewId');
  }

  Future<Character> fetchCharacterById(int id) async {
    final res = await http.get(Uri.parse('$charById/$id'));
    if (res.statusCode == 200) {
      return Character.fromJson(json.decode(res.body) as Map<String, dynamic>);
    }
    throw Exception('Error loading character #$id');
  }

  Future<List<Crew>> fetchCrews() async {
    final res = await http.get(Uri.parse(crewsEP));
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((e) => Crew.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Error loading crews');
  }

  Future<List<Haki>> fetchHakisByCharacter(int id) async {
    final res = await http.get(Uri.parse('$hakisByC/$id'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return data.map((e) => Haki.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Error loading hakis for character #$id');
  }

  Future<DevilFruit> fetchFruitById(int id) async {
    final res = await http.get(Uri.parse('$fruitsEP/$id'));
    if (res.statusCode == 200) {
      return DevilFruit.fromJson(json.decode(res.body) as Map<String, dynamic>);
    }
    throw Exception('Error loading fruit #$id');
  }
}

Future<String?> fetchCharacterImage(String name) async {
  final encoded = Uri.encodeComponent(name);
  final url = Uri.parse(
    'https://onepiece.fandom.com/api.php'
    '?action=query'
    '&titles=$encoded'
    '&prop=pageimages'
    '&format=json'
    '&pithumbsize=300'
  );
  final res = await http.get(url);
  if (res.statusCode != 200) return null;

  final json = jsonDecode(res.body) as Map<String, dynamic>;
  final pages = (json['query'] as Map)['pages'] as Map<String, dynamic>;
  final page = pages.values.first as Map<String, dynamic>;

  return (page['thumbnail'] as Map<String, dynamic>?)?['source'] as String?;
}