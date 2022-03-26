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
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: todo.visible
          ? Checkbox(
              value: todo.selected,
              onChanged: (checked) => selectCallback(todo),
            )
          : Container(
              color: Colors.transparent,
            ),
      title: Text(todo.name),
      subtitle: Text(DateTime.fromMillisecondsSinceEpoch(todo.timeOfDay)
          .toLocal()
          .toString()),
      onTap: () => openCallback(todo),
      onLongPress: () => editCallback(todo),
    );
  }
}
