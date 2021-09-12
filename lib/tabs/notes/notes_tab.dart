import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/model/note.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_container.dart';
import 'fragments/notes_entry.dart';
import 'fragments/notes_list.dart';

class NotesTab extends StatelessWidget {

  NotesTab(){
    if(values.notesStore.entityBeingEdited == null){
      values.notesStore.entityBeingEdited = Note();
    }

    if(values.notesStore.initialLoadDataFlag){
      values.notesStore.triggeredInitialLoadDataFlag();
      values.notesStore.loadData(values.notesDB);
    }

    print(values.notesStore.entityList);
  }

  @override
  Widget build(_) {
    return OrganizerContainer(
      borderRadius: 20,
      bottomRounded: false,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Observer(
        builder: (_){
          return IndexedStack(
            index: values.notesStore.stackIndex,
            children: [
              NotesList(),
              NotesEntry(),
            ],
          );
        },
      )
    );
  }
}
