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
  int    selectedSeriesId = 0;

  String _searchTerm               = '';
  List<CharacterSummary> characters = [];
  List<CharacterSummary> filtered   = [];

  CharacterDetail? selectedDetail;
  String          errorMessage     = '';

  /// 50 characters for serie
  Future<void> loadSeries(int animeId) async {
    loading = true;
    notifyListeners();

    try {
      selectedSeriesId = animeId;
      characters.clear();

      final targetIds = animeId == 0
        ? [20, 21, 813]
        : [animeId];

      for (var id in targetIds) {
        final list = await _api.fetchCharactersBySeries(id);
        characters.addAll(list.take(50));
      }

      // initial filtered = all
      filtered = characters;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void searchByName(String term) {
    _searchTerm = term.toLowerCase();
    filtered = characters.where((c) {
      return c.name.toLowerCase().contains(_searchTerm);
    }).toList();
    notifyListeners();
  }

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

  Future<void> selectSeries(int animeId) => loadSeries(animeId);

  String get seriesTitle =>
    seriesList.firstWhere((s) => s.id == selectedSeriesId).name;
}
