import 'package:flutter/material.dart';
import 'package:organizer/tabs/appointments/fragments/appointments_entry.dart';
import 'package:organizer/widgets/organizer_card.dart';
import 'fragments/appointments_list.dart';

class AppointmentsTab extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerCard(
      child: IndexedStack(
        index: 0,
        children: [
          AppointmentsList(),
          AppointmentsEntry()
        ],
      ),
    );
  }
}
