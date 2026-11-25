import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_provider.dart';

class MovieSearchBar extends StatefulWidget {
  const MovieSearchBar({super.key});

  @override
  State<MovieSearchBar> createState() => _MovieSearchBarState();
}

class _MovieSearchBarState extends State<MovieSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            TextField(
              key: const Key('movie_search_field'),
              controller: _controller,
              onChanged: provider.searchMovies,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: provider.query.isNotEmpty
                    ? IconButton(
                        key: const Key('clear_search_button'),
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          provider.clearSearch();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            if (provider.isLoading)
              const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(
                  key: Key('search_loading'),
                ),
              ),
            if (provider.hasSearched &&
                !provider.isLoading &&
                provider.searchResults.isEmpty)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'No results',
                  key: Key('no_results'),
                ),
              ),
          ],
        );
      },
    );
  }
}
