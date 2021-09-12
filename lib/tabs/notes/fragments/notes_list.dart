import 'package:flutter/material.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_list_fragment.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerListFragment(
      onFabPressed: () => values.notesStore.setStackIndex(1),
      child: Center(
        child: Text('Notes List'),
      ),
    );
  }
}

