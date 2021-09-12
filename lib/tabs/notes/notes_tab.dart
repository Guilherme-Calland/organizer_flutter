import 'package:flutter/material.dart';
import 'package:organizer/widgets/organizer_card.dart';
import 'fragments/notes_entry.dart';
import 'fragments/notes_list.dart';

class NotesTab extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerCard(
      child: IndexedStack(
        index: 0,
        children: [
          NotesList(),
          NotesEntry(),
        ],
      ),
    );
  }
}
