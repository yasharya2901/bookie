import 'package:bookie/model/author.dart';
import 'package:bookie/model/categories.dart';

class Book {
  final String _id;
  String name;
  List<Author> author;
  String? description;
  String coverUrl;
  DateTime? publishedDate;
  List<Categories> categories;

  Book(this._id, this.name, this.description, this.author, this.coverUrl, this.categories);
  String get id => _id;
}