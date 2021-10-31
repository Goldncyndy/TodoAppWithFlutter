import 'package:flutter/material.dart';
import 'package:flutter_todo_list/todo_model/model.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatefulWidget {
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;
  Function insertFunction;
  Function deleteFunction;
  TodoCard({
    required this.id,
    required this.isChecked,
    required this.title,
    required this.creationDate,
    required this.insertFunction,
    required this.deleteFunction,

    Key? key}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    // create local todo

    var anotherTodo = Todo(id: widget.id, title: widget.title, creationDate: widget.creationDate, isChecked: widget.isChecked);

    return Card(
      child: Row(
        children: [
          // checkbox
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Checkbox(
              value: widget.isChecked,
              onChanged: (bool? value){
                setState(() {
                  widget.isChecked = value!;
                });
                // change the value of another's todo isCheck
                anotherTodo.isChecked = value!;
                widget.insertFunction(anotherTodo);
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(DateFormat('dd-MM-yyyy').format(widget.creationDate)),
              ],
            ),
          ),
          // delete button
          IconButton(
              onPressed: (){
                // add delete method
                widget.deleteFunction(anotherTodo);
              },
              icon: Icon(Icons.close)
          ),
        ],
      ),
    );
  }
}
