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

  Todo? deletedTodo;
  int? positionDelTodo;
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
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffFFAEBC))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffFFAEBC))),
                            labelText: 'Adicione uma tarefa',
                            labelStyle: TextStyle(color: Colors.black54),
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
                              title: todoController.text, date: DateTime.now());
                          todos.add(newTodo);
                          todoController.clear();
                        });
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.black,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffFFAEBC),
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
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child:
                          Text('Você possui ${todos.length} tarefas pendentes'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: showDeletedTodosConfirmation,
                      child: Text(
                        'Limpar Tudo',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffFFAEBC),
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

  void onDelete(Todo todo) {
    deletedTodo = todo;
    positionDelTodo = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Tarefa ${todo.title} foi removida com sucesso!',
        style: TextStyle(color: Colors.black38),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            todos.insert(positionDelTodo!, deletedTodo!);
          });
        },
        textColor: Color(0xffFFAEBC),
      ),
    ));
  }

  void showDeletedTodosConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apagar Tudo'),
        content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            child: Text(
              'Sim',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos(){
    setState(() {
      todos.clear();
    });
  }
}
