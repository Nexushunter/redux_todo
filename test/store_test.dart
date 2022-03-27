import 'package:flutter_test/flutter_test.dart';
import 'package:redux_todo/features/models/models.dart';
import 'package:redux_todo/features/store.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('TodoStore', () {
    final todos = <Todo>[];
    for (int i = 0; i < 9; i++) {
      todos.add(
        Todo(
          name: '$i',
          body: '',
          visible: true,
          selected: false,
          uuid: const Uuid().v4(),
          timeOfDay: i,
          favourite: false,
        ),
      );
    }
    group('todoReducer handles', () {
      test('Add', () {
        const expectedState = TodoState(todos: [Todo.empty]);
        expect(
            TodoStore.todoReducer(TodoState.empty, AddTodo()), expectedState);
      });
      group('Select', () {
        test('All (W/o Flag)', () {
          final expectedState = TodoState(
            todos: todos.map((e) => e.copyWith(selected: !e.selected)).toList(),
          );

          expect(
              TodoStore.todoReducer(
                  TodoState(todos: todos), SelectTodos(selected: todos)),
              expectedState);
        });
        test('All (W/Flag)', () {
          final expectedState = TodoState(
            todos: todos.map((e) => e.copyWith(selected: true)).toList(),
          );

          expect(
              TodoStore.todoReducer(TodoState(todos: todos),
                  SelectTodos(selected: [], allSelected: true)),
              expectedState);
          expect(
              TodoStore.todoReducer(TodoState(todos: todos),
                  SelectTodos(selected: todos, allSelected: true)),
              expectedState);
        });

        test('Multiselect', () {
          final expectedState = TodoState(
            todos: todos
                .map((e) => (e.timeOfDay < 6) ? e.copyWith(selected: true) : e)
                .toList(),
          );

          expect(
              TodoStore.todoReducer(TodoState(todos: todos),
                  SelectTodos(selected: todos.sublist(0, 6))),
              expectedState);
        });
      });
      group('Update todo fields:', () {
        test('Single', () {
          final expectedState = TodoState(
              todos: todos
                  .map(
                    (e) => e.timeOfDay == 0 ? e.copyWith(favourite: true) : e,
                  )
                  .toList());
          expect(
              TodoStore.todoReducer(
                  TodoState(todos: todos), EditTodo(todos[0], favourite: true)),
              expectedState);
        });
        test('Multi', () {
          final expectedState = TodoState(
              todos: todos
                  .map(
                    (e) => e.timeOfDay == 0
                        ? e.copyWith(
                            favourite: true, name: 'Updates', visible: false)
                        : e,
                  )
                  .toList());
          expect(
              TodoStore.todoReducer(
                  TodoState(todos: todos),
                  EditTodo(todos[0],
                      favourite: true, name: 'Updates', visible: false)),
              expectedState);
        });
      });
      test('Remove', () {
        final expectedState = TodoState(
          todos: todos
              .map((e) => (e.timeOfDay < 6) ? e.copyWith(selected: true) : e)
              .toList(),
        );

        expect(
            TodoStore.todoReducer(TodoState(todos: todos),
                SelectTodos(selected: todos.sublist(0, 6))),
            expectedState);
      });
      test('Defaults', () {
        expect(
          TodoStore.todoReducer(
            TodoState(todos: todos),
            Exception('This is useless hahhahahaha'),
          ),
          TodoState(todos: todos),
        );
      });
    });
    test('Sort', () {
      final t = Todo(
        name: '',
        body: '',
        visible: true,
        selected: false,
        uuid: const Uuid().v4(),
        timeOfDay: 1,
        favourite: false,
      );

      expect(TodoStore.sort(t, Todo.empty), 1);
    });
    test('ignoreList', () {
      expect(
          todos.where(
            TodoStore.ignoreList(todos.sublist(0, 5)),
          ),
          todos.sublist(5));
    });
  });
}
