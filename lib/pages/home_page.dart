import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:letsdo/data/database.dart';
import 'package:letsdo/pages/util/dialogbox.dart';
import 'package:letsdo/pages/util/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    // if this is first time
    if (_mybox.get("TODOLIST") == null) {
      db.createinitialdata();
    } else {
      db.loadata();
    }
    super.initState();
  }

  ToDoDataBase db = ToDoDataBase();
  final _mybox = Hive.box('mybox');
  // save new task
  void savenewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.update();
    Navigator.of(context).pop();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.update();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.update();
  }

  // create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onSave: savenewTask,
            onCancel: () {
              Navigator.of(context).pop();
            },
            controller: _controller,
          );
        });
    db.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('TO DO')),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            TaskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
            DeleteFunction: (context) {
              deleteTask(index);
            },
          );
        },
      ),
    );
  }
}
