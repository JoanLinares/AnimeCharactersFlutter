import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/crew.dart';
import '../models/haki.dart';
import '../services/api_service.dart';
import '../utils/network_utils.dart';

class CharacterViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool loading        = false;
  bool loadingDetails = false;

  List<Crew>      crews     = [];
  List<Character> allChars  = [];
  List<Character> filtered  = [];
  Character?      selected;
  List<Haki>      hakis     = [];

  Future<void> loadInitialData() async {
    loading = true; notifyListeners();
    if (!await hasConnection()) throw Exception('No Internet');
    crews    = await _api.fetchCrews();
    allChars = await _api.fetchCharacters();
    filtered = allChars;
    loading = false; notifyListeners();
  }

  Future<void> filterByCrew(int crewId) async {
    loading = true; notifyListeners();
    if (crewId == 0) {
      filtered = await _api.fetchCharacters();
    } else {
      filtered = await _api.fetchCharactersByCrew(crewId);
    }
    loading = false; notifyListeners();
  }

  void searchByName(String term) {
    filtered = allChars
      .where((c) => c.name.toLowerCase().contains(term.toLowerCase()))
      .toList();
    notifyListeners();
  }

  Future<void> loadDetails(int charId) async {
    loadingDetails = true; notifyListeners();
    selected = await _api.fetchCharacterById(charId);
    hakis    = await _api.fetchHakisByCharacter(charId);
    loadingDetails = false; notifyListeners();
  }
}
