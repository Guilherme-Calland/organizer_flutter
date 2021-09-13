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
                      keyboardType: TextInputType.visiblePassword,
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
                      initialValue: values.notesStore.entityBeingEdited.content,
                      keyboardType: TextInputType.visiblePassword,
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
                        OrganizerColorSticker(inColor: Color(0xffff75c8), inColorName: 'pink',),
                        OrganizerColorSticker(inColor: Colors.blue, inColorName: 'blue',),
                        OrganizerColorSticker(inColor: Colors.yellow, inColorName: 'yellow',),
                        OrganizerColorSticker(inColor: Colors.orange, inColorName: 'orange',),
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
            _saveNote(inContext);
          },
        );
      },
    );
  }

  _saveNote(BuildContext inContext) async {
    if (!_inputIsValid()) return;
    Note inNote = values.notesStore.entityBeingEdited;
    Map<String, dynamic> inData = inNote.noteToMap();

    if(inNote.id == null){
      int result = await values.notesDB.create(inData);
      if (result > 0) {
        await values.notesStore.loadData(values.notesDB);
        print('created note of id $result successfully');
      }
    }else{
      int result = await values.notesDB.update(inData);
      if(result == 1){
        print('$result note updated successfully');
      }
    }
    utils.hideKeyboard(inContext);
    values.notesStore.setStackIndex(0);
  }

  bool _inputIsValid(){
    if(_formKey.currentState != null){
      if(!_formKey.currentState!.validate()){
        return false;
      }
    }
    return true;
  }
}


