import 'dart:typed_data';
import 'package:bookie/providers/user_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


void setUserName(String name, UserProvider userProvider) {
  userProvider.setUserName(name);
}

void setUserVerificationStatus(bool verified, UserProvider userProvider) {
  userProvider.setUserVerified(verified);
}

void setUserAvatar(Uint8List avatar, UserProvider userProvider) {
  userProvider.setUserAvatar(avatar);
}

void clearUser(UserProvider userProvider) {
  userProvider.setUserName("");
  userProvider.setUserAvatar(Uint8List(0));
  userProvider.setUserVerified(true);
  // clear the user_id from the persistent storage
  const storage = FlutterSecureStorage();
  storage.delete(key: "user_id");
}