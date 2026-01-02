import 'package:ghost/constants/regex_password.dart';
import 'package:ghost/core/contracts/contract_user.dart';

class Username implements ContractUser {
  final String _username;

  Username({required String username}) : _username = username;

  @override
  String get getValue => _username;

  @override
  void validate() {
    final Map<bool, String> rules = {
      _username.isEmpty: 'Username cannot be empty',
      _username.length <= 5: 'Username too short, try another one',
      hasSpace.hasMatch(_username): 'The username cannot contain spaces',
    };
    for (final rule in rules.entries) {
      if (rule.key) {
        throw rule.value;
      }
    }
  }
}
