import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux_todo/features/models/models.dart';
import 'package:redux_todo/features/views/edit_page.dart';

import '../mock_store.dart';

void main() {
  group('Edit Page', () {
    group('Can Find', () {
      late MockStore mockStore;
      setUpAll(() {
        mockStore = MockStore();
      });
      tearDownAll(() {
        reset(mockStore);
      });

      testWidgets('Name', (wT) async {
        final driver = MaterialApp(
          home: EditPage(store: mockStore, todo: Todo.empty),
        );

        await wT.pumpWidget(driver);
        expect(find.byKey(const Key('edit-name-field')), findsOneWidget);
      });

      testWidgets('Body', (wT) async {
        final driver = MaterialApp(
          home: EditPage(store: mockStore, todo: Todo.empty),
        );

        await wT.pumpWidget(driver);
        expect(find.byKey(const Key('edit-body-field')), findsOneWidget);
      });
      testWidgets('Favourite', (wT) async {
        final driver = MaterialApp(
          home: EditPage(store: mockStore, todo: Todo.empty),
        );

        await wT.pumpWidget(driver);
        expect(find.byKey(const Key('favourite-button')), findsOneWidget);
      });

      testWidgets('visible', (wT) async {
        final driver = MaterialApp(
          home: EditPage(store: mockStore, todo: Todo.empty),
        );

        await wT.pumpWidget(driver);
        expect(find.byKey(const Key('visible-button')), findsOneWidget);
      });
    });

    // TODO: Handle mocked interactions
    group('Can interact with', () {
      late MockStore mockStore;
      setUpAll(() {
        mockStore = MockStore();
      });
      tearDownAll(() {
        reset(mockStore);
      });

      testWidgets('Name', (wT) async {
        final driver = MaterialApp(
          home: EditPage(store: mockStore, todo: Todo.empty),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(const Key('edit-name-field'));
        expect(finder, findsOneWidget);

        await wT.enterText(finder, 'text');
        await wT.pumpAndSettle();

        expect(find.text(Todo.empty.name + 'text'), findsOneWidget);
      });

      testWidgets('Body', (wT) async {
        final driver = MaterialApp(
          home: EditPage(store: mockStore, todo: Todo.empty),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(const Key('edit-body-field'));
        expect(finder, findsOneWidget);

        await wT.enterText(finder, 'text');
        await wT.pumpAndSettle();

        expect(find.text(Todo.empty.name + 'text'), findsOneWidget);
      });
      testWidgets('Favourite', (wT) async {
        final driver = MaterialApp(
          home: EditPage(store: mockStore, todo: Todo.empty),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(const Key('favourite-button'));
        expect(finder, findsOneWidget);

        expect(find.byIcon(Icons.star_border), findsOneWidget);
        await wT.tap(finder);
        await wT.pumpAndSettle();
        expect(find.byIcon(Icons.star_rate), findsOneWidget);
        await wT.tap(finder);
        await wT.pumpAndSettle();
        expect(find.byIcon(Icons.star_border), findsOneWidget);
      });

      testWidgets('visible', (wT) async {
        final driver = MaterialApp(
          home: EditPage(store: mockStore, todo: Todo.empty),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(const Key('visible-button'));
        expect(finder, findsOneWidget);

        expect(find.byIcon(Icons.visibility), findsOneWidget);
        await wT.tap(finder);
        await wT.pumpAndSettle();
        expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
        await wT.tap(finder);
        await wT.pumpAndSettle();
        expect(find.byIcon(Icons.visibility), findsOneWidget);
      });
    });
  });
}
