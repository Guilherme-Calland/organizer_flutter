import 'package:mobx/mobx.dart';
import 'package:organizer/mobx_stores/entity_store.dart';
part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore extends EntityStore with Store{

  //OBSERVABLE
  @observable
  String? color;

  //ACTION
  @action
  void setColor(String? inColor){
    color = inColor;
  }
}