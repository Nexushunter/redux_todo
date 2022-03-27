import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_todo/features/models/models.dart';
import 'package:redux_todo/features/store.dart';
import 'package:redux_todo/features/views/views.dart';
import 'package:uuid/uuid.dart';

void main() {
  final store = TodoStore();

  runApp(StoreProvider(store: store, child: const ReduxTodoApp()));
}

/// The root of the Todo application
class ReduxTodoApp extends StatelessWidget {
  const ReduxTodoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Redux State Demo',
      theme: ThemeData.dark(),
      home: const TodosPage(title: 'Redux State Demo'),
    );
  }
}

/// The main landing page showing the list of todos.
class TodosPage extends StatefulWidget {
  const TodosPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  Offset? _lpd;
  Widget? _contextMenu;
  bool _allSelected = false;
  bool _showHidden = false;

  List<Todo> _filtered = [];

  List<Widget> _buildMultiOptionActions(TodoStore store) {
    final selectedCount =
        _filtered.where((element) => element.selected).toList().length;
    return [
      IconButton(
          onPressed: () => store.dispatch(RemoveTodos(
              removed:
                  _filtered.where((element) => element.selected).toList())),
          icon: Icon(Icons.restore_from_trash_outlined)),
      IconButton(
          onPressed: () => setState(() {
                _allSelected = !_allSelected;
                store.dispatch(SelectTodos(
                    selected: _allSelected ? _filtered : [],
                    allSelected: _allSelected));
              }),
          icon: Icon(selectedCount == store.state.todos.length
              ? Icons.check_box_outlined
              : (selectedCount >= 1 && selectedCount < store.state.todos.length)
                  ? Icons.indeterminate_check_box_outlined
                  : Icons.check_box_outline_blank)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<TodoState, TodoStore>(
      converter: (store) => store as TodoStore,
      // TODO: Use a view model instead of the store directly
      builder: (ctx, store) {
        // TODO: Filter the list of todos
        _filtered = store.state.todos;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              if (_filtered.where((element) => element.selected).isNotEmpty)
                ..._buildMultiOptionActions(store),
              GestureDetector(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.filter_alt_outlined),
                ),
                onTapDown: (details) {
                  // TODO: Implement filtering
                  // _buildFilterMenu(details.globalPosition);
                },
              ),
            ],
          ),
          body: Center(
            child: GestureDetector(
              onTap: () => _dismissContextMenu(),
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (ctx, i) => GestureDetector(
                      onLongPressDown: (lpd) => setState(() {
                        _lpd = lpd.globalPosition;
                      }),
                      child: TodoTile(
                        todo: _filtered[i],
                        openCallback: _onOpen(store),
                        editCallback: _onTodoLongPress(store, _lpd),
                        selectCallback: _onSelect(store),
                      ),
                    ),
                  ),
                  if (_contextMenu != null) _contextMenu!,
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _create(store),
            tooltip: 'Create',
            child: const Icon(Icons.edit_outlined),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }

  void Function() _create(TodoStore store) {
    return () {
      final todo = Todo(
        name: 'Entry',
        visible: true,
        body: '',
        selected: false,
        timeOfDay: DateTime.now().millisecondsSinceEpoch,
        uuid: const Uuid().v4(),
        favourite: false,
      );
      store.dispatch(
        AddTodo(
          todo: todo,
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => EditPage(store: store, todo: todo)));
    };
  }

  void Function(Todo) _onOpen(TodoStore store) {
    return (t) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => EditPage(
            todo: t,
            store: store,
          ),
        ),
      );
    };
  }

  void _dismissContextMenu() => setState(() {
        _contextMenu = null;
      });

  void Function(Todo) _onTodoLongPress(TodoStore store, Offset? offset) {
    return (t) {
      setState(() {
        final child = Column(
          children: [
            MaterialButton(
              onPressed: () {
                _onOpen(store)(t);
                _dismissContextMenu();
              },
              child: const Text('Edit'),
            ),
            MaterialButton(
              onPressed: () {
                _dismissContextMenu();
                store.dispatch(RemoveTodos(removed: [t]));
              },
              child: const Text('Remove'),
            )
          ],
        );
        _contextMenu = _buildContextMenu(offset!, child);
      });
    };
  }

  Widget _buildContextMenu(Offset offset, Widget child,
      {double width = 80, double height = 64}) {
    return Positioned.fromRect(
      rect: Rect.fromCenter(center: offset, width: width, height: height),
      child: Card(child: child),
    );
  }

  void _buildFilterMenu(Offset offset) => setState(() {
        _contextMenu = _buildContextMenu(
          offset..translate(-80, -80),
          Column(
            children: [
              // TODO: Add search
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _showHidden = !_showHidden;
                    _filtered = _filtered
                        .where((e) => !e.visible == _showHidden)
                        .toList();
                  });
                },
                child: Text('Show/Hide Todos'),
              ),
            ],
          ),
          height: 120,
          width: 100,
        );
      });

  void Function(Todo) _onSelect(TodoStore store) {
    return (t) {
      store.dispatch(SelectTodos(selected: [t]));
    };
  }
}
