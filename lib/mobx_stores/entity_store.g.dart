// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EntityStore on _EntityStore, Store {
  final _$entityBeingEditedAtom = Atom(name: '_EntityStore.entityBeingEdited');

  @override
  dynamic get entityBeingEdited {
    _$entityBeingEditedAtom.reportRead();
    return super.entityBeingEdited;
  }

  @override
  set entityBeingEdited(dynamic value) {
    _$entityBeingEditedAtom.reportWrite(value, super.entityBeingEdited, () {
      super.entityBeingEdited = value;
    });
  }

  final _$stackIndexAtom = Atom(name: '_EntityStore.stackIndex');

  @override
  int get stackIndex {
    _$stackIndexAtom.reportRead();
    return super.stackIndex;
  }

  @override
  set stackIndex(int value) {
    _$stackIndexAtom.reportWrite(value, super.stackIndex, () {
      super.stackIndex = value;
    });
  }

  final _$entityListAtom = Atom(name: '_EntityStore.entityList');

  @override
  List<dynamic> get entityList {
    _$entityListAtom.reportRead();
    return super.entityList;
  }

  @override
  set entityList(List<dynamic> value) {
    _$entityListAtom.reportWrite(value, super.entityList, () {
      super.entityList = value;
    });
  }

  final _$initialLoadDataFlagAtom =
      Atom(name: '_EntityStore.initialLoadDataFlag');

  @override
  bool get initialLoadDataFlag {
    _$initialLoadDataFlagAtom.reportRead();
    return super.initialLoadDataFlag;
  }

  @override
  set initialLoadDataFlag(bool value) {
    _$initialLoadDataFlagAtom.reportWrite(value, super.initialLoadDataFlag, () {
      super.initialLoadDataFlag = value;
    });
  }

  final _$loadDataAsyncAction = AsyncAction('_EntityStore.loadData');

  @override
  Future<void> loadData(dynamic inDatabase) {
    return _$loadDataAsyncAction.run(() => super.loadData(inDatabase));
  }

  final _$_EntityStoreActionController = ActionController(name: '_EntityStore');

  @override
  void setStackIndex(int inIndex) {
    final _$actionInfo = _$_EntityStoreActionController.startAction(
        name: '_EntityStore.setStackIndex');
    try {
      return super.setStackIndex(inIndex);
    } finally {
      _$_EntityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void triggeredInitialLoadDataFlag() {
    final _$actionInfo = _$_EntityStoreActionController.startAction(
        name: '_EntityStore.triggeredInitialLoadDataFlag');
    try {
      return super.triggeredInitialLoadDataFlag();
    } finally {
      _$_EntityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
entityBeingEdited: ${entityBeingEdited},
stackIndex: ${stackIndex},
entityList: ${entityList},
initialLoadDataFlag: ${initialLoadDataFlag}
    ''';
  }
}
