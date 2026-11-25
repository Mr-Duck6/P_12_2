import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_provider.dart';
import '../widgets/movie_search_bar.dart';
import '../widgets/movie_grid.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Catalog'),
        actions: [
          IconButton(
            key: const Key('favorites_navigation'),
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: MovieSearchBar(),
          ),
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final movies = provider.hasSearched
                    ? provider.searchResults
                    : provider.movies;

                return MovieGrid(
                  movies: movies,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
