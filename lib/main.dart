import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_todo/features/models/models.dart';
import 'package:redux_todo/features/store.dart';
import 'package:redux_todo/features/views/views.dart';
import 'package:uuid/uuid.dart';

void main() {
  final store = TodoStore(
    TodoStore.todoReducer,
    initialState: const TodoState(
      todos: [],
    ),
  );

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
  @override
  Widget build(BuildContext context) {
    return StoreConnector<TodoState, TodoStore>(
      converter: (store) => store as TodoStore,
      // TODO: Use a view model instead of the store directly
      builder: (ctx, store) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: store.state.todos.length,
            itemBuilder: (ctx, i) => TodoTile(
              todo: store.state.todos[i],
              openCallback: _onOpen(store),
              editCallback: _onLongPress(store),
              selectCallback: _onSelect(store),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _create(store),
          tooltip: 'Create',
          child: const Icon(Icons.edit_outlined),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
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

  void Function(Todo) _onLongPress(TodoStore store) {
    return (t) async {
      final cm = Column(
        children: [
          MaterialButton(
            onPressed: () {},
            child: const Text('Edit'),
          ),
          MaterialButton(
            onPressed: () {},
            child: const Text('Remove'),
          )
        ],
      );

      await showDialog(
          context: context,
          builder: (_) => Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ));
    };
  }

  void Function(Todo) _onSelect(TodoStore store) {
    return (t) {
      store.dispatch(
        SelectTodos(
          selected: List.from(store.state.todos)
            ..removeWhere((element) => element == t)
            ..add(t.copyWith(selected: !t.selected)),
        ),
      );
    };
  }
}
