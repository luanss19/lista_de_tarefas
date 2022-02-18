import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:intl/intl.dart';
class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy - HH:mm').format(todo.date),
              style: TextStyle(fontSize: 12),
            ),
            Text(
              todo.title,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
