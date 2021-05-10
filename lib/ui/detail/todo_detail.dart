import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoDetail extends StatefulWidget {
  @override
  _TodoDetailState createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();

  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String dateTime;

  SharedPreferences sharedPreferences;
  List<TodoModel> _todoList = <TodoModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = dateFormat.format(currentDate);
    _dateController.text = dateTime;
    _initShared();
  }

  void _initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _dateController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    dateTime = dateFormat.format(currentDate);
    _dateController.text = dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '제목을 입력하세요',
                        labelText: '제목'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '제목을 입력하세요';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '내용을 입력하세요',
                        labelText: '내용'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '내용을 입력하세요';
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextFormField(
                    onTap: () {
                      _selectDate(context);
                    },
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: Text('저장하기'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _saveItem();
                      } else {
                        return null;
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _saveItem() {
    print('save Item');
    _formKey.currentState.save();

    TodoModel todoModel = new TodoModel(
        title: _titleController.text,
        content: _contentController.text,
        dateTime: _dateController.text,
        isDone: false);

    _addItem(todoModel);
  }

  _addItem(TodoModel todoModel) {
    _todoList.insert(0, todoModel);
    List<String> stringList =
        _todoList.map((item) => json.encode(item.toJson())).toList();
    print('list --- $stringList');
    // sharedPreferences.setStringList('todo', stringList);
  }
}
