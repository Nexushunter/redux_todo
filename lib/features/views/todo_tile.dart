import 'package:flutter/material.dart';

import '../models/models.dart';

typedef void TodoCallback(Todo todo);

class TodoTile extends StatelessWidget {
  final Todo todo;
  final TodoCallback openCallback;
  final TodoCallback editCallback;
  final TodoCallback selectCallback;
  TodoTile({
    required this.todo,
    required this.openCallback,
    required this.editCallback,
    required this.selectCallback,
  }) : super(key: Key('${todo.uuid}-tile'));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        key: Key('${todo.uuid}-select-box'),
        value: todo.selected,
        onChanged: (checked) => selectCallback(todo),
      ),
      title: Text(
        todo.name,
        key: Key('${todo.uuid}-name'),
      ),
      subtitle: Text(
        DateTime.fromMillisecondsSinceEpoch(todo.timeOfDay)
            .toLocal()
            .toString(),
        key: Key(todo.uuid + '-creation-ts'),
      ),
      onTap: () => openCallback(todo),
      onLongPress: () => editCallback(todo),
    );
  }
}
