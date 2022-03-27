import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'models/models.dart';

class TodoStore extends Store<TodoState> {
  TodoStore({TodoState? state})
      : super(todoReducer, initialState: state ?? TodoState.empty);

  /// Reduces manipulate the state of the store.
  ///
  /// This reducer handles the manipulation of the Currently active todos
  static TodoState todoReducer(TodoState state, dynamic action) {
    if (action is AddTodo) {
      return TodoState(
          todos: List.from(state.todos)
            ..add(action.todo)
            ..sort(sort));
    } else if (action is SelectTodos) {
      if (action.allSelected) {
        return TodoState(
            todos: state.todos.map((e) => e.copyWith(selected: true)).toList());
      }
      if (action.selected.isEmpty) {
        return TodoState(
          todos: state.todos.map((e) => e.copyWith(selected: false)).toList(),
        );
      }

      final todos = <Todo>[];

      action.selected.forEach((e) => todos
          .add(e.copyWith(selected: action.allSelected ? true : !e.selected)));

      todos.addAll(state.todos.where(ignoreList(action.selected)));
      return TodoState(todos: todos..sort(sort));
    } else if (action is RemoveTodos) {
      return TodoState(
          todos: List.from(state.todos)
            ..retainWhere(ignoreList(action.removed))
            ..sort(sort));
    } else if (action is EditTodo) {
      return TodoState(
        todos: List.from(state.todos)
          ..removeWhere((element) => element.uuid == action.todo.uuid)
          ..add(
            action.todo.copyWith(
              name: action.name ?? action.todo.name,
              body: action.body ?? action.todo.body,
              favourite: action.favourite ?? action.todo.favourite,
              visible: action.visible ?? action.todo.visible,
            ),
          )
          ..sort(sort),
      );
    } else {
      return state;
    }
  }

  @visibleForTesting
  static bool Function(Todo) ignoreList(List<Todo> todos) {
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

  @visibleForTesting
  static int sort(Todo a, Todo b) {
    return a.timeOfDay.compareTo(b.timeOfDay);
  }
}
