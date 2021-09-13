import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:organizer/model/task.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_container.dart';
import 'package:organizer/widgets/organizer_list_fragment.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(_) {
    return Observer(
        builder: (BuildContext inContext) {
          return OrganizerListFragment(
            onFabPressed: () {
              values.tasksStore.entityBeingEdited = Task();
              values.tasksStore.setChosenDate('');
              values.tasksStore.setStackIndex(1);
            },
            child: ListView.builder(
              padding: EdgeInsets.only(top: 13.5),
              itemCount: values.tasksStore.entityList.length,
              itemBuilder: (_, int inIndex) {
                Task taskOnIndex = values.tasksStore.entityList[inIndex];
                String sDueDate = '';
                if (taskOnIndex.dueDate != null) {
                  sDueDate = _convertDate(taskOnIndex);
                }
                return Slidable(
                  actionPane: SlidableScrollActionPane(),
                  actions: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: OrganizerContainer(
                        margin: EdgeInsets.only(
                            top: 2.5, bottom: 2.5, left: 10),
                        color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      onTap: () => _deleteTask(taskOnIndex),
                    )
                  ],
                  child: OrganizerContainer(
                    borderRadius: 10,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                    color: taskOnIndex.completed == 'true'
                        ? Color(0xffbfbfbf)
                        : Color(0xffe0e0e0),
                    child: ListTile(
                        leading: Checkbox(
                          value: taskOnIndex.completed == 'true' ? true : false,
                          onChanged: (inValue) =>
                              _updateTaskCheckBox(inValue, taskOnIndex),
                        ),
                        title: Text(
                            '${taskOnIndex.description}',
                            style: taskOnIndex.completed == 'true'
                            ? TextStyle(
                                color: Theme.of(inContext).disabledColor,
                                decoration: TextDecoration.lineThrough
                            )
                            : TextStyle()
                        ),
                        subtitle: taskOnIndex.completed == 'false' ?
                        (taskOnIndex.dueDate != null ? Text('${taskOnIndex
                            .dueDate}') : null)
                            : null
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }

  void _updateTaskCheckBox(bool? inValue, Task taskOnIndex) async {
    taskOnIndex.completed = inValue.toString();
    Map<String, dynamic> data = taskOnIndex.taskToMap();
    await values.tasksDB.update(data);
    values.tasksStore.loadData(values.tasksDB, 'tasks');
  }

  String _convertDate(Task taskOnIndex) {
    List dateParts = taskOnIndex.dueDate!.split(',');
    DateTime dueDate = DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
    );
    return DateFormat.yMMMMd('en_US').format(dueDate.toLocal());
  }

  _deleteTask(Task taskOnIndex) {
    print('to be implemented...');
  }
}
