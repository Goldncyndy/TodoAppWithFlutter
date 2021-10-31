import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/AddTodo.dart';
import 'package:flutter_todo_list/screens/DoneTask.dart';
import 'package:flutter_todo_list/screens/todoList.dart';
import 'package:flutter_todo_list/todo_model/database_model.dart';
import 'package:flutter_todo_list/todo_model/model.dart';
import 'todoList.dart';
class Homepage extends StatefulWidget {

  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
        title: Text('TODO',
        style: TextStyle(
          color:  Colors.black
        ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TodoList(insertFunction: addItem, deleteFunction:  deleteItem,),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 0, 0, 0),
            child: FloatingActionButton(
              onPressed: () async {
                await  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoneTaskPage()),
                );
                // setState(() {
                //   Todo(
                //       title: textController.text,
                //       creationDate: DateTime.now(),
                //       isChecked: false
                //   );
                // });
              },
              child: Icon(Icons.check),
              backgroundColor: Colors.purple,
            ),
          ),
          SizedBox(width: 200,),
          FloatingActionButton(
           onPressed: () async {
             await  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodo()),
              );
              setState(() {
                Todo(
                    title: textController.text,
                    creationDate: DateTime.now(),
                    isChecked: false
                );
              });
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
