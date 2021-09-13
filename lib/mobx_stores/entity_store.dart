import 'package:mobx/mobx.dart';
import 'package:organizer/model/note.dart';

part 'entity_store.g.dart';

class EntityStore = _EntityStore with _$EntityStore;

abstract class _EntityStore with Store {

  //OBSERVABLES
  @observable
  dynamic entityBeingEdited;

  @observable
  int stackIndex = 0;

  @observable
  List entityList = [];

  @observable
  bool initialLoadDataFlag = true;

  //ACTIONS
  @action
  void setStackIndex(int inIndex){
    stackIndex = inIndex;
  }

  @action
  Future<void> loadData(dynamic inDatabase) async {
    List<Map<String, dynamic>> rawData = await inDatabase.read();
    List<Note> noteList = [];
    rawData.forEach((element) {
      Note note = Note.mapToNote(element);
      noteList.add(note);
    });
    print(noteList);
    entityList = noteList;
  }

  @action
  void triggeredInitialLoadDataFlag(){
    initialLoadDataFlag = false;
  }

}