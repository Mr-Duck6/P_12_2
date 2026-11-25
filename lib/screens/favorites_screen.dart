import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_provider.dart';
import '../widgets/movie_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorites yet',
                key: Key('empty_favorites'),
              ),
            );
          }

          return MovieGrid(
            movies: provider.favorites,
          );
        },
      ),
    );
  }
}
