import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import '../models/crew.dart';
import '../models/devil_fruit.dart';
import '../models/haki.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Character>> fetchCharacters() async {
    final r = await http.get(Uri.parse(charsEP));
    if (r.statusCode == 200) {
      final data = json.decode(r.body) as List;
      return data.map((e) => Character.fromJson(e)).toList();
    }
    throw Exception('Error loading characters');
  }

  Future<List<Character>> fetchCharactersByCrew(int crewId) async {
    final r = await http.get(Uri.parse('$crewById/$crewId'));
    if (r.statusCode == 200) {
      final data = json.decode(r.body) as List;
      return data.map((e) => Character.fromJson(e)).toList();
    }
    throw Exception('Error loading crew #$crewId');
  }

  Future<Character> fetchCharacterById(int id) async {
    final r = await http.get(Uri.parse('$charById/$id'));
    if (r.statusCode == 200) {
      return Character.fromJson(json.decode(r.body));
    }
    throw Exception('Error loading character #$id');
  }

  Future<List<Crew>> fetchCrews() async {
    final r = await http.get(Uri.parse(crewsEP));
    if (r.statusCode == 200) {
      final d = json.decode(r.body) as List;
      return d.map((e) => Crew.fromJson(e)).toList();
    }
    throw Exception('Error loading crews');
  }

  Future<List<Haki>> fetchHakisByCharacter(int id) async {
    final r = await http.get(Uri.parse('$hakisByC/$id'));
    if (r.statusCode == 200) {
      final d = json.decode(r.body) as List;
      return d.map((e) => Haki.fromJson(e)).toList();
    }
    throw Exception('Error loading hakis');
  }
}
