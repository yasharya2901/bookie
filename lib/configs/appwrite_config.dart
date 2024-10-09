import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';


Client client = Client();

const String endpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
const String projectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
Databases? _databases;
Account? _account;
Avatars? _avatars;
User? _user;



Future<void> initializeAppwriteClient() async{
  client
    .setEndpoint(endpoint)  // Access endpoint from env file
    .setProject(projectId);

  if (kDebugMode) {
    print("Appwrite Project ID: $projectId");
    print("Appwrite Endpoint: $endpoint");
  }  

  _databases = Databases(client);
  _account = Account(client);
  _avatars = Avatars(client);
}

Databases? appwriteDatabase() {
  return _databases;
}

Avatars? appwriteAvatars() {
  return _avatars;
}

Account? appwriteAccount() {
  return _account;
}

Future<User?> appwriteUser() async {
  _user = await _account?.get();
  return _user;
}