// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotesStore on _NotesStore, Store {
  final _$colorAtom = Atom(name: '_NotesStore.color');

  @override
  String? get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(String? value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$_NotesStoreActionController = ActionController(name: '_NotesStore');

  @override
  void setColor(String? inColor) {
    final _$actionInfo =
        _$_NotesStoreActionController.startAction(name: '_NotesStore.setColor');
    try {
      return super.setColor(inColor);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
color: ${color}
    ''';
  }
}
