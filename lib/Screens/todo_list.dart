import 'dart:async';
import 'dart:io';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/Utils/database_helper.dart';
import 'package:todo/Screens/todo_detail.dart';
import 'package:sqflite/sqflite.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;

  int _counter = 0;
  bool isChecked = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text(
              'To-Do List',
//           style: Theme.of(context).textTheme.headline5,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
      updateListView();
    }

    return Scaffold(
      appBar: new AppBar(
        title: _buildTitle(context),
        // leading: Text('$_counter',
        //     style: TextStyle(
        //       color: Colors.amber,
        //       fontSize: 25,
        //       backgroundColor: Colors.white,
        //     )),
        actions: [
          Container(
              margin: EdgeInsets.all(10),
              child: new Center(
                  child: new Row(children: <Widget>[
                new CircleAvatar(
                  radius: 15.0,
                  child: new Text('$_counter'),
                  backgroundColor: const Color(0xff56c6d0),
                ),
              ])))
        ],

        toolbarHeight: 60,
      ),
      body: getTodoListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Todo('', '', ''), 'Add Todo');
        },
        tooltip: 'Add Todo',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      padding: EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int position) {
        return Card(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            // leading: CircleAvatar(
            //   backgroundColor: Colors.amber,
            //   child: Text(getFirstLetter(this.todoList[position].title),
            //       style: TextStyle(fontWeight: FontWeight.bold)),
            // ),
            // leading: Checkbox(
            //   value: isChecked,
            //   activeColor: Colors.amberAccent,
            //   checkColor: Colors.cyan,
            //   hoverColor: Colors.black12,
            //   onChanged: (value) {
            //     setState(() {
            //       this.isChecked = value;
            //     });
            //   },
            // ),
            leading: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: isChecked
                    ? Icon(
                        Icons.check,
                        size: 35.0,
                        color: Colors.cyan,
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 25.0,
                        child: Text(
                            getFirstLetter(this.todoList[position].title),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
              ),
            ),

            title: Text(this.todoList[position].title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(this.todoList[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    debugPrint("ListTile Tapped");
                    navigateToDetail(this.todoList[position], 'Edit Todo');
                  },
                ),
                GestureDetector(
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onTap: () {
                    _delete(context, todoList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              // this.isChecked = !this.isChecked;
              // Checkbox.isChecked = this.isChecked;
              setState(() {
                isChecked = !isChecked;
                isChecked ? _counter = _counter - 1 : _counter += 1;
              });
            },
          ),
        );
      },
    );
  }

  // Returns the priority color
  // Color getPriorityColor(int priority) {
  // 	switch (priority) {
  // 		case 1:
  // 			return Colors.red;
  // 			break;
  // 		case 2:
  // 			return Colors.yellow;
  // 			break;

  // 		default:
  // 			return Colors.yellow;
  // 	}
  // }
  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  // Returns the priority icon
  // Icon getPriorityIcon(int priority) {
  // 	switch (priority) {
  // 		case 1:
  // 			return Icon(Icons.play_arrow);
  // 			break;
  // 		case 2:
  // 			return Icon(Icons.keyboard_arrow_right);
  // 			break;

  // 		default:
  // 			return Icon(Icons.keyboard_arrow_right);
  // 	}
  // }

  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Todo todo, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          // isChecked = false;
          this.todoList = todoList;
          this.count = todoList.length;
          _counter = this.count;
        });
      });
    });
  }
}
