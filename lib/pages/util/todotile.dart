import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String TaskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? DeleteFunction;

  TodoTile(
      {super.key,
      required this.TaskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.DeleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: DeleteFunction,
              icon: Icons.delete_outline_rounded,
              backgroundColor: const Color.fromARGB(255, 152, 45, 37),
            )
          ],
        ),
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            children: [
              // Check BoxonChanged
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: const Color.fromARGB(255, 77, 158, 188),
              ),

              // Task Name
              Text(
                TaskName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 42, 40, 41),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
