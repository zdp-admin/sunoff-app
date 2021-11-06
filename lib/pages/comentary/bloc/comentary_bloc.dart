import 'package:sunoff/models/cotizacion/seccion_modelo.dart';
import 'package:rxdart/rxdart.dart';

class ComentaryBloc {
  final _comentaryController = BehaviorSubject<String>();
  final _loadingController = BehaviorSubject<bool>();
  //final _listController = BehaviorSubject<List<String>>();

  Stream<String> get comentaryStream => _comentaryController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  /*Stream<bool> get formValidStream =>
      Rx.combineLatest([comentaryStream], (values) => true);*/

  Function(String) get changeComentary => _comentaryController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  String get comentary => _comentaryController.valueOrNull ?? '';
  bool get loading => _loadingController.valueOrNull ?? false;

  ComentaryBloc() {
    this._loadingController.sink.add(false);
  }

  SeccionModelo toModel() {
    SeccionModelo section = new SeccionModelo();
    return section;
  }

  dispose() {
    _comentaryController.close();
    _loadingController.close();
  }
}
