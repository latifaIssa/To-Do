import 'package:flutter/material.dart';
import 'package:todo/Screens/todo_list.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: TodoList(title: 'To Do List'),
    );
  }
}

// class _TodoListState extends State<TodoList> {
//   int _counter = 0;
//   bool isChecked = false;
//   final List<String> _todoList = <String>[];
//   final TextEditingController _textFieldController = TextEditingController();
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'To-Do List',
//           style: Theme.of(context).textTheme.headline5,
//         ),
//         leading: CircleAvatar(
//           backgroundColor: Colors.cyan,
//           backgroundImage: NetworkImage(
//               'https://cdn0.iconfinder.com/data/icons/crowdfunding-aqua-vol-2/500/Survey-512.png',
//               scale: 0.1),
//           radius: 3,
//         ),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: EdgeInsets.all(10),
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 SizedBox(height: 16.0),
//                 Text(
//                   'My tasks: $_counter',
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//               ],
//             ),
//             Column(
//               children: _getItems(),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         // onPressed: _incrementCounter,
//         onPressed: () => _displayDialog(context),
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   void _addTodoItem(String title) {
//     // Wrapping it inside a set state will notify
//     // the app that the state has changed
//     setState(() {
//       _todoList.add(title);
//     });
//     _incrementCounter();
//     _textFieldController.clear();
//   }
//
// // Generate a single item widget
//   Future<AlertDialog> _displayDialog(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Add a task to your list'),
//             content: TextField(
//               controller: _textFieldController,
//               decoration: const InputDecoration(hintText: 'Enter task here'),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: const Text('ADD'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _addTodoItem(_textFieldController.text);
//                 },
//               ),
//               FlatButton(
//                 child: const Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }
//
//   Future<String> _asyncInputDialog(BuildContext context) async {
//     String sampleText = '';
//     return showDialog<String>(
//       context: context,
//       barrierDismissible:
//           false, // dialog is dismissible with a tap on the barrier
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter Text'),
//           content: new Row(
//             children: <Widget>[
//               new Expanded(
//                   child: new TextField(
//                 autofocus: true,
//                 decoration: new InputDecoration(labelText: 'edit task'),
//                 onChanged: (value) {
//                   sampleText = value;
//                 },
//               ))
//             ],
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Ok'),
//               onPressed: () {
//                 // _textFieldController.text = conte;
//                 // _addTodoItem(_textFieldController.text);
//                 Navigator.of(context).pop(sampleText);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
// // Generate list of item widgets
//   Widget _buildTodoItem(String title) {
//     // return ListView.builder(
//     //     itemBuilder: (context, index) {
//     return ListTile(
//       leading: Checkbox(
//         value: isChecked,
//         activeColor: Colors.amberAccent,
//         checkColor: Colors.cyan,
//         hoverColor: Colors.black12,
//         onChanged: (value) {
//           setState(() {
//             this.isChecked = value;
//           });
//         },
//       ),
//       title: Text(title),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.edit,
//               size: 25.0,
//               color: Colors.grey,
//             ),
//             onPressed: () async {
//               final String newText = await _asyncInputDialog(context);
//               Scaffold.of(context).showSnackBar(new SnackBar(
//                 content: new Text("$newText"),
//               ));
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.delete_outline,
//               size: 25.0,
//               color: Colors.redAccent,
//             ),
//             onPressed: () {
//               // _onDeleteItemPressed(value);
//             },
//           ),
//         ],
//       ),
//     );
//     // }
//   }
//
//   List<Widget> _getItems() {
//     final List<Widget> _todoWidgets = <Widget>[];
//     for (String title in _todoList) {
//       _todoWidgets.add(_buildTodoItem(title));
//     }
//     return _todoWidgets;
//   }
// }
