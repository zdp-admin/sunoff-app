import 'package:rxdart/rxdart.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/models/installer.dart';
import 'package:sunoff/utils/validators.dart';

class InstallerBloc with Validators {
  BehaviorSubject<String> _addressController = BehaviorSubject<String>();
  BehaviorSubject<int> _assistantController = BehaviorSubject<int>();
  BehaviorSubject<int> _typeBuildingCountController = BehaviorSubject<int>();
  BehaviorSubject<String> _timeInController = BehaviorSubject<String>();
  BehaviorSubject<String> _timeOutController = BehaviorSubject<String>();
  BehaviorSubject<int> _glassesInstalledController = BehaviorSubject<int>();
  BehaviorSubject<double> _mtsInstalledController = BehaviorSubject<double>();
  BehaviorSubject<List<Pelis>> _filmsController =
      BehaviorSubject<List<Pelis>>();
  BehaviorSubject<String> _commentaryController = BehaviorSubject<String>();

  Stream<String> get addressStream =>
      _addressController.stream.transform(validateEmpty);
  Stream<int> get assistantStream => _assistantController.stream;
  Stream<int> get typeBuildingStream => _typeBuildingCountController.stream;
  Stream<String> get timeInStream => _timeInController.stream;
  Stream<String> get timeOutStream => _timeOutController.stream;
  Stream<int> get glassesInstalledStream => _glassesInstalledController.stream;
  Stream<double> get mtsInstalledStream => _mtsInstalledController.stream;
  Stream<List<Pelis>> get filmsStream => _filmsController.stream;
  Stream<String> get commentaryStream => _commentaryController.stream;
  /*Stream<bool> get formValidStream => Rx.combineLatest3(
      addressStream, typeBuildingStream, peliculasStream, (a, b, c) => true);*/

  Function(String) get changeAddress => _addressController.sink.add;
  Function(int) get changeAssistant => _assistantController.sink.add;
  Function(int) get changeTypeBuilding => _typeBuildingCountController.sink.add;
  Function(String) get changeTimeIn => _timeInController.sink.add;
  Function(String) get changeTimeOut => _timeOutController.sink.add;
  Function(int) get changeGlassesInstalled =>
      _glassesInstalledController.sink.add;
  Function(double) get changeMtsInstalled => _mtsInstalledController.sink.add;
  Function(List<Pelis>) get changeFilms => _filmsController.sink.add;
  Function(String) get changeCommentary => _commentaryController.sink.add;

  String get address => _addressController.valueOrNull ?? '';
  int get assistant => _assistantController.valueOrNull ?? 0;
  int get typeBuilding => _typeBuildingCountController.valueOrNull ?? 0;
  String get timeIn => _timeInController.valueOrNull ?? '';
  String get timeOut => _timeOutController.valueOrNull ?? '';
  int get glassesInstalled => _glassesInstalledController.valueOrNull ?? 0;
  double get mstInstalled => _mtsInstalledController.valueOrNull ?? 0;
  List<Pelis> get films => _filmsController.valueOrNull ?? [];
  String get commentary => _commentaryController.valueOrNull ?? '';

  InstallerModel toModel() {
    InstallerModel installerModel = new InstallerModel(films: []);
    installerModel.address = this.address;
    installerModel.assistant = this.assistant;
    installerModel.typeBuilding = this.typeBuilding;
    installerModel.timeIn = this.timeIn;
    installerModel.timeOut = this.timeOut;
    installerModel.glassesInstalled = this.glassesInstalled;
    installerModel.mtsInstalled = this.mstInstalled;
    installerModel.films = this.films;
    installerModel.commentary = this.commentary;

    return installerModel;
  }

  void clear() {
    this._addressController = BehaviorSubject<String>();
    this._assistantController = BehaviorSubject<int>();
    this._typeBuildingCountController = BehaviorSubject<int>();
    this._timeInController = BehaviorSubject<String>();
    this._timeOutController = BehaviorSubject<String>();
    this._glassesInstalledController = BehaviorSubject<int>();
    this._mtsInstalledController = BehaviorSubject<double>();
    this._filmsController = BehaviorSubject<List<Pelis>>();
    this._commentaryController = BehaviorSubject<String>();
  }

  dispose() {
    _addressController.close();
    _assistantController.close();
    _typeBuildingCountController.close();
    _timeInController.close();
    _timeOutController.close();
    _glassesInstalledController.close();
    _mtsInstalledController.close();
    _filmsController.close();
    _commentaryController.close();
  }
}
