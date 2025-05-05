import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character char;
  final VoidCallback onTap;
  const CharacterCard({super.key, required this.char, required this.onTap});

  @override
  Widget build(BuildContext c) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: Image.network(char.image, fit: BoxFit.cover, width: double.infinity),
            ),
            const SizedBox(height: 4),
            Text(char.name, style: Theme.of(c).textTheme.titleLarge, textAlign: TextAlign.center),
            Text(char.crew.name, style: Theme.of(c).textTheme.bodyMedium),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
