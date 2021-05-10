import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo_model.dart';
import 'package:flutter_todo/ui/detail/todo_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoAll extends StatefulWidget {
  @override
  _TodoAllState createState() => _TodoAllState();
}

class _TodoAllState extends State<TodoAll> {
  SharedPreferences sharedPreferences;
  List<TodoModel> _todoList = <TodoModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initShared();
  }

  void _initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _todoList = sharedPreferences.getStringList("todo") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoApp'),
        elevation: 0,
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Text('all'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoDetail()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
