import 'package:appwrite/models.dart';
import 'package:bookie/configs/appwrite_config.dart';
import 'package:appwrite/appwrite.dart';
import 'package:bookie/model/book.dart';



Future<List<Book>> fetchUserBooks(String userId) async {
  try {
    Databases? databases = appwriteDatabase();
    if (databases == null) {
      throw Exception('Appwrite Databases not found');
    }
    final response = await databases.listDocuments(
      databaseId: const String.fromEnvironment('APPWRITE_DATABASE_ID'), 
      collectionId: const String.fromEnvironment('APPWRITE_COLLECTION_USERSBOOKS_ID'),
      queries: [
        Query.equal('users', userId)
      ]
    );
    
    List<Book> books = [];
    for (Document document in response.documents) {
      Book book = Book(
        document.$id,
        document.data['books']['title'],
        document.data['books']['authors'][0]['name'],
        "https://placehold.it/200x300"
      );
      books.add(book);
    }
    return books;

  } catch (e) {
    throw Exception('Failed to load user books');
  }
}
