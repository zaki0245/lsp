import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String username = '';
  String password = '';

  void setUser(String newUsername, String newPassword) {
    username = newUsername;
    password = newPassword;
    notifyListeners();
  }

  void changePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }
}
