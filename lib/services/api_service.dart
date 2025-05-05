import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Character>> fetchAll() async {
    final res = await http.get(Uri.parse(charsEP));
    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Character.fromJson(e)).toList();
    }
    throw Exception('Error loading characters');
  }

  Future<Character> fetchById(int id) async {
    final res = await http.get(Uri.parse('$charByIdEP/$id'));
    if (res.statusCode == 200) {
      return Character.fromJson(json.decode(res.body));
    }
    throw Exception('Error loading character $id');
  }
}
