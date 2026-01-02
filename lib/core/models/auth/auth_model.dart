import 'package:flutter/widgets.dart';

enum Mode { isLogin, isSignup }

class AuthModel with ChangeNotifier {
  String username = '';
  String password = '';

  Mode _mode = Mode.isLogin;

  bool get isLogin => _mode == Mode.isLogin;

  bool get isSignup => _mode == Mode.isSignup;

  bool _isLoading = false;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  void changeMode() {
    _mode = isLogin ? Mode.isSignup : Mode.isLogin;
    notifyListeners();
  }
}
