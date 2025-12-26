import 'package:flutter/widgets.dart';
import 'package:ghost/core/models/password.dart';
import 'package:ghost/core/models/username.dart';

enum Mode { isLogin, isSignup }

class UserModel with ChangeNotifier {
  Username username = Username(username: '');
  Password password = Password(password: '');

  Mode _mode = Mode.isLogin;

  bool get isLogin => _mode == Mode.isLogin;
  bool get isSignup => _mode == Mode.isSignup;

  void changeMode() {
    _mode = isLogin ? Mode.isSignup : Mode.isLogin;
    notifyListeners();
  }
}
