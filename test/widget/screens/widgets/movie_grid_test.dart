import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:movie_catalog/models/movie.dart';
import 'package:movie_catalog/providers/movie_provider.dart';
import 'package:movie_catalog/widgets/movie_grid.dart';

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

Widget createGridWidget() {
  return ChangeNotifierProvider(
    create: (_) => MovieProvider(),
    child: const MaterialApp(
      home: Scaffold(
        body: MovieGrid(
          movies: [testMovie],
        ),
      ),
    ),
  );
}

void main() {
  testWidgets(
    'MovieGrid has 2 columns',
    (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(createGridWidget());

      final grid = tester.widget<GridView>(
        find.byKey(const Key('movie_grid')),
      );

      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisCount, 2);

      expect(
        find.byType(GridView),
        findsOneWidget,
      );

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    },
  );

  testWidgets(
    'Movie title and rating are displayed',
    (tester) async {
      await tester.pumpWidget(createGridWidget());

      expect(
        find.text('Test Movie'),
        findsOneWidget,
      );

      expect(
        find.text('8.5'),
        findsOneWidget,
      );

      expect(
        find.byIcon(Icons.star),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Poster placeholder appears when image fails',
    (tester) async {
      await tester.pumpWidget(createGridWidget());

      await tester.pump();

      await tester.pump(
        const Duration(seconds: 2),
      );

      expect(
        find.byKey(const Key('poster_placeholder')),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Tapping movie card opens detail screen',
    (tester) async {
      await tester.pumpWidget(createGridWidget());

      await tester.tap(
        find.byKey(const Key('movie_card_100')),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('Movie Details'),
        findsOneWidget,
      );

      expect(
        find.text('Test Movie'),
        findsOneWidget,
      );

      expect(
        find.text('Year: 2024'),
        findsOneWidget,
      );
    },
  );
}
