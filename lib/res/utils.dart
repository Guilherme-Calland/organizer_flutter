import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:organizer/mobx_stores/entity_store.dart';
import 'package:organizer/res/values.dart' as values;

Future<void> ajustScreenSettings() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: values.organizerSecondaryThemeColor));
}

Future<dynamic> sleep({required int milliseconds}) =>
    Future.delayed(Duration(milliseconds: milliseconds));

void hideKeyboard(BuildContext inContext) {
  FocusScope.of(inContext).requestFocus(FocusNode());
}

Future selectDate(BuildContext inContext, String? inDateString, EntityStore store) async {
  DateTime initialDate = DateTime.now();
  if (inDateString != null) {
    List dateParts = inDateString.split(",");
    initialDate = DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
    );
  }

  DateTime? picked = await showDatePicker(
    context: inContext,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  if(picked != null){
    store.setChosenDate(
        DateFormat.yMMMMd('en_US').format(picked.toLocal())
    );
    return '${picked.day},${picked.month},${picked.year}';
  }
}