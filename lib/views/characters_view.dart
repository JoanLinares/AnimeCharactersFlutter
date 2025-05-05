import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import '../controllers/character_viewmodel.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_dialog.dart';
import '../widgets/search_bar.dart';
import '../widgets/crew_filter_dropdown.dart';
import '../widgets/character_card.dart';
import 'character_details_view.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});
  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    final vm = context.read<CharacterViewModel>();
    vm.loadInitialData()
      .catchError((e) => showError(context, e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('One Piece Explorer')),
      body: LoadingIndicator(
        loading: vm.loading,
        child: Column(
          children: [
            SearchBar(onChanged: vm.searchByName),
            CrewFilterDropdown(
              crews: vm.crews,
              onSelected: (id) => vm.filterByCrew(id)
                .catchError((e) => showError(context, e.toString())),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.65,
                ),
                itemCount: vm.filtered.length,
                itemBuilder: (ctx, i) {
                  final ch = vm.filtered[i];
                  return CharacterCard(
                    character: ch,
                    onTap: () async {
                      await vm.loadDetails(ch.id)
                        .catchError((e) => showError(context, e.toString()));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CharacterDetailsView()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
