import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_container.dart';
import 'fragments/tasks_entry.dart';
import 'fragments/tasks_list.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerContainer(
      bottomRounded: false,
      borderRadius: 20,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Observer(
        builder: (_){
          return IndexedStack(
            index: values.tasksStore.stackIndex,
            children: [
              TasksList(),
              TasksEntry(),
            ],
          );
        },
      )
    );
  }
}
