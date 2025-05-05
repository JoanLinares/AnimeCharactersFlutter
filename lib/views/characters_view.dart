import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/character_viewmodel.dart';
import '../widgets/character_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_dialog.dart';
import '../widgets/afilliation_filter_dropdown.dart';
import 'character_details_view.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    final vm = context.read<CharacterViewModel>();
    vm.loadAll().catchError((e) => showError(context, e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Dragon Ball Characters')),
      body: LoadingIndicator(
        loading: vm.loading,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AffiliationFilterDropdown(
                affiliations: vm.affiliations,
                selectedAffiliation: vm.selectedAffiliation,
                onSelected: vm.filterByAffiliation,
              ),
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
                itemBuilder: (_, i) {
                  final ch = vm.filtered[i];
                  return CharacterCard(
                    character: ch,
                    onTap: () async {
                      await vm
                          .loadDetail(ch.id)
                          .catchError((e) => showError(context, e.toString()));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CharacterDetailsView(),
                        ),
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
