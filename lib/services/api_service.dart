import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import '../models/crew.dart';
import '../models/devil_fruit.dart';
import '../models/haki.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Character>> fetchCharacters() async {
    final characters = await http.get(Uri.parse(charsEP));
    if (characters.statusCode == 200) {
      final data = json.decode(characters.body) as List;
      return data.map((e) => Character.fromJson(e)).toList();
    }
    throw Exception('Error loading characters');
  }

  Future<List<Character>> fetchCharactersByCrew(int crewId) async {
    final crewsCharacters = await http.get(Uri.parse('$crewById/$crewId'));
    if (crewsCharacters.statusCode == 200) {
      final data = json.decode(crewsCharacters.body) as List;
      return data.map((e) => Character.fromJson(e)).toList();
    }
    throw Exception('Error loading crew #$crewId');
  }

  Future<Character> fetchCharacterById(int id) async {
    final characterID = await http.get(Uri.parse('$charById/$id'));
    if (characterID.statusCode == 200) {
      return Character.fromJson(json.decode(characterID.body));
    }
    throw Exception('Error loading character #$id');
  }

  Future<List<Crew>> fetchCrews() async {
    final crews = await http.get(Uri.parse(crewsEP));
    if (crews.statusCode == 200) {
      final data = json.decode(crews.body) as List;
      return data.map((e) => Crew.fromJson(e)).toList();
    }
    throw Exception('Error loading crews');
  }

  Future<List<Haki>> fetchHakisByCharacter(int id) async {
    final characterHaki = await http.get(Uri.parse('$hakisByC/$id'));
    if (characterHaki.statusCode == 200) {
      final data = json.decode(characterHaki.body) as List;
      return data.map((e) => Haki.fromJson(e)).toList();
    }
    throw Exception('Error loading hakis');
  }
}
