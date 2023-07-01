import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];
  // reference the box
  final _mybox = Hive.box('mybox');

  void createinitialdata() {
    toDoList = [
      ['lets get going!!', false]
    ];
  }

  // load the data from db
  void loadata() {
    toDoList = _mybox.get("TODOLIST");
  }

  void update() {
    _mybox.put("TODOLIST", toDoList);
  }
}
