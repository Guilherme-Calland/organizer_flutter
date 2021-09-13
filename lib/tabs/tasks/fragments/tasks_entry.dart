import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/model/task.dart';
import 'package:organizer/res/utils.dart' as utils;
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_entry_fragment.dart';

class TasksEntry extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(_) {
    return Observer(
      builder: (BuildContext inContext) {
        return OrganizerEntryFragment(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.notes),
                    title: TextFormField(
                      initialValue: values.tasksStore.entityBeingEdited.description,
                      decoration: InputDecoration(hintText: 'Title'),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? inValue) {
                        if (inValue == '') {
                          return 'Please enter a valid Title';
                        }
                      },
                      onChanged: (String inValue) {
                        values.tasksStore.entityBeingEdited.description =
                            inValue;
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text('Due date'),
                    subtitle: Text(values.tasksStore.chosenDate),
                    trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: values.organizerThemeColor,
                        onPressed: () async {
                          String chosenDate = await utils.selectDate(
                            inContext,
                            values.tasksStore.entityBeingEdited.dueDate,
                            values.tasksStore,
                          );
                          values.tasksStore.entityBeingEdited.dueDate =
                              chosenDate;
                        }),
                  ),
                ],
              ),
            ),
          ),
          onCancelPressed: () => values.tasksStore.setStackIndex(0),
          onSavePressed: () => _saveTask(inContext),
        );
      },
    );
  }

  _saveTask(BuildContext inContext) async {
    if (!_inputIsValid()) return;
    Task entryTask = values.tasksStore.entityBeingEdited;
    Map<String, dynamic> inData = entryTask.taskToMap();
    int result = await values.tasksDB.create(inData);
    if (result > 0) {
      print('created task of id $result');
    } else {
      print('FAILURE');
    }
    utils.hideKeyboard(inContext);
    values.tasksStore.setStackIndex(0);
  }

  bool _inputIsValid() {
    if (_formKey.currentState != null) {
      if (!_formKey.currentState!.validate()) {
        return false;
      }
    }
    return true;
  }
}
