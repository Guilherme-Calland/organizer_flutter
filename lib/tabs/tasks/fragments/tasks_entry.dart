import 'package:flutter/material.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_entry_fragment.dart';

class TasksEntry extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerEntryFragment(
      child: Center(
        child: Text('Tasks Entry'),
      ),
      onCancelPressed: () => values.tasksStore.setStackIndex(0),
      onSavePressed: () {
        print('to be implemented...');
      },
    );
  }
}
