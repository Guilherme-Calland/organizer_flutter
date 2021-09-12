import 'package:mobx/mobx.dart';

part 'entity_store.g.dart';

class EntityStore = _EntityStore with _$EntityStore;

abstract class _EntityStore with Store {

  //OBSERVABLES
  @observable
  var entityBeingEdited;

  @observable
  int stackIndex = 0;

  @observable
  List entityList = [];

  @observable
  String? chosenDate = '';

  //ACTIONS
  @action
  void setStackIndex(int inIndex){
    stackIndex = inIndex;
  }

  @action
  void setChosenDate(String? inDate){
    chosenDate = inDate;
  }

  @action
  Future<void> loadData(dynamic inDatabase) async {
    List<Map<String, dynamic>> rawData = await inDatabase.read();
  }

}