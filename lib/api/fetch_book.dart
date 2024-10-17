import 'package:appwrite/models.dart';
import 'package:bookie/configs/appwrite_config.dart';
import 'package:appwrite/appwrite.dart';
import 'package:bookie/model/author.dart';
import 'package:bookie/model/book.dart';
import 'package:bookie/model/categories.dart';



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
      List<Author> authorList = [];
      if (document.data['books']['authors'] != null) {
        var authorNames = document.data['books']['authors'];
        for (int i = 0; i < authorNames.length; i++) {
          authorList.add(Author(authorNames[i]['\$id'], authorNames[i]['name']));
        }
      }

      List<Categories> categoriesList = [];
      if (document.data['books']['categories'] != null) {
        var categoryNames = document.data['books']['categories'];
        for (int i = 0; i < categoryNames.length; i++) {
          categoriesList.add(Categories(categoryNames[i]['\$id'], categoryNames[i]['name']));
        }
      }

      Book book = Book(
        document.$id,
        document.data['books']['title'],
        document.data['books']['description'],
        authorList,
        "https://lwn.net/Kernel/LDD3/cover.gif",
        categoriesList,
      );

      if (document.data['books']['release_date'] != null) {
        book.publishedDate = DateTime.parse(document.data['books']['release_date']);
      }
      books.add(book);
    }
    return books;

  } catch (e) {
    throw Exception('Failed to load user books');
  }
}
