import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/validators.dart';

class ApointmentBloc with Validators {
  final _dateController = BehaviorSubject<DateTime>();
  final _scheduleController = BehaviorSubject<TimeOfDay>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<DateTime> get dateStream =>
      _dateController.stream.transform(validateDate);
  Stream<TimeOfDay> get scheduleStream => _scheduleController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<bool> get formValidStream => Rx.combineLatest2(
      dateStream,
      scheduleStream,
      (
        dynamic a,
        dynamic b,
      ) =>
          true);

  Function(DateTime) get changeDate => _dateController.sink.add;
  Function(TimeOfDay) get changeSchedule => _scheduleController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  DateTime? get date => _dateController.value;
  TimeOfDay? get schedule => _scheduleController.value;
  bool? get loading => _loadingController.value;

  String get dateToString =>
      DateFormat('yyyy-MM-dd').format(_dateController.value);

  String get scheduleToString =>
      '${schedule!.hour.toString().padLeft(2, '0')}:${schedule!.minute.toString().padLeft(2, '0')}';

  ApointmentBloc() {
    this._loadingController.sink.add(false);
  }

  disponse() {
    _dateController.close();
    _scheduleController.close();
    _loadingController.close();
  }
}
