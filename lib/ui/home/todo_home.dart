import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/all/todo_all.dart';
import 'package:flutter_todo/ui/end/todo_end.dart';
import 'package:flutter_todo/ui/ing/todo_ing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoHome extends StatefulWidget {

  @override
  _TodoHomeState createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    TodoAll(),
    TodoIng(),
    TodoEnd(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: Colors.orange
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey[400]
        ),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey[400],
        items: [
          BottomNavigationBarItem(
            label: '전체',
            icon: Icon(Icons.favorite)
          ),
          BottomNavigationBarItem(
            label: '하는중',
            icon: Icon(Icons.analytics_outlined)
          ),
          BottomNavigationBarItem(
            label: '완료',
            icon: Icon(Icons.assignment_turned_in_outlined)
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _widgetOptions,
      ),
    );
  }
}
