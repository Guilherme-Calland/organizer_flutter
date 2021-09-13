import 'package:mobx/mobx.dart';
import 'package:organizer/model/note.dart';
import 'package:organizer/model/task.dart';

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

  @observable
  String chosenDate = '';

  //ACTIONS
  @action
  void setStackIndex(int inIndex){
    stackIndex = inIndex;
  }

  @action
  void setChosenDate(String inDate){
    chosenDate = inDate;
    print(chosenDate);
  }

  @action
  Future<void> loadData(dynamic inDatabase, String type) async {
    List<Map<String, dynamic>> rawData = await inDatabase.read();
    entityList = _convertToSpecificType(rawData, type);
  }

  List<dynamic> _convertToSpecificType(List<Map<String, dynamic>> rawData, String type) {
    List entityListTemp = [];
    rawData.forEach((entityMap) {
      dynamic entity;
      switch(type){
        case 'notes' : entity = Note.mapToNote(entityMap); break;
        case 'tasks' : entity = Task.mapToTask(entityMap); break;
      }
      entityListTemp.add(entity);
    });
    return entityListTemp;
  }

  @action
  void triggeredInitialLoadDataFlag(){
    initialLoadDataFlag = false;
  }
}