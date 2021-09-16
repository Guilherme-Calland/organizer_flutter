import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/model/appointment.dart';
import 'package:organizer/res/utils.dart' as utils;
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_entry_fragment.dart';

class AppointmentsEntry extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(_) {
    return Observer(
      builder: (BuildContext inContext){
        return OrganizerEntryFragment(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.title),
                    title: TextFormField(
                      initialValue: values.appointmentsStore.entityBeingEdited.title,
                      decoration: InputDecoration(hintText: 'Title'),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? inValue){
                        if(inValue == ''){
                          return 'Please enter a valid title';
                        }
                      },
                      onChanged: (String inValue){
                        values.appointmentsStore.entityBeingEdited.title = inValue;
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.content_paste),
                    title: TextFormField(
                      decoration: InputDecoration(hintText: 'Content'),
                      initialValue: values.appointmentsStore.entityBeingEdited.description,
                      onChanged: (String inValue){
                        values.appointmentsStore.entityBeingEdited.description = inValue;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 8,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text('Appointment Date'),
                    subtitle: Text(values.appointmentsStore.chosenDate),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _selectDate(inContext),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.alarm),
                    title: Text('Time'),
                    subtitle: Text(values.appointmentsStore.apptTime),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _selectTime(inContext),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onCancelPressed: () => values.appointmentsStore.setStackIndex(0),
          onSavePressed: () => _saveAppointment(),
        );
      },
    );
  }

  Future _saveAppointment() async{
    if(_formKey.currentState != null){
      if(!_formKey.currentState!.validate()){
        return;
      }
    }

    Appointment inAppointment = values.appointmentsStore.entityBeingEdited;

    Map<String, dynamic> data = inAppointment.appointmentToMap();

    if(inAppointment.id == null){
      int result = await values.appointmentsDB.create(data);
      if(result > 0){
        print('created appointment of id $result successfully!');
      }
    } else {
      int result = await values.appointmentsDB.update(data);
      if(result == 1){
        print('updated appointment of id $result successfully!');
      }
    }

    values.appointmentsStore.loadData(values.appointmentsDB, 'appointments');
    values.appointmentsStore.setStackIndex(0);
  }

  Future _selectTime(BuildContext inContext) async{
    utils.hideKeyboard(inContext);
    TimeOfDay initialTime = TimeOfDay.now();

    if(values.appointmentsStore.entityBeingEdited.apptTime != null) {
      List timeParts = values.appointmentsStore.entityBeingEdited.apptTime
          .split(',');
      initialTime = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1])
      );
    }

    TimeOfDay? picked = await showTimePicker(context: inContext, initialTime: initialTime);

    if(picked != null){
      values.appointmentsStore.entityBeingEdited.apptTime = '${picked.hour},${picked.minute}';
      values.appointmentsStore.setApptTime(picked.format(inContext));
    }
  }

  Future _selectDate(BuildContext inContext) async{
    utils.hideKeyboard(inContext);
    String chosenDate = await utils.selectDate(
        inContext,
        values.appointmentsStore.entityBeingEdited.apptDate,
        values.appointmentsStore
    );
    values.appointmentsStore.entityBeingEdited.apptDate = chosenDate;
  }
}
