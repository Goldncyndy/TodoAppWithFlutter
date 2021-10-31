import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/AddTodo.dart';
import 'package:flutter_todo_list/screens/DoneTodoList.dart';
import 'package:flutter_todo_list/screens/Homepage.dart';
import 'package:flutter_todo_list/todo_model/database_model.dart';
import 'package:flutter_todo_list/todo_model/model.dart';
class DoneTaskPage extends StatefulWidget {

  const DoneTaskPage({Key? key}) : super(key: key);

  @override
  _DoneTaskPageState createState() => _DoneTaskPageState();
}

class _DoneTaskPageState extends State<DoneTaskPage> {
  var textController = TextEditingController();
  var database = DatabaseConnect();

  void addItem(Todo todo) async {
    await database.insertTodo(todo);
    setState(() {

    });
  }
  void deleteItem(Todo todo) async {
    await database.deleteTodo(todo);
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('DONE TASK',
          style: TextStyle(
              color:  Colors.black
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          DoneTodoList(insertFunction: addItem, deleteFunction:  deleteItem,),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: (){
              setState(() {
              });
            },
            child: Icon(Icons.check),
            backgroundColor: Colors.purple,
          ),
          SizedBox(width: 200,),
          FloatingActionButton(
            onPressed: () async {
              await  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
              setState(() {
                Todo(
                    title: textController.text,
                    creationDate: DateTime.now(),
                    isChecked: false
                );
              });
            },
            child: Icon(Icons.library_add_check_sharp),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
