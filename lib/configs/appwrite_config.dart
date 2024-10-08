import 'package:appwrite/appwrite.dart';


Client client = Client();

const String endpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
const String projectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
Databases? _databases;
Account? _account;
Avatars? _avatars;



void initializeAppwriteClient(){
  client
    .setEndpoint(endpoint)  // Access endpoint from env file
    .setProject(projectId);

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