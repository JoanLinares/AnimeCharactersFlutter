import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes/app_theme.dart';
import 'controllers/character_viewmodel.dart';
import 'views/characters_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CharacterViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    title: 'Anime Characters',
    theme: appTheme,
    home: const CharactersView(),
  );
}
