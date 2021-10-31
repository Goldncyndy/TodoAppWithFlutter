import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './model.dart';


class DatabaseConnect {
  Database? _database;
  Future<Database> get database async {
    final databasePath = await getDatabasesPath();
    const databaseName = 'todo.db';
    final path = join(databasePath, databaseName);
    _database = await openDatabase(path, version: 1, onCreate: _createDb);
    return _database!;
  }
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
       CREATE TABLE todo(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       title TEXT,
       creationDate TEXT,
       isChecked INTEGER
           )
   ''');
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    //insert  the todo
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm
          .replace,

    );
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = await database;
    await db.delete(
      'todo',
      where: 'id == ? ',
      whereArgs: [todo.id],

    );
  }
  Future<List<Todo>> getTodo() async {
    final db = await database ;
    List<Map<String, dynamic>> items = await db.query(
      'todo',
       orderBy: 'id Desc',
    );

      return List.generate(
        items.length,
        (i) => Todo(
        id: items[i]['id'],
        title: items[i]['title'],
        creationDate: DateTime.parse(items[i]['creationDate']), // coverting to data format
        isChecked: items[i]['isChecked'] ==  1 ? true : false,
     ),
    );
  }
  // function to fetch all Done todo from the database
  Future<List<Todo>> getDoneTodo() async {
    final db = await database ;
    // query the database and save the todo as list of maps
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id Desc',
      where: 'isChecked == 1 '
    );

    return List.generate(
      items.length,
          (i) => Todo(
        id: items[i]['id'],
        title: items[i]['title'],
        creationDate: DateTime.parse(items[i]['creationDate']),
        isChecked: items[i]['isChecked'] ==  1 ? true : false,
      ),
    );
  }
}
