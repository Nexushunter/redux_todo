import 'package:redux/redux.dart';

import 'models/models.dart';

class TodoStore extends Store<TodoState> {
  TodoStore(Reducer<TodoState> reducer, {required TodoState initialState})
      : super(
          reducer,
          initialState: initialState,
          // middleware: [
          //   LoggingMiddleware.printer(
          //       formatter: (lvl, msg, ts) => '$lvl $msg $ts')
          // ],
        );

  static TodoState todoReducer(TodoState state, dynamic action) {
    if (action is AddTodo) {
      return TodoState(
          todos: List.from(state.todos)
            ..add(action.todo)
            ..sort(_sort));
    } else if (action is SelectTodos) {
      if (action.selected.isEmpty) {
        return TodoState(
          todos: state.todos.map((e) => e.copyWith(selected: false)).toList(),
        );
      }

      final todos = <Todo>[];

      action.selected.forEach((e) => todos
          .add(e.copyWith(selected: action.allSelected ? true : !e.selected)));

      todos.addAll(state.todos.where(_shouldRetain(action.selected)));
      return TodoState(todos: todos..sort(_sort));
    } else if (action is RemoveTodos) {
      return TodoState(
          todos: List.from(state.todos)
            ..retainWhere(_shouldRetain(action.removed))
            ..sort(_sort));
    } else if (action is EditTodo) {
      return TodoState(
        todos: List.from(state.todos)
          ..removeWhere((element) => element.uuid == action.todo.uuid)
          ..add(
            action.todo.copyWith(
              name: action.name ?? action.todo.body,
              body: action.body ?? action.todo.body,
              favourite: action.favourite ?? action.todo.favourite,
              visible: action.visible ?? action.todo.visible,
            ),
          ),
      );
    } else {
      return state;
    }
  }

  static bool Function(Todo) _shouldRetain(List<Todo> todos) {
    return (e) {
      bool keep = true;

      for (final item in todos) {
        if (e.uuid == item.uuid) {
          keep = false;
          break;
        }
      }

      return keep;
    };
  }

  static int _sort(Todo a, Todo b) {
    return a.timeOfDay.compareTo(b.timeOfDay);
  }
}
