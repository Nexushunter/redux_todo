import 'package:flutter_test/flutter_test.dart';
import 'package:redux_todo/features/models/models.dart';

void main() {
  test('Empty Todo', () {
    expect(
        Todo.empty,
        const Todo(
          name: '',
          visible: true,
          selected: false,
          body: '',
          timeOfDay: 0,
          uuid: 'EMPTY',
          favourite: false,
        ));
  });

  test('Empty TodoState', () {
    expect(TodoState.empty, const TodoState(todos: []));
  });
}
