import 'package:mobx/mobx.dart';
import 'package:organizer/mobx_stores/entity_store.dart';
part 'tasks_store.g.dart';

class TasksStore = _TasksStore with _$TasksStore;

abstract class _TasksStore extends EntityStore with Store {

}