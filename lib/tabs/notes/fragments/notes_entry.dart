import 'package:flutter/material.dart';
import 'package:organizer/res/values.dart' as values;

class NotesEntry extends StatelessWidget {
  @override
  Widget build(_) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () => values.notesStore.setStackIndex(0),
      ),
      body: Center(
        child: Text('Notes Entry'),
      ),
    );
  }
}
