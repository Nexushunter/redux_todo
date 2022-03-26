import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String name,
    required bool visible,
    required bool selected,
    required String body,
    required int timeOfDay,
    required String uuid,
    required bool favourite,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  static const Todo empty = Todo(
    name: '',
    visible: true,
    selected: false,
    body: '',
    timeOfDay: 0,
    uuid: 'EMPTY',
    favourite: false,
  );
}
