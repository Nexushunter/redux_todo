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
      return TodoState(todos: action.selected..sort(_sort));
    } else if (action is RemoveTodos) {
      return TodoState(
          todos: List.from(state.todos)
            ..retainWhere((e) {
              return true;
            })
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

  static int _sort(Todo a, Todo b) {
    return a.timeOfDay.compareTo(b.timeOfDay);
  }
}
