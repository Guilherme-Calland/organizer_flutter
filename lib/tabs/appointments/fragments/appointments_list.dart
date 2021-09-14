import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:organizer/model/appointment.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_container.dart';
import 'package:organizer/widgets/organizer_list_fragment.dart';

class AppointmentsList extends StatelessWidget {
  @override
  Widget build(_) {
    return Observer(
      builder: (BuildContext inContext) {
        EventList<Event> _markedDateMap = EventList(events: {});
        values.appointmentsStore.entityList.forEach(
          (appointment) {
            if (appointment.apptDate != null) {
              List dateParts = appointment.apptDate.split(',');
              DateTime apptDate = DateTime(
                int.parse(dateParts[0]),
                int.parse(dateParts[1]),
                int.parse(dateParts[2]),
              );
              _markedDateMap.add(
                  apptDate,
                  Event(
                      date: apptDate,
                      icon: Container(
                        decoration: BoxDecoration(color: Colors.blue),
                      )));
            }
          },
        );
        return OrganizerListFragment(
          onFabPressed: () {
            _goToEntryCreate();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: CalendarCarousel<Event>(
              thisMonthDayBorderColor: Colors.grey,
              daysHaveCircularBorder: false,
              markedDatesMap: _markedDateMap,
              onDayPressed: (DateTime inDate, List<Event> inEvents) =>
                  _showAppointments(inDate, inContext),
            ),
          ),
        );
      },
    );
  }

  void _goToEntryCreate() {
    values.appointmentsStore.entityBeingEdited = Appointment();
    DateTime now = DateTime.now();
    values.appointmentsStore.entityBeingEdited.apptDate =
        '${now.year}, ${now.month}, ${now.day}';
    values.appointmentsStore
        .setChosenDate(DateFormat.yMMMMd('en_US').format(now.toLocal()));
    values.appointmentsStore.setApptTime('');
    values.appointmentsStore.setStackIndex(1);
  }

  Future _showAppointments(DateTime inDate, BuildContext inContext) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: inContext,
        builder: (_) {
          return Observer(
            builder: (_) {
              return OrganizerContainer(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  child: Column(
                    children: [
                      Text(
                        DateFormat.yMMMMd('en_US').format(inDate.toLocal()),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: values.organizerThemeColor,
                          fontSize: 24,
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: values.appointmentsStore.entityList.length,
                          itemBuilder: (_, int inIndex) {
                            Appointment appointmentOnIndex =
                                values.appointmentsStore.entityList[inIndex];
                            print(appointmentOnIndex.apptDate);
                            if (appointmentOnIndex.apptDate !=
                                '${inDate.year}, ${inDate.month}, ${inDate.day}') {
                              return Container(
                                height: 0,
                              );
                            }
                            String apptTime = '';
                            if (appointmentOnIndex.apptTime != null) {
                              List timeParts =
                                  appointmentOnIndex.apptTime!.split(',');
                              TimeOfDay at = TimeOfDay(
                                hour: int.parse(timeParts[0]),
                                minute: int.parse(timeParts[1]),
                              );
                              apptTime = ' (${at.format(inContext)})';
                            }
                            return Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actions: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  child: OrganizerContainer(
                                    margin: EdgeInsets.only(
                                        top: 2.5, bottom: 2.5, left: 10),
                                    color: Colors.red,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () =>
                                      _deleteAppointment(appointmentOnIndex),
                                )
                              ],
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => _goToEntryEdit(
                                    inContext, appointmentOnIndex),
                                child: OrganizerContainer(
                                  color: Color(0xffe0e0e0),
                                  borderRadius: 10,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2.5),
                                  child: ListTile(
                                    title: Text(
                                        '${appointmentOnIndex.title} $apptTime'),
                                    subtitle: appointmentOnIndex.description ==
                                            null
                                        ? null
                                        : Text(
                                            '${appointmentOnIndex.description}'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future _deleteAppointment(Appointment inAppointment) async {
    int result = await values.appointmentsDB.delete(inAppointment.id!);
    if (result == 1) {
      print('$result appointment deleted successfully');
    }
    values.appointmentsStore.loadData(values.appointmentsDB, 'appointments');
  }

  Future _goToEntryEdit(
      BuildContext inContext, Appointment inAppointment) async {
    values.appointmentsStore.entityBeingEdited = inAppointment;
    if (inAppointment.apptDate == null) {
      values.appointmentsStore.setChosenDate('');
    } else {
      List dateParts = inAppointment.apptDate!.split(',');
      DateTime apptDate = DateTime(int.parse(dateParts[0]),
          int.parse(dateParts[1]), int.parse(dateParts[2]));
      values.appointmentsStore
          .setChosenDate(DateFormat.yMMMMd('en_US').format(apptDate.toLocal()));

      if (inAppointment.apptTime == null) {
        values.appointmentsStore.setApptTime('');
      } else {
        List timeParts = inAppointment.apptTime!.split(',');
        TimeOfDay apptTime = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1]),
        );
        values.appointmentsStore.setApptTime(apptTime.format(inContext));
      }
      values.appointmentsStore.loadData(values.appointmentsDB, 'appointments');
      values.appointmentsStore.setStackIndex(1);
      Navigator.pop(inContext);
    }
  }
}
