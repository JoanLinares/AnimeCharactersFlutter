import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/character_summary.dart';

class CharacterCard extends StatelessWidget {
  final CharacterSummary character;
  final VoidCallback    onTap;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Fija un alto para que la grid reserve ese espacio
            SizedBox(
              height: 100,
              child: CachedNetworkImage(
                imageUrl: character.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                errorWidget: (_, __, ___) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),

            // Nombre
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                character.name,
                style: Theme.of(c).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
