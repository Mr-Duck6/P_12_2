import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  final List<Movie> _movies = [
    const Movie(
      id: 1,
      title: 'Inception',
      description:
          'A thief who steals corporate secrets through dream-sharing technology.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
      rating: 8.8,
      year: '2010',
      genre: 'Sci-Fi',
      director: 'Christopher Nolan',
    ),
    const Movie(
      id: 2,
      title: 'Interstellar',
      description:
          'A team of explorers travels beyond this galaxy to discover a new home.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
      rating: 8.7,
      year: '2014',
      genre: 'Adventure',
      director: 'Christopher Nolan',
    ),
    const Movie(
      id: 3,
      title: 'The Dark Knight',
      description:
          'Batman faces the Joker, a criminal mastermind spreading chaos in Gotham.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      rating: 9.0,
      year: '2008',
      genre: 'Action',
      director: 'Christopher Nolan',
    ),
    const Movie(
      id: 4,
      title: 'Avatar',
      description: 'A marine explores the alien world of Pandora.',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg',
      rating: 7.9,
      year: '2009',
      genre: 'Fantasy',
      director: 'James Cameron',
    ),
  ];

  List<Movie> _searchResults = [];
  final List<Movie> _favorites = [];

  bool _isLoading = false;
  bool _hasSearched = false;
  String _query = '';

  List<Movie> get movies => _movies;

  List<Movie> get searchResults => _searchResults;

  List<Movie> get favorites => _favorites;

  bool get isLoading => _isLoading;

  bool get hasSearched => _hasSearched;

  String get query => _query;

  Future<void> searchMovies(String query) async {
    _query = query.trim();

    if (_query.length < 2) {
      _searchResults = [];
      _isLoading = false;
      _hasSearched = false;
      notifyListeners();
      return;
    }

    _hasSearched = true;
    _isLoading = true;
    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    _searchResults = _movies.where((movie) {
      return movie.title.toLowerCase().contains(
            _query.toLowerCase(),
          );
    }).toList();

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    _searchResults = [];
    _isLoading = false;
    _hasSearched = false;

    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favorites.any(
      (item) => item.id == movie.id,
    );
  }

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie)) {
      _favorites.removeWhere(
        (item) => item.id == movie.id,
      );
    } else {
      _favorites.add(movie);
    }

    notifyListeners();
  }
}
