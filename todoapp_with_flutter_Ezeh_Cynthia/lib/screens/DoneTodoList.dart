import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/DoneTodoCards.dart';
import '../todo_model/database_model.dart';
class DoneTodoList extends StatelessWidget {
  var database = DatabaseConnect();
  final Function insertFunction;
  final Function deleteFunction;
  DoneTodoList({
    required this.insertFunction,
    required  this.deleteFunction,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: database.getDoneTodo(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          var data = snapshot.data; // shows list of todo
          var datalength = data!.length;
          return datalength == 0 ?
          Center(child: Text('no data found'),
          ) :
          ListView.builder(
            itemCount: datalength,
            itemBuilder: (context, i) => DoneTodoCard(
              id: data[i].id,
              isChecked:data[i].isChecked ,
              title:data[i].title,
              creationDate: data[i].creationDate,
              insertFunction:insertFunction,
              deleteFunction:deleteFunction,
            ),
          );
        },
      ),
    );
  }
}
