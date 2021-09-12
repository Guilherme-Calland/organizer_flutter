import 'package:flutter/material.dart';
import 'package:organizer/widgets/organizer_card.dart';
import 'fragments/tasks_entry.dart';
import 'fragments/tasks_list.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerCard(
      child: IndexedStack(
        index: 0,
        children: [
          TasksList(),
          TasksEntry(),
        ],
      ),
    );
  }
}
