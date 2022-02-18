import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Adicione uma tarefa',
                            hintText: 'Ex. : Ir ao mercado.'),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Todo newTodo = Todo(
                              title: todoController.text,
                              date: DateTime.now()
                          );
                          todos.add(newTodo);
                          todoController.clear();
                        });
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen,
                        padding: EdgeInsets.all(14),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(todo: todo)
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Você possui ${todos.length} tarefas pendentes'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Limpar Tudo'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen,
                        padding: EdgeInsets.all(14),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
