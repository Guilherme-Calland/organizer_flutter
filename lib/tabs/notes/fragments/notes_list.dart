import 'package:flutter/material.dart';
import 'package:organizer/model/note.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_list_fragment.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerListFragment(
      onFabPressed: () {
        values.notesStore.entityBeingEdited = Note();
        values.notesStore.setColor(null);
        values.notesStore.setStackIndex(1);
      },
      child: ListView.builder(
        itemCount: 50,
        itemBuilder: (_, int inIndex){
          return ListTile(
            title: Text('$inIndex'),
          );
        },
      ),
    );
  }
}

