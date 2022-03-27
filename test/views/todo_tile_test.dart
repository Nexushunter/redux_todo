import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux_todo/features/models/models.dart';
import 'package:redux_todo/features/views/todo_tile.dart';

import '../mock_store.dart';

void main() {
  group('TodoTile', () {
    group('Can interact with', () {
      late MockStore mockStore;

      const t = Todo.empty;
      _verifyArg(Todo t) {
        return (todo) {
          expect(todo, t);
        };
      }

      setUpAll(() {
        mockStore = MockStore();
      });
      tearDownAll(() {
        reset(mockStore);
      });

      testWidgets('Name', (wT) async {
        final driver = MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TodoTile(
                  todo: t,
                  openCallback: _verifyArg(t),
                  editCallback: _verifyArg(t),
                  selectCallback: _verifyArg(t),
                ),
              ],
            ),
          ),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(Key('${t.uuid}-name'));
        expect(finder, findsOneWidget);

        await wT.tap(finder);
      });

      testWidgets('Timestamp', (wT) async {
        final driver = MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TodoTile(
                  todo: t,
                  openCallback: _verifyArg(t),
                  editCallback: _verifyArg(t),
                  selectCallback: _verifyArg(t),
                ),
              ],
            ),
          ),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(Key('${t.uuid}-creation-ts'));
        expect(finder, findsOneWidget);
        await wT.tap(finder);
      });

      testWidgets('Select box', (wT) async {
        final driver = MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TodoTile(
                  todo: t,
                  openCallback: _verifyArg(t),
                  editCallback: _verifyArg(t),
                  selectCallback: _verifyArg(t),
                ),
              ],
            ),
          ),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(Key('${t.uuid}-select-box'));
        expect(finder, findsOneWidget);
        await wT.tap(finder);
      });
    });
    group('Can find', () {
      late MockStore mockStore;

      const t = Todo.empty;
      _verifyArg(Todo t) {
        return (todo) {
          expect(todo, t);
        };
      }

      setUpAll(() {
        mockStore = MockStore();
      });
      tearDownAll(() {
        reset(mockStore);
      });

      testWidgets('Name', (wT) async {
        final driver = MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TodoTile(
                  todo: t,
                  openCallback: _verifyArg(t),
                  editCallback: _verifyArg(t),
                  selectCallback: _verifyArg(t),
                ),
              ],
            ),
          ),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(Key('${t.uuid}-name'));
        expect(finder, findsOneWidget);
      });

      testWidgets('Timestamp', (wT) async {
        final driver = MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TodoTile(
                  todo: t,
                  openCallback: _verifyArg(t),
                  editCallback: _verifyArg(t),
                  selectCallback: _verifyArg(t),
                ),
              ],
            ),
          ),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(Key('${t.uuid}-creation-ts'));
        expect(finder, findsOneWidget);
      });

      testWidgets('Select box', (wT) async {
        final driver = MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TodoTile(
                  todo: t,
                  openCallback: _verifyArg(t),
                  editCallback: _verifyArg(t),
                  selectCallback: _verifyArg(t),
                ),
              ],
            ),
          ),
        );

        await wT.pumpWidget(driver);
        final finder = find.byKey(Key('${t.uuid}-select-box'));
        expect(finder, findsOneWidget);
      });
    });
  });
}
