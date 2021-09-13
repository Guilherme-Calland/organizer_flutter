import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:organizer/model/note.dart';
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_color_sticker_on_list.dart';
import 'package:organizer/widgets/organizer_container.dart';
import 'package:organizer/widgets/organizer_list_fragment.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(_) {
    return OrganizerListFragment(
      onFabPressed: () {
        values.notesStore.entityBeingEdited = Note();
        values.notesStore.setColor(null);
        values.notesStore.setStackIndex(1);
      },
      child: Observer(
        builder: (_) {
          return ListView.builder(
            padding: EdgeInsets.only(top: 13.5),
            itemCount: values.notesStore.entityList.length,
            itemBuilder: (_, int inIndex) {
              Note noteOnIndex = values.notesStore.entityList[inIndex];
              Color? colorOnIndex;
              switch (noteOnIndex.color) {
                case 'white':
                  colorOnIndex = Color(0xfff1f1f1);
                  break;
                case 'red':
                  colorOnIndex = Colors.red;
                  break;
                case 'pink':
                  colorOnIndex = Color(0xffff75c8);
                  break;
                case 'blue':
                  colorOnIndex = Colors.blue;
                  break;
                case 'yellow':
                  colorOnIndex = Colors.yellow;
                  break;
                case 'grey':
                  colorOnIndex = Colors.grey;
                  break;
                case 'purple':
                  colorOnIndex = Colors.purple;
              }
              return Slidable(
                actionPane: SlidableScrollActionPane(),
                actions: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: OrganizerContainer(
                      margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10),
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    onTap: () => _deleteNote(noteOnIndex),
                  )
                ],
                secondaryActions: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          OrganizerColorStickerOnList(inColorName: 'red', inColor: Colors.red, inNote: noteOnIndex,),
                          OrganizerColorStickerOnList(inColorName: 'pink', inColor: Color(0xffff75c8), inNote: noteOnIndex,),
                          OrganizerColorStickerOnList(inColorName: 'blue', inColor: Colors.blue, inNote: noteOnIndex,),
                        ],
                      ),
                      Row(
                        children: [
                          OrganizerColorStickerOnList(inColorName: 'yellow', inColor: Colors.yellow, inNote: noteOnIndex,),
                          OrganizerColorStickerOnList(inColorName: 'grey', inColor: Colors.grey, inNote: noteOnIndex,),
                          OrganizerColorStickerOnList(inColorName: 'purple', inColor: Colors.purple, inNote: noteOnIndex,),
                        ],
                      ),
                    ],
                  )
                ],
                child: OrganizerContainer(
                  borderRadius: 10,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                  color: colorOnIndex,
                  child: ListTile(
                    title: Text(
                      noteOnIndex.title ?? '',
                      style: TextStyle(
                        color: ((noteOnIndex.color == 'white') ||
                            (noteOnIndex.color == 'yellow')
                            ? Colors.black
                            : Colors.white),
                      ),
                    ),
                    subtitle: noteOnIndex.content != '' ? Text(
                      noteOnIndex.content ?? '',
                      style: TextStyle(
                        color: ((noteOnIndex.color == 'white') ||
                            (noteOnIndex.color == 'yellow')
                            ? Colors.black
                            : Colors.white),
                      ),
                    ) : null,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteNote(Note noteOnIndex) async {
    int result = await values.notesDB.delete(noteOnIndex.id!);
    if(result == 1){
      print('$result note was deleted');
    }
    values.notesStore.loadData(values.notesDB);
  }
}
