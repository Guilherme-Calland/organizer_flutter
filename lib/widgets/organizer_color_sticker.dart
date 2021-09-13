import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/model/note.dart';
import 'package:organizer/res/values.dart' as values;
import 'organizer_container.dart';

class OrganizerColorSticker extends StatelessWidget {
  final String inColorName;
  final Color inColor;
  OrganizerColorSticker({required this.inColorName, required this.inColor});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_){
        return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: OrganizerContainer(
              borderRadius: 2,
              color: values.notesStore.color == inColorName ? inColor : Colors.transparent,
              child: OrganizerContainer(
                borderRadius: 2,
                color: inColor,
                margin: EdgeInsets.all(6.0),
                size: 18.0,
              ),
            ),
            onTap:() {
              values.notesStore.setColor( inColorName );
              values.notesStore.entityBeingEdited.color = inColorName;
            }
        );
      },
    );
  }
}