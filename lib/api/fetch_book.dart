
import 'package:appwrite/appwrite.dart';

class AppwriteBook {
  final Databases databases;

  AppwriteBook({required this.databases});

  Future<void> fetchUsersBook(String userId) async {
    try {
      final response = await databases.listDocuments(
        databaseId: const String.fromEnvironment('APPWRITE_DATABASE_ID'), 
        collectionId: const String.fromEnvironment('APPWRITE_COLLECTION_USERSBOOKS_ID'),
        queries: [
          Query.equal('users', userId)
        ]
      );

      print(response.documents);

    } catch (e) {
      print(e);
    }
  }
}