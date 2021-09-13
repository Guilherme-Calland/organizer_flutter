import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/model/note.dart';
import 'package:organizer/res/values.dart' as values;
import 'organizer_container.dart';

class OrganizerColorStickerOnList extends StatelessWidget {
  final String inColorName;
  final Color inColor;
  final Note inNote;

  OrganizerColorStickerOnList(
      {required this.inColorName, required this.inColor, required this.inNote});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: OrganizerContainer(
          borderRadius: 2,
          color: inNote.color == inColorName ? inColor : Colors.white,
          child: OrganizerContainer(
            borderRadius: 2,
            color: inColor,
            margin: EdgeInsets.all(6.0),
            size: 18.0,
          ),
        ),
        onTap: () => _updateNote()
    );
  }

  Future _updateNote() async{
    inNote.color = inColorName;
    Map<String, dynamic> data = inNote.noteToMap();
    int result = await values.notesDB.update(data);
    if(result == 1){
      print('$result note was updated');
    }
    values.notesStore.loadData(values.notesDB);
  }
}
