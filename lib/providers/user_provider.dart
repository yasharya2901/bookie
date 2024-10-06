import 'dart:typed_data';

import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  String _userName = "";
  Uint8List? _userAvatarBytes;
  bool _userVerified = false;
  
  String get userName => _userName;
  Uint8List? get userAvatarBytes => _userAvatarBytes;
  bool get userVerified => _userVerified;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUserAvatar(Uint8List avatar) {
    _userAvatarBytes = avatar;
    notifyListeners();
  }

  void setUserVerified(bool verified) {
    _userVerified = verified;
    notifyListeners();
  }
}