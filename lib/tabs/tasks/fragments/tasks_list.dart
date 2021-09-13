import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/model/task.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_list_fragment.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(_) {
    return Observer(
      builder: (_){
        return OrganizerListFragment(
            onFabPressed: () {
              values.tasksStore.entityBeingEdited = Task();
              values.tasksStore.setChosenDate('');
              values.tasksStore.setStackIndex(1);
            },
            child: Center(
              child: Text('list'),
            ),
        );
      }
    );
  }
}
