// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaseStore on _BaseStore, Store {
  final _$entityBeingEditedAtom = Atom(name: '_BaseStore.entityBeingEdited');

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

  final _$stackIndexAtom = Atom(name: '_BaseStore.stackIndex');

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

  final _$entityListAtom = Atom(name: '_BaseStore.entityList');

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

  final _$chosenDateAtom = Atom(name: '_BaseStore.chosenDate');

  @override
  String? get chosenDate {
    _$chosenDateAtom.reportRead();
    return super.chosenDate;
  }

  @override
  set chosenDate(String? value) {
    _$chosenDateAtom.reportWrite(value, super.chosenDate, () {
      super.chosenDate = value;
    });
  }

  final _$loadDataAsyncAction = AsyncAction('_BaseStore.loadData');

  @override
  Future<void> loadData(dynamic inDatabase) {
    return _$loadDataAsyncAction.run(() => super.loadData(inDatabase));
  }

  final _$_BaseStoreActionController = ActionController(name: '_BaseStore');

  @override
  dynamic setChosenDate(String? inDate) {
    final _$actionInfo = _$_BaseStoreActionController.startAction(
        name: '_BaseStore.setChosenDate');
    try {
      return super.setChosenDate(inDate);
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
entityBeingEdited: ${entityBeingEdited},
stackIndex: ${stackIndex},
entityList: ${entityList},
chosenDate: ${chosenDate}
    ''';
  }
}
