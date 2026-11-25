import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:movie_catalog/models/movie.dart';
import 'package:movie_catalog/providers/movie_provider.dart';
import 'package:movie_catalog/screens/movie_detail_screen.dart';

const testMovie = Movie(
  id: 100,
  title: 'Test Movie',
  description: 'Test description',
  posterUrl: 'http://127.0.0.1:1/invalid.jpg',
  rating: 8.5,
  year: '2024',
  genre: 'Action',
  director: 'Test Director',
);

Widget createDetailWidget() {
  return ChangeNotifierProvider(
    create: (_) => MovieProvider(),
    child: const MaterialApp(
      home: MovieDetailScreen(
        movie: testMovie,
      ),
    ),
  );
}

void main() {
  testWidgets(
    'All movie information is displayed',
    (tester) async {
      await tester.pumpWidget(createDetailWidget());

      expect(find.text('Test Movie'), findsOneWidget);
      expect(find.text('Year: 2024'), findsOneWidget);
      expect(find.text('Genre: Action'), findsOneWidget);
      expect(find.text('Director: Test Director'), findsOneWidget);
      expect(find.text('Test description'), findsOneWidget);
      expect(find.text('8.5'), findsOneWidget);
    },
  );

  testWidgets(
    'Favorite icon changes after button tap',
    (tester) async {
      await tester.pumpWidget(createDetailWidget());

      expect(
        find.text('Add to Favorites'),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.favorite_border),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(const Key('favorite_button')),
      );

      await tester.pump();

      expect(
        find.text('Remove from Favorites'),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.favorite),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.favorite_border),
        findsNothing,
      );
    },
  );

  testWidgets(
    'Rating bar is not interactive',
    (tester) async {
      await tester.pumpWidget(createDetailWidget());

      final ratingBar = tester.widget<IgnorePointer>(
        find.byKey(const Key('rating_bar')),
      );

      expect(
        ratingBar.ignoring,
        isTrue,
      );

      expect(
        find.byIcon(Icons.star),
        findsNWidgets(5),
      );
    },
  );

  testWidgets(
    'Share button is displayed',
    (tester) async {
      await tester.pumpWidget(createDetailWidget());

      expect(
        find.byKey(const Key('share_button')),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.share),
        findsOneWidget,
      );
    },
  );
}
