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
            _goToEntryCreate();
          },
          child: ReorderableListView.builder(
            onReorder: (int firstIndex, int secondIndex) =>
                _onReorder(firstIndex, secondIndex),
            padding: EdgeInsets.only(top: 11.5),
            itemCount: values.tasksStore.entityList.length,
            itemBuilder: (_, int inIndex) {
              Task taskOnIndex = values.tasksStore.entityList[inIndex];
              String sDueDate = '';
              if (taskOnIndex.dueDate != null) {
                sDueDate = _convertDate(taskOnIndex);
              }
              return Slidable(
                key: ValueKey(taskOnIndex.id),
                actionPane: SlidableScrollActionPane(),
                actions: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: OrganizerContainer(
                      margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10),
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
                child: GestureDetector(
                  onTap: () => _goToEntryEdit(taskOnIndex, sDueDate),
                  behavior: HitTestBehavior.translucent,
                  child: OrganizerContainer(
                    borderRadius: 10,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                    color: taskOnIndex.completed == 'true'
                        ? Color(0xffbfbfbf)
                        : Color(0xfff1f1f1),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () => _updateTaskValue(taskOnIndex),
                        child: OrganizerContainer(
                          size: 40,
                          color: Color(0xffbfbfbf),
                          borderRadius: 8,
                          padding: EdgeInsets.all(4),
                          child: OrganizerContainer(
                            color: Color(0xfff1f1f1),
                            borderRadius: 4,
                            child: taskOnIndex.completed == 'true'
                                ? Center(
                                    child: Icon(
                                      Icons.done,
                                      color: Color(0xffbfbfbf),
                                    ),
                                  )
                                : Container(
                                    height: 0,
                                  ),
                          ),
                        ),
                      ),
                      title: Text('${taskOnIndex.description}',
                          style: taskOnIndex.completed == 'true'
                              ? TextStyle(
                                  color: Theme.of(inContext).disabledColor,
                                  decoration: TextDecoration.lineThrough)
                              : TextStyle()),
                      subtitle: taskOnIndex.dueDate != null ?
                      Text(
                        '${sDueDate}',
                        style: taskOnIndex.completed == 'true'
                            ? TextStyle(
                                color: Theme.of(inContext).disabledColor,
                                decoration: TextDecoration.lineThrough)
                            : TextStyle(),
                      ): null,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _goToEntryCreate() {
    values.tasksStore.entityBeingEdited = Task();
    values.tasksStore.setChosenDate('');
    values.tasksStore.setStackIndex(1);
  }

  Future _goToEntryEdit(Task taskOnIndex, String sDueDate) async {
    if (taskOnIndex.completed == 'true') return;
    if (taskOnIndex.id != null) {
      Map<String, dynamic>? data = await values.tasksDB.get(taskOnIndex.id!);
      if (data != null) {
        values.tasksStore.entityBeingEdited = Task.mapToTask(data);
        if (values.tasksStore.entityBeingEdited.dueDate == '') {
          values.tasksStore.setChosenDate('');
        } else {
          values.tasksStore.setChosenDate(sDueDate);
        }
        values.tasksStore.setStackIndex(1);
        return;
      }
    }
    print('_go_EditTask was fed a null value');
  }

  Future _updateTaskCheckBox(bool? inValue, Task taskOnIndex) async {
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

  Future _deleteTask(Task taskOnIndex) async {
    int result = await values.tasksDB.delete(taskOnIndex.id!);
    if (result == 1) {
      print('$result task was deleted');
    }
    values.tasksStore.loadData(values.tasksDB, 'tasks');
  }

  _onReorder(int firstIndex, int secondIndex) {
    int index1 = firstIndex;
    int index2 = secondIndex;
    List taskList = values.tasksStore.entityList;
    if (index1 < index2) {
      index2 -= 1;
      Task tempTask = Task(
          description: taskList[index1].description,
          dueDate: taskList[index1].dueDate,
          completed: taskList[index1].completed);
      for (int i = index1; i < index2; i++) {
        taskList[i].changeTaskForReorder(taskList[i + 1]);
        Map<String, dynamic> rawTaskData = taskList[i].taskToMap();
        values.tasksDB.update(rawTaskData);
      }
      taskList[index2].changeTaskForReorder(tempTask);
      Map<String, dynamic> rawTaskData = taskList[index2].taskToMap();
      values.tasksDB.update(rawTaskData);
    } else {
      Task tempTask = Task(
          description: taskList[index2].description,
          dueDate: taskList[index2].dueDate,
          completed: taskList[index2].completed);
      taskList[index2].changeTaskForReorder(taskList[index1]);
      Map<String, dynamic> rawTaskData1 = taskList[index2].taskToMap();
      values.tasksDB.update(rawTaskData1);
      for (int i = index1; i > index2 + 1; i--) {
        taskList[i].changeTaskForReorder(taskList[i - 1]);
        Map<String, dynamic> rawTaskData = taskList[i].taskToMap();
        values.tasksDB.update(rawTaskData);
      }
      taskList[index2 + 1].changeTaskForReorder(tempTask);
      Map<String, dynamic> rawTaskData2 = taskList[index2 + 1].taskToMap();
      values.tasksDB.update(rawTaskData2);
    }
  }

  _updateTaskValue(Task taskOnIndex) {
    taskOnIndex.completed == 'true'
        ? taskOnIndex.completed = 'false'
        : taskOnIndex.completed = 'true';
    Map<String, dynamic> rawTaskData = taskOnIndex.taskToMap();
    values.tasksDB.update(rawTaskData);
    values.tasksStore.loadData(values.tasksDB, 'tasks');
  }
}
