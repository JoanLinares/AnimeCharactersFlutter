// lib/views/character_details_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/character_viewmodel.dart';

class CharacterDetailsView extends StatefulWidget {
  const CharacterDetailsView({Key? key}) : super(key: key);

  @override
  State<CharacterDetailsView> createState() => _CharacterDetailsViewState();
}

class _CharacterDetailsViewState extends State<CharacterDetailsView>
    with SingleTickerProviderStateMixin {
  bool _showDescription = false;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();
    final d  = vm.selectedDetail;
    if (d == null || vm.loadingDetail) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Only the first paragraph
    final firstParagraph = d.about.split(RegExp(r'\r?\n\r?\n')).first;

    return Scaffold(
      appBar: AppBar(title: Text(vm.seriesTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: d.imageUrl,
                  height: 260,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const SizedBox(
                    height: 260,
                    child: Center(child: CircularProgressIndicator())),
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.error, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Name
            Center(
              child: Text(
                d.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
              ),
            ),
            if (d.nameKanji.isNotEmpty) ...[
              const SizedBox(height: 4),
              Center(
                child: Text(
                  d.nameKanji,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            // Favorites
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 6),
                  Text(
                    '${d.favorites}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Description toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () => setState(() => _showDescription = !_showDescription),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Icon(
                      _showDescription
                          ? Icons.expand_less
                          : Icons.expand_more,
                    ),
                  ],
                ),
              ),
            ),
            // Animated reveal
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  firstParagraph,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                      ),
                  textAlign: TextAlign.justify,
                ),
              ),
              crossFadeState: _showDescription
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
