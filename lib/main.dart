import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/movie_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: const MovieCatalogApp(),
    ),
  );
}

class MovieCatalogApp extends StatelessWidget {
  const MovieCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
