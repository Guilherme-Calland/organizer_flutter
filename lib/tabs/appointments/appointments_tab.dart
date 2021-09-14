import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/model/appointment.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/tabs/appointments/fragments/appointments_entry.dart';
import 'package:organizer/widgets/organizer_container.dart';
import 'fragments/appointments_list.dart';

class AppointmentsTab extends StatelessWidget {

  AppointmentsTab(){
    loadAppointmentsData();
  }

  void loadAppointmentsData() async{
    if(values.appointmentsStore.initialLoadDataFlag){
      if(values.appointmentsStore.entityBeingEdited == null){
        values.appointmentsStore.entityBeingEdited = Appointment();
      }
      values.appointmentsStore.triggeredInitialLoadDataFlag();
      await values.appointmentsStore.loadData(values.appointmentsDB, 'appointments');
    }
  }

  @override
  Widget build(_) {
    return OrganizerContainer(
      borderRadius: 20,
      bottomRounded: false,
      margin: EdgeInsets.symmetric(horizontal: 12),
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
