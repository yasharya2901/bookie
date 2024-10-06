import 'dart:typed_data';
import 'package:bookie/providers/user_provider.dart';


void setUserName(String name, UserProvider userProvider) {
  userProvider.setUserName(name);
}

void setUserVerificationStatus(bool verified, UserProvider userProvider) {
  userProvider.setUserVerified(verified);
}

void setUserAvatar(Uint8List avatar, UserProvider userProvider) {
  userProvider.setUserAvatar(avatar);
}