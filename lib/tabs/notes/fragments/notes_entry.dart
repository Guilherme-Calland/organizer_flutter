import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:organizer/model/note.dart';
import 'package:organizer/res/utils.dart' as utils;
import 'package:organizer/res/values.dart' as values;
import 'package:organizer/widgets/organizer_color_sticker.dart';
import 'package:organizer/widgets/organizer_container.dart';
import 'package:organizer/widgets/organizer_entry_fragment.dart';

class NotesEntry extends StatelessWidget {
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
                    leading: Icon(Icons.task),
                    title: TextFormField(
                      initialValue: values.notesStore.entityBeingEdited.title,
                      decoration: InputDecoration(hintText: 'Title'),
                      validator: (String? inValue) {
                        if (inValue == '') {
                          return 'Please enter a valid Title';
                        }
                      },
                      onChanged: (String inValue){
                        values.notesStore.entityBeingEdited.title = inValue;
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.content_paste),
                    title: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      decoration: InputDecoration(hintText: 'Content'),
                      onChanged: (String inValue){
                        values.notesStore.entityBeingEdited.content = inValue;
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.color_lens),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OrganizerColorSticker(inColor: Colors.red, inColorName: 'red',),
                        OrganizerColorSticker(inColor: Colors.green, inColorName: 'green',),
                        OrganizerColorSticker(inColor: Colors.blue, inColorName: 'blue',),
                        OrganizerColorSticker(inColor: Colors.yellow, inColorName: 'yellow',),
                        OrganizerColorSticker(inColor: Colors.grey, inColorName: 'grey',),
                        OrganizerColorSticker(inColor: Colors.purple, inColorName: 'purple',),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          onCancelPressed: () {
            utils.hideKeyboard(inContext);
            values.notesStore.setStackIndex(0);
          },
          onSavePressed: () {
            utils.hideKeyboard(inContext);
            _saveNote(inContext);
            values.notesStore.setStackIndex(0);
          },
        );
      },
    );
  }

  _saveNote(BuildContext inContext) async{
    if(_formKey.currentState != null){
      if(!_formKey.currentState!.validate()){
        return;
      }
    }
    Note inNote = values.notesStore.entityBeingEdited;
    Map<String, dynamic> inData = inNote.noteToMap();
    int result = await values.notesDB.create(inData);
    if(result > 0){
      utils.showSnackBar(inContext, inText: 'Note Saved', inColor: Colors.grey);
    }
  }
}


