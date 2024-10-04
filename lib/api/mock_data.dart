import 'package:bookie/model/book.dart';

class MockData {
  static final book = Book(1, "Linux Device Drivers", "Jonathan Corbet", "https://lwn.net/Kernel/LDD3/cover.gif");
  static final books = <Book>[]; // Initialize an empty list of books

  static void initializeBooks() {
    for (var i = 1; i <= 10; i++) {
      // Create new books with the same details but different IDs
      final newBook = Book(i, "Linux Device Drivers", "Jonathan Corbet", "https://lwn.net/Kernel/LDD3/cover.gif");
      books.add(newBook); // Add the book to the list
    }
  }
}