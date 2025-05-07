import 'package:flutter/material.dart';
import '../models/series.dart';
import '../models/character_summary.dart';
import '../models/character_detail.dart';
import '../services/api_service.dart';
import '../utils/network_utils.dart';

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

  // Get Characters from serie 
  Future<void> loadSeries(int animeId) async {
    loading = true;
    notifyListeners();

    try {
      if (!await hasConnection()) {
        throw Exception('No hay conexión a Internet');
      }

      selectedSeriesId = animeId;
      characters.clear();

      final targetIds = (animeId == 0) ? [20, 21, 813] : [animeId];
      for (final id in targetIds) {
        final list = await _api.fetchCharactersBySeries(id);
        characters.addAll(list);
      }

      // Aplicar filtro inicial ALL
      filtered = List.from(characters);
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Filter by name
  void searchByName(String term) {
    _searchTerm = term.toLowerCase();
    filtered = characters
        .where((c) => c.name.toLowerCase().contains(_searchTerm))
        .toList();
    notifyListeners();
  }

  // Character details
  Future<void> loadDetail(int charId) async {
    loadingDetail = true;
    notifyListeners();

    try {
      if (!await hasConnection()) {
        throw Exception('No hay conexión a Internet');
      }
      selectedDetail = await _api.fetchCharacterDetail(charId);
    } catch (e) {
      rethrow;
    } finally {
      loadingDetail = false;
      notifyListeners();
    }
  }

  /// Helper para el dropdown.
  Future<void> selectSeries(int animeId) => loadSeries(animeId);

  /// Título de la serie seleccionada.
  String get seriesTitle =>
      seriesList.firstWhere((s) => s.id == selectedSeriesId).name;
}