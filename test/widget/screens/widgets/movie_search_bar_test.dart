import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:movie_catalog/providers/movie_provider.dart';
import 'package:movie_catalog/widgets/movie_search_bar.dart';

Widget createTestWidget() {
  return ChangeNotifierProvider(
    create: (_) => MovieProvider(),
    child: const MaterialApp(
      home: Scaffold(
        body: MovieSearchBar(),
      ),
    ),
  );
}

void main() {
  testWidgets(
    'Search starts after entering 2 characters',
    (tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(
        find.byKey(const Key('movie_search_field')),
        'In',
      );

      await tester.pump();

      expect(
        find.byKey(const Key('search_loading')),
        findsOneWidget,
      );

      await tester.pump(
        const Duration(milliseconds: 500),
      );
      await tester.pump();
    },
  );

  testWidgets(
    'Search does not start with 1 character',
    (tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(
        find.byKey(const Key('movie_search_field')),
        'I',
      );

      await tester.pump();

      expect(
        find.byKey(const Key('search_loading')),
        findsNothing,
      );

      expect(
        find.byKey(const Key('no_results')),
        findsNothing,
      );
    },
  );

  testWidgets(
    'Clear button appears when text is entered',
    (tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(
        find.byKey(const Key('movie_search_field')),
        'In',
      );

      await tester.pump();

      expect(
        find.byKey(const Key('clear_search_button')),
        findsOneWidget,
      );

      await tester.pump(
        const Duration(milliseconds: 500),
      );
      await tester.pump();
    },
  );

  testWidgets(
    'Loading indicator appears during search',
    (tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(
        find.byKey(const Key('movie_search_field')),
        'Avatar',
      );

      await tester.pump();

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );

      await tester.pump(
        const Duration(milliseconds: 500),
      );
      await tester.pump();
    },
  );

  testWidgets(
    'No results message appears for empty search results',
    (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Вводимо назву фільму, якого немає в каталозі
      await tester.enterText(
        find.byKey(const Key('movie_search_field')),
        'Unknown Movie',
      );

      // Запускаємо оновлення інтерфейсу
      await tester.pump();

      // Очікуємо завершення пошуку (400 мс)
      await tester.pump(
        const Duration(milliseconds: 500),
      );

      // Оновлюємо інтерфейс після завершення пошуку
      await tester.pump();

      expect(
        find.byKey(const Key('no_results')),
        findsOneWidget,
      );

      expect(
        find.text('No results'),
        findsOneWidget,
      );
    },
  );
}
