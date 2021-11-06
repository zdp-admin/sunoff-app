import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';

class AccountStatusBloc {
  final _dateInitial = BehaviorSubject<DateTime?>();
  final _dateEnd = BehaviorSubject<DateTime?>();
  final _loading = BehaviorSubject<bool?>();

  AccountStatusBloc() {
    this._dateInitial.sink.add(DateTime.now());
    this._dateEnd.sink.add(DateTime.now());
    this._loading.sink.add(false); 
  }

  Stream<DateTime?> get dateInitialStream => _dateInitial.stream;
  Stream<DateTime?> get dateEndStream => _dateEnd.stream;
  Stream<bool?> get loadingStream => _loading.stream;

  Function(DateTime) get changeDateInitial => _dateInitial.sink.add;
  Function(DateTime) get changeDateEnd => _dateEnd.sink.add;
  Function(bool) get changeLoading => _loading.sink.add;

  String get dateInitialToString =>
      DateFormat('dd/MM/yyyy').format(_dateInitial.value ?? DateTime.now());
  String get dateEndToString => DateFormat('dd/MM/yyyy').format(_dateEnd.value ?? DateTime.now());

  DateTime? get dateInitial => _dateInitial.valueOrNull;
  DateTime? get dateEnd => _dateEnd.valueOrNull;
  bool? get loading => _loading.valueOrNull;

  dispose() {
    _dateInitial.close();
    _dateEnd.close();
    _loading.close();
  }
}
