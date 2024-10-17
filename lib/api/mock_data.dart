import 'package:bookie/model/author.dart';
import 'package:bookie/model/book.dart';
import 'package:bookie/model/categories.dart';

class MockData {
  static List<Categories> categories = [
    Categories("1", "Technology"),
    Categories("2", "Science"),
    Categories("3", "Fiction"),
    Categories("4", "Non-Fiction"),
    Categories("5", "Biography"),
    Categories("6", "Self-Help"),
    Categories("7", "Fantasy"),
    Categories("8", "Mystery"),
    Categories("9", "Thriller"),
    Categories("10", "Romance"),
  ];
  static final author = Author("1", "Jonathan Corbet");
  static final book = Book("1", "Linux Device Drivers", "The Linux Device Drivers is the book about how drivers interacts with operating systems kernel" ,[author], "https://lwn.net/Kernel/LDD3/cover.gif", [categories[0]]);
  static final books = <Book>[]; // Initialize an empty list of books
  // initializeBooks in the constructor
  MockData() {
    _initializeBooks();
  }
  static void _initializeBooks() {
    for (var i = 1; i <= 10; i++) {
      // Create new books with the same details but different IDs
      final newBook = Book(i.toString() , "Linux Device Drivers", "The Linux Device Drivers is the book about how drivers interacts with operating systems kernel", [author], "https://lwn.net/Kernel/LDD3/cover.gif", [categories[0]]);
      books.add(newBook); // Add the book to the list
    }
  }
}