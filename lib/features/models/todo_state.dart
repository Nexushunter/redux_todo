import 'package:freezed_annotation/freezed_annotation.dart';

import 'todo.dart';

part 'todo_state.freezed.dart';
part 'todo_state.g.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({required List<Todo> todos}) = _TodoState;
  factory TodoState.fromJson(Map<String, dynamic> json) =>
      _$TodoStateFromJson(json);
}
