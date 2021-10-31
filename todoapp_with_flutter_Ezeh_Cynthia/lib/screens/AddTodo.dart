import 'package:flutter/material.dart';
import 'userinput.dart';
import 'package:flutter_todo_list/todo_model/model.dart';
import 'package:flutter_todo_list/todo_model/database_model.dart';

void main() async {
  runApp(AddTodo());
}
class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  var database = DatabaseConnect();

  void addItem(Todo todo) async {
    await database.insertTodo(todo);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Column(
        children: [
          UserInput(
            insertFunction: addItem,
          ),

        ],
      ),
    );
  }
  }

