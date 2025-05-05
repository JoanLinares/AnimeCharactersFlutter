import 'package:flutter/material.dart';

class AffiliationFilterDropdown extends StatelessWidget {
  final List<String> affiliations;
  final String selectedAffiliation;
  final ValueChanged<String> onSelected;

  const AffiliationFilterDropdown({
    Key? key,
    required this.affiliations,
    required this.selectedAffiliation,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedAffiliation,
      isExpanded: true,
      items: affiliations.map((a) {
        return DropdownMenuItem<String>(
          value: a,
          child: Text(a),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) onSelected(value);
      },
    );
  }
}
