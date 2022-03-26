import 'package:flutter/material.dart';

import '../models/models.dart';
import '../store.dart';

/// Edit page for a given [Todo].
class EditPage extends StatefulWidget {
  final Todo todo;
  final TodoStore store;
  const EditPage({required this.store, required this.todo, Key? key})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditPage> {
  late TextEditingController _nameController;
  late TextEditingController _bodyController;
  late bool _favourite;
  late bool _visible;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.todo.name);
    _bodyController = TextEditingController(text: widget.todo.body);
    _favourite = widget.todo.favourite;
    _visible = widget.todo.visible;
  }

  /// Clean up the current todo state.
  @override
  void dispose() {
    widget.store.dispatch(EditTodo(widget.todo,
        name: _nameController.text, body: _bodyController.text));
    super.dispose();
  }

  /// Builds a simple action button
  Widget _buildAction(
      Map<bool, IconData> iconMapping, bool condition, void Function() action) {
    return IconButton(onPressed: action, icon: Icon(iconMapping[condition]));
  }

  /// Builds actions to modify current todo.
  List<Widget> _buildActions() => <Widget>[
        _buildAction(
          <bool, IconData>{
            false: Icons.star_border,
            true: Icons.star_rate,
          },
          _favourite,
          () => setState(() {
            _favourite = !_favourite;
            widget.store.dispatch(EditTodo(widget.todo,
                name: _nameController.text,
                body: _bodyController.text,
                favourite: _favourite));
          }),
        ),
        _buildAction(
          <bool, IconData>{
            false: Icons.visibility_outlined,
            true: Icons.visibility,
          },
          _visible,
          () => setState(() {
            _visible = !_visible;
            widget.store.dispatch(EditTodo(widget.todo,
                name: _nameController.text,
                body: _bodyController.text,
                favourite: _favourite));
          }),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Todo'), actions: _buildActions()),
      body: Column(
        children: [
          Card(
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(controller: _nameController)),
          ),
          Expanded(
            child: Card(
              child: TextField(
                autofocus: true,
                showCursor: true,
                expands: true,
                minLines: null,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: _bodyController,
                onSubmitted: (String s) {
                  _bodyController.text += '\n';
                },
                cursorColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
