import 'package:flutter/material.dart';
import '../models/crew.dart';

class CrewFilterDropdown extends StatelessWidget {
  final List<Crew> crews;
  final ValueChanged<int> onSelected;
  const CrewFilterDropdown({super.key, required this.crews, required this.onSelected});

  @override
  Widget build(BuildContext c) {
    return DropdownButton<int>(
      value: 0,
      items: [
        const DropdownMenuItem(value: 0, child: Text('Todas')),
        ...crews.map((cr) => DropdownMenuItem(
          value: cr.id,
          child: Text(cr.name),
        )),
      ],
      onChanged: (value) {
        if (value != null) {
          onSelected(value);
        }
      },
    );
  }
}
