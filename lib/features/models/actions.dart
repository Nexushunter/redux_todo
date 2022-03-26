import 'todo.dart';

abstract class TodoAction {}

class SelectTodos extends TodoAction {
  final List<Todo> selected;
  SelectTodos({this.selected = const []}) : super();
}

class AddTodo extends TodoAction {
  final Todo todo;
  AddTodo({this.todo = Todo.empty}) : super();
}

class RemoveTodos extends TodoAction {
  final List<Todo> removed;
  RemoveTodos({this.removed = const []}) : super();
}

class SetVisibility extends TodoAction {
  final bool isVisible;
  final int index;
  SetVisibility({required this.index, this.isVisible = true}) : super();
}

class EditTodo extends TodoAction {
  final String? name;
  final String? body;
  final Todo todo;
  final bool? visible;
  final bool? favourite;

  EditTodo(
    this.todo, {
    this.name,
    this.body,
    this.visible,
    this.favourite,
  }) : super();
}
