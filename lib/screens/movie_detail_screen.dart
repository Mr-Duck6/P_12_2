import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/movie_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        actions: [
          IconButton(
            key: const Key('share_button'),
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sharing ${movie.title}'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                movie.posterUrl,
                height: 250,
                width: 180,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return const SizedBox(
                    height: 250,
                    width: 180,
                    child: Center(
                      child: Icon(
                        Icons.movie,
                        size: 100,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.title,
              key: const Key('detail_title'),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text('Year: ${movie.year}'),
            Text('Genre: ${movie.genre}'),
            Text('Director: ${movie.director}'),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Rating: '),
                IgnorePointer(
                  key: const Key('rating_bar'),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: index < (movie.rating / 2).round()
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(movie.rating.toString()),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              movie.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Consumer<MovieProvider>(
              builder: (context, provider, child) {
                final isFavorite = provider.isFavorite(movie);

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    key: const Key('favorite_button'),
                    onPressed: () {
                      provider.toggleFavorite(movie);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    label: Text(
                      isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
