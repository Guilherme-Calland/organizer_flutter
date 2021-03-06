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
      onFabPressed: () => _goToEntryCreate(),
      child: Observer(
        builder: (_) {
          return ReorderableListView.builder(
            onReorder: (int firstIndex, int secondIndex) => _onReorder(firstIndex, secondIndex),
            padding: EdgeInsets.only(top: 11.5),
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
                case 'orange':
                  colorOnIndex = Colors.orange;
                  break;
                case 'purple':
                  colorOnIndex = Colors.purple;
              }
              return Slidable(
                key: ValueKey(noteOnIndex.id),
                actionPane: SlidableScrollActionPane(),
                actions: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: OrganizerContainer(
                      margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 10),
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          OrganizerColorStickerOnList(inColorName: 'orange', inColor: Colors.orange, inNote: noteOnIndex,),
                          OrganizerColorStickerOnList(inColorName: 'purple', inColor: Colors.purple, inNote: noteOnIndex,),
                        ],
                      ),
                    ],
                  ),
                ],
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _goToEntryEdit(noteOnIndex),
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
                              : Colors.white
                          ),
                        ),
                      ),
                      subtitle: noteOnIndex.content != '' ? Text(
                        noteOnIndex.content ?? '',
                        style: TextStyle(
                          color: ((noteOnIndex.color == 'white') ||
                              (noteOnIndex.color == 'yellow')
                              ? Colors.black
                              : Colors.white
                          ),
                        ),
                      ) : null,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _onReorder(int firstIndex, int secondIndex){
    int index1 = firstIndex;
    int index2 = secondIndex;
    List noteList = values.notesStore.entityList;
    if(index1 < index2){
      index2 -= 1;
      Note tempNote = Note(
        title: noteList[index1].title,
        content: noteList[index1].content,
        color: noteList[index1].color
      );
      for(int i = index1; i < index2; i++){
        noteList[i].changeNoteForReorder(noteList[i + 1]);
        Map<String, dynamic> rawNoteData = noteList[i].noteToMap();
        values.notesDB.update(rawNoteData);
      }
      noteList[index2].changeNoteForReorder(tempNote);
      Map<String, dynamic> rawNoteData = noteList[index2].noteToMap();
      values.notesDB.update(rawNoteData);
    }else{
      Note tempNote = Note(
        title: noteList[index2].title,
        content: noteList[index2].content,
        color: noteList[index2].color
      );
      noteList[index2].changeNoteForReorder(noteList[index1]);
      Map<String, dynamic> rawNoteData1 = noteList[index2].noteToMap();
      values.notesDB.update(rawNoteData1);
      for(int i = index1; i > index2 + 1; i--){
        noteList[i].changeNoteForReorder(noteList[i - 1]);
        Map<String, dynamic> rawNoteData = noteList[i].noteToMap();
        values.notesDB.update(rawNoteData);
      }
      noteList[index2 + 1].changeNoteForReorder(tempNote);
      Map<String, dynamic> rawNoteData2 = noteList[index2 + 1].noteToMap();
      values.notesDB.update(rawNoteData2);
    }
  }

  void _goToEntryCreate() {
    values.notesStore.entityBeingEdited = Note();
    values.notesStore.setColor(null);
    values.notesStore.setStackIndex(1);
  }

  void _goToEntryEdit(Note noteOnIndex) {
    values.notesStore.entityBeingEdited = noteOnIndex;
    values.notesStore.setColor(noteOnIndex.color);
    values.notesStore.setStackIndex(1);
  }

  Future _deleteNote(Note noteOnIndex) async {
    int result = await values.notesDB.delete(noteOnIndex.id!);
    if(result == 1){
      print('$result note was deleted');
    }
    values.notesStore.loadData(values.notesDB, 'notes');
  }
}
