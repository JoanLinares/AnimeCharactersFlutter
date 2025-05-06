import 'package:flutter/material.dart';
import '../models/series.dart';

/// Dropdown para seleccionar la serie (One Piece, Naruto, DBZ, DBS…)
class SeriesFilterDropdown extends StatelessWidget {
  final List<Series> seriesList;
  final int selectedSeriesId;
  final ValueChanged<int> onSelected;

  const SeriesFilterDropdown({
    super.key,
    required this.seriesList,
    required this.selectedSeriesId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedSeriesId,
      isExpanded: true,
      items: seriesList.map((s) {
        return DropdownMenuItem<int>(
          value: s.id,
          child: Text(s.name),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onSelected(value);
        }
      },
    );
  }
}