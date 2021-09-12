import 'package:flutter/material.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_entry_fragment.dart';

class AppointmentsEntry extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerEntryFragment(
      child: Center(
        child: Text('Appointments Entry'),
      ),
      onCancelPressed: () => values.appointmentsStore.setStackIndex(0),
      onSavePressed: () {
        print('to be implemented...');
      },
    );
  }
}
