import 'package:appwrite/appwrite.dart';

void initializeAppwriteClient(Client client, String endpoint, String projectId){
  client
    .setEndpoint(endpoint)  // Access endpoint from env file
    .setProject(projectId);
}
    