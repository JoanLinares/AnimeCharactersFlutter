import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/character_viewmodel.dart';

class CharacterDetailsView extends StatelessWidget {
  const CharacterDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();
    final ch = vm.selected;

    if (ch == null || vm.loadingDetail) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(ch.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            Image.network(ch.image, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),

            // Datos básicos
            Text('Name: ${ch.name}', style: Theme.of(context).textTheme.titleLarge),
            Text('Affiliation: ${ch.affiliation}',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('Race: ${ch.race}', style: Theme.of(context).textTheme.bodyMedium),
            Text('Gender: ${ch.gender}', style: Theme.of(context).textTheme.bodyMedium),
            Text('Ki: ${ch.ki}/${ch.maxKi}',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),

            // Descripción
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              ch.description.isNotEmpty ? ch.description : 'No description available.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Planeta de origen
            ExpansionTile(
              leading: ch.originPlanet.image.isNotEmpty
                  ? Image.network(
                      ch.originPlanet.image,
                      width: 32,
                      errorBuilder: (_, __, ___) => const Icon(Icons.public),
                    )
                  : const Icon(Icons.public),
              title: Text('Origin: ${ch.originPlanet.name}'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(ch.originPlanet.description),
                ),
                ListTile(
                  title: Text(
                      'Destroyed: ${ch.originPlanet.isDestroyed ? "Yes" : "No"}'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Transformaciones
            ExpansionTile(
              leading: const Icon(Icons.transform),
              title: const Text('Transformations'),
              children: ch.transformations.map((t) {
                return ListTile(
                  leading: t.image.isNotEmpty
                      ? Image.network(
                          t.image,
                          width: 32,
                          errorBuilder: (_, __, ___) => const Icon(Icons.error),
                        )
                      : const Icon(Icons.error),
                  title: Text(t.name),
                  subtitle: Text('Ki: ${t.ki}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
