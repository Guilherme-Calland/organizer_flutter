// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppointmentsStore on _AppointmentsStore, Store {
  final _$apptTimeAtom = Atom(name: '_AppointmentsStore.apptTime');

  @override
  String get apptTime {
    _$apptTimeAtom.reportRead();
    return super.apptTime;
  }

  @override
  set apptTime(String value) {
    _$apptTimeAtom.reportWrite(value, super.apptTime, () {
      super.apptTime = value;
    });
  }

  final _$_AppointmentsStoreActionController =
      ActionController(name: '_AppointmentsStore');

  @override
  void setApptTime(String inApptTime) {
    final _$actionInfo = _$_AppointmentsStoreActionController.startAction(
        name: '_AppointmentsStore.setApptTime');
    try {
      return super.setApptTime(inApptTime);
    } finally {
      _$_AppointmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
apptTime: ${apptTime}
    ''';
  }
}
