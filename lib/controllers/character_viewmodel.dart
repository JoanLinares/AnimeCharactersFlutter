import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class CharacterViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool loading        = false;
  bool loadingDetail  = false;

  List<Character> characters   = [];
  List<Character> filtered     = [];
  List<String>    affiliations = ['All'];
  String          selectedAffiliation = 'All';

  Character? selected;

  /// Carga todos los personajes y construye la lista de afiliaciones
  Future<void> loadAll() async {
    loading = true;
    notifyListeners();

    characters = await _api.fetchAll();
    // construye lista única de afiliaciones (incluyendo “All”)
    affiliations = [
      'All',
      ...characters.map((c) => c.affiliation).toSet().where((a) => a.isNotEmpty)
    ];
    // inicialmente muestra todos
    filtered = characters;

    loading = false;
    notifyListeners();
  }

  /// Filtra localmente por afiliación
  void filterByAffiliation(String affiliation) {
    selectedAffiliation = affiliation;
    if (affiliation == 'All') {
      filtered = characters;
    } else {
      filtered = characters.where((c) => c.affiliation == affiliation).toList();
    }
    notifyListeners();
  }

  /// Carga detalle de un personaje
  Future<void> loadDetail(int id) async {
    loadingDetail = true;
    notifyListeners();

    selected = await _api.fetchById(id);

    loadingDetail = false;
    notifyListeners();
  }
}
