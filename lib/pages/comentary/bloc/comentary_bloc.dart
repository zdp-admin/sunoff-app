import 'package:sunoff/models/cotizacion/seccion_modelo.dart';
import 'package:rxdart/rxdart.dart';

class ComentaryBloc {
  final _comentaryController = BehaviorSubject<String>();
  final _priceForSeccionController = BehaviorSubject<double>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<String> get comentaryStream => _comentaryController.stream;
  Stream<double> get priceForSeccionStream => _priceForSeccionController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<bool> get formValidStream =>
      Rx.combineLatest([priceForSeccionStream], (values) => true);

  Function(String) get changeComentary => _comentaryController.sink.add;
  Function(double) get changePriceForSeccion =>
      _priceForSeccionController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  String get comentary => _comentaryController.valueOrNull ?? '';
  double get priceForSeccion => _priceForSeccionController.valueOrNull ?? 0.0;
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
    _priceForSeccionController.close();
    _loadingController.close();
  }
}
