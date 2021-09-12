import 'package:flutter/material.dart';
import 'package:organizer/res/values.dart' as values;

class TasksEntry extends StatelessWidget {
  @override
  Widget build(_) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        child: Icon(Icons.add),
        onPressed: () => values.tasksStore.setStackIndex(0),
      ),
      body: Center(
        child: Text('Tasks Entry'),
      ),
    );
  }
}
