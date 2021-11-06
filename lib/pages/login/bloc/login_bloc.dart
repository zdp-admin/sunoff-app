import 'package:sunoff/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _termAndConditionsController = BehaviorSubject<bool?>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(validEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validateEmpty);
  Stream<bool?> get termAndConditionsStream =>
      _termAndConditionsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  //Stream<bool>   get formValidStream => Rx.combineLatest3(emailStream, passwordStream, termAndConditionsStream, (a, b, c) => true);
  Stream<bool> get formValidStream => Rx.combineLatest2(
      emailStream, passwordStream, (dynamic a, dynamic b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(bool?) get changeTermAndConditions =>
      _termAndConditionsController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  bool? get termAndConditions => _termAndConditionsController.value;
  bool get loading => _loadingController.value;

  LoginBloc() {
    this._loadingController.sink.add(false);
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _termAndConditionsController.close();
    _loadingController.close();
  }
}
