import 'package:flutter/material.dart';
import 'package:organizer/database/database_worker.dart';
import 'package:organizer/mobx_stores/appointments/appointments_store.dart';
import 'package:organizer/mobx_stores/notes/notes_store.dart';
import 'package:organizer/mobx_stores/tasks/tasks_store.dart';

Color organizerThemeColor = Color(0xff52955a);

Color organizerSecondaryThemeColor = Color(0xff407849);

Map<int, Color> organizerThemeColorMap = {
  50: organizerThemeColor,
  100: organizerThemeColor,
  200: organizerThemeColor,
  300: organizerThemeColor,
  400: organizerThemeColor,
  500: organizerThemeColor,
  600: organizerThemeColor,
  700: organizerThemeColor,
  800: organizerThemeColor,
  900: organizerThemeColor
};

MaterialColor organizerThemeMaterialColor = MaterialColor(0xff52955a, organizerThemeColorMap);

//NOTES
final notesStore = NotesStore();
final notesDB = DatabaseWorker('notes');

//APPOINTMENTS
final appointmentsStore = AppointmentsStore();
final appointmentsDB = DatabaseWorker('appointments');

//TASKS
final tasksStore = TasksStore();
final tasksDB = DatabaseWorker('tasks');
