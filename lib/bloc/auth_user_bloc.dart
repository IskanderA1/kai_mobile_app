import 'package:kai_mobile_app/model/user_response.dart';
import 'package:kai_mobile_app/repository/kai_repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthUserBloc{
  final KaiRepository _repository = KaiRepository();
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();

  auth(String login, String password) async{
    UserResponse response = await _repository.userAuth(login, password);
    _subject.sink.add(response);
  }
  authWithLocal() async{
    UserResponse response = await _repository.userAuthLocal();
    _subject.sink.add(response);
  }
  authLogOut(int semestrNum) async{
    UserResponse response = await _repository.userLogOut(semestrNum);
    _subject..sink.add(response);
  }
  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;

}
final authBloc = AuthUserBloc();