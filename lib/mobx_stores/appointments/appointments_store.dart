import 'package:mobx/mobx.dart';
import 'package:organizer/mobx_stores/entity_store.dart';

part 'appointments_store.g.dart';

class AppointmentsStore = _AppointmentsStore with _$AppointmentsStore;

abstract class _AppointmentsStore extends EntityStore with Store {

  //OBSERVABLES
  @observable
  String apptTime = '';

  //ACTIONS
  @action
  void setApptTime(String inApptTime){
    apptTime = inApptTime;
  }
}