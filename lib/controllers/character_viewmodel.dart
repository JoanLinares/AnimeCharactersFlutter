import 'package:flutter/material.dart';

import '../models/series.dart';
import '../models/character_summary.dart';
import '../models/character_detail.dart';
import '../services/api_service.dart';

class CharacterViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool loading       = false;
  bool loadingDetail = false;

  /// 0 = All, 20 = Naruto, 21 = One Piece, 813 = Dragon Ball Z
  final List<Series> seriesList = [
    Series(id: 0,   name: 'All'),
    Series(id: 20,  name: 'Naruto'),
    Series(id: 21,  name: 'One Piece'),
    Series(id: 813, name: 'Dragon Ball Z'),
  ];
  int selectedSeriesId = 0;

  String _searchTerm                = '';
  List<CharacterSummary> characters = [];
  List<CharacterSummary> filtered   = [];

  CharacterDetail? selectedDetail;
  String          errorMessage     = '';

  /// Carga **todos** los personajes de la serie seleccionada.
  /// Si `animeId == 0`, carga de Naruto, One Piece y DBZ.
  Future<void> loadSeries(int animeId) async {
    loading = true;
    notifyListeners();

    try {
      selectedSeriesId = animeId;
      characters.clear();

      final targetIds = (animeId == 0) ? [20, 21, 813] : [animeId];
      for (final id in targetIds) {
        final list = await _api.fetchCharactersBySeries(id);
        characters.addAll(list);
      }

      // Inicialmente mostramos todos
      filtered = characters;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  /// Filtra localmente por nombre.
  void searchByName(String term) {
    _searchTerm = term.toLowerCase();
    filtered = characters
        .where((c) => c.name.toLowerCase().contains(_searchTerm))
        .toList();
    notifyListeners();
  }

  /// Carga detalle de un personaje.
  Future<void> loadDetail(int charId) async {
    loadingDetail = true;
    notifyListeners();

    try {
      selectedDetail = await _api.fetchCharacterDetail(charId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loadingDetail = false;
      notifyListeners();
    }
  }

  /// Helper para el dropdown.
  Future<void> selectSeries(int animeId) => loadSeries(animeId);

  /// Título actual de la serie seleccionada.
  String get seriesTitle =>
      seriesList.firstWhere((s) => s.id == selectedSeriesId).name;
}
