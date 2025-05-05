import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/character_viewmodel.dart';

class CharacterDetailsView extends StatefulWidget {
  const CharacterDetailsView({Key? key}) : super(key: key);

  @override
  State<CharacterDetailsView> createState() => _CharacterDetailsViewState();
}

class _CharacterDetailsViewState extends State<CharacterDetailsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();
    final ch = vm.selected;

    if (ch == null || vm.loadingDetails) {
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
            // Card base
            Card(
              clipBehavior: Clip.antiAlias,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Image.network(
                    ch.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                  ),
                  ListTile(
                    title: Text(ch.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    subtitle: Text('Job: ${ch.job}\nStatus: ${ch.status}'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Historia (placeholder si no tienes endpoint específico)
            Text('Historia',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              ch.description.isNotEmpty
                  ? ch.description
                  : 'No hay información de historia disponible.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 16),

            // Devil Fruit
            if (ch.fruit != null)
              ExpansionTile(
                leading: Image.network(
                  ch.fruit!.filename,
                  width: 32,
                  errorBuilder: (_, __, ___) => const Icon(Icons.error),
                ),
                title: Text('Devil Fruit: ${ch.fruit!.name}'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(ch.fruit!.description),
                  ),
                  ListTile(
                    title: const Text('Type'),
                    subtitle: Text(ch.fruit!.type),
                  ),
                ],
              ),

            const SizedBox(height: 8),

            // Haki
            ExpansionTile(
              leading: const Icon(Icons.flash_on),
              title: const Text('Hakis'),
              children: vm.hakis
                  .map((h) => ListTile(
                        title: Text(h.name),
                        subtitle: Text('Type: ${h.type}'),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
