import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/tabs/appointments/fragments/appointments_entry.dart';
import 'package:organizer/widgets/organizer_card.dart';
import 'fragments/appointments_list.dart';

class AppointmentsTab extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerCard(
      elevation: 10,
      borderRadius: 20,
      bottomRounded: false,
      child: Observer(
        builder: (_) {
          return IndexedStack(
            index: values.appointmentsStore.stackIndex,
            children: [
              AppointmentsList(),
              AppointmentsEntry(),
            ],
          );
        },
      ),
    );
  }
}
