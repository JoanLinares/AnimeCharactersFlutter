import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/character_viewmodel.dart';
import '../widgets/search_bar.dart' as custom_widgets;
import '../widgets/loading_indicator.dart';
import '../widgets/series_filter_dropdown.dart';
import '../widgets/character_card.dart';
import '../widgets/error_dialog.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<CharacterViewModel>();
      vm.loadSeries(vm.selectedSeriesId).catchError(
        (e) => showError(context, e.toString()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Characters Explorer'),
      ),
      body: Column(
        children: [
          custom_widgets.SearchBar(onChanged: vm.searchByName),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: SeriesFilterDropdown(
              seriesList: vm.seriesList,
              selectedSeriesId: vm.selectedSeriesId,
              onSelected: (newId) {
                vm.selectSeries(newId)
                  .catchError((e) => showError(context, e.toString()));
              },
            ),
          ),

          Expanded(
            child: LoadingIndicator(
              loading: vm.loading,
              child: vm.filtered.isEmpty
                  ? const Center(
                      child: Text(
                        'No characters found',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: vm.filtered.length,
                      itemBuilder: (_, i) {
                        final ch = vm.filtered[i];
                        return CharacterCard(
                          character: ch,
                          onTap: () async {
                            await vm.loadDetail(ch.id).catchError(
                              (e) => showError(context, e.toString()),
                            );

                            if (mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CharacterDetailsView(
                                    characterId: ch.id.toString(),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}