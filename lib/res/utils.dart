import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizer/res/values.dart' as values;

Future<void> ajustScreenSettings() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: values.organizerSecondaryThemeColor));
}

Future<dynamic> sleep({required int milliseconds}) =>
    Future.delayed(Duration(milliseconds: milliseconds));
