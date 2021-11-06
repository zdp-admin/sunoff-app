import 'package:sunoff/models/cotizacion/cliente_modelo.dart';
import 'package:sunoff/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

class NewPricingBloc with Validators {
  BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  BehaviorSubject<String> _addressController = BehaviorSubject<String>();
  BehaviorSubject<int> _typeBuildingController = BehaviorSubject<int>();
  final _loadingController = BehaviorSubject<bool>();
  //final _listController = BehaviorSubject<List<String>>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(validateEmpty);
  Stream<String> get addressStream =>
      _addressController.stream.transform(validateEmpty);
  Stream<int> get typeBuildingStream => _typeBuildingController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<bool> get formValidStream => Rx.combineLatest2(
      nameStream,
      addressStream,
      //typeBuildingStream,
      (
        dynamic a,
        dynamic b,
        /*dynamic c*/
      ) =>
          true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeAddress => _addressController.sink.add;
  Function(int) get changetypeBuilding => _typeBuildingController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  String get name => _nameController.valueOrNull ?? '';
  String get address => _addressController.valueOrNull ?? '';
  int get typeBuilding => _typeBuildingController.valueOrNull ?? 0;
  bool get loading => _loadingController.valueOrNull ?? false;

  NewPricingBloc() {
    this._loadingController.sink.add(false);
  }

  ClienteModelo toModelClient() {
    ClienteModelo client = new ClienteModelo();
    client.name = this.name;
    client.address = this.address;
    return client;
  }

  void clear() {
    this._nameController = BehaviorSubject<String>();
    this._addressController = BehaviorSubject<String>();
    this._typeBuildingController = BehaviorSubject<int>();
  }

  dispose() {
    _nameController.close();
    _addressController.close();
    _typeBuildingController.close();
    _loadingController.close();
  }
}
