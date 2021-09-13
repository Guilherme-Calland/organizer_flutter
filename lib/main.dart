import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/res/utils.dart' as utils;
import 'package:organizer/tabs/appointments/appointments_tab.dart';
import 'package:organizer/tabs/notes/notes_tab.dart';
import 'package:organizer/tabs/tasks/tasks_tab.dart';

void main() async {
  await utils.ajustScreenSettings();
  runApp(Organizer());
}

class Organizer extends StatelessWidget {
  @override
  Widget build(_) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: values.organizerThemeColor,
        primarySwatch: values.organizerThemeMaterialColor,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: values.organizerThemeColor),
      ),
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: SafeArea(
          child: Scaffold(
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 32, bottom: 4, top: 32),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Organizer',
                                speed: Duration(milliseconds: 500),
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 62,
                                  fontFamily: 'SquadaOne'
                                ),
                              )
                            ],
                          ),
                        ),
                        TabBar(
                          indicator: BoxDecoration(),
                          labelColor: Colors.white,
                          unselectedLabelColor: Color(0x2affffff),
                          indicatorColor: values.organizerThemeColor,
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.note,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.date_range,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.notes,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        NotesTab(),
                        AppointmentsTab(),
                        TasksTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
