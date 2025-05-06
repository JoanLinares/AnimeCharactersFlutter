import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controllers/character_viewmodel.dart';

class CharacterDetailsView extends StatefulWidget {
  final String characterId;

  const CharacterDetailsView({Key? key, required this.characterId})
      : super(key: key);

  @override
  State<CharacterDetailsView> createState() => _CharacterDetailsViewState();
}

class _CharacterDetailsViewState extends State<CharacterDetailsView>
    with SingleTickerProviderStateMixin {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    final vm     = context.watch<CharacterViewModel>();
    final detail = vm.selectedDetail;

    if (detail == null || vm.loadingDetail) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Solo la primera sección de metadata
    final metadataSection = detail.about.split(RegExp(r'\r?\n\r?\n')).first;
    final lines = metadataSection
        .split(RegExp(r'\r?\n'))
        .where((l) => l.trim().isNotEmpty)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Hero(
              tag: 'char_image_${detail.id}',
              child: CachedNetworkImage(
                imageUrl: detail.imageUrl,
                fit: BoxFit.contain,
                placeholder: (_, __) => const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) =>
                    const SizedBox(
                      height: 200,
                      child: Center(child: Icon(Icons.error, size: 80)),
                    ),
              ),
            ),
            const SizedBox(height: 20),

            // Nombre del personaje
            Text(
              detail.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),

            // Sección Details (desplegable)
            Material(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => setState(() => _showDetails = !_showDetails),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Details',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Icon(
                        _showDetails
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Solo mostramos el bloque metadata definido
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: lines.map((line) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          line,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              crossFadeState: _showDetails
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}