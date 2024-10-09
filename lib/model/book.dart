class Book {
  final String _id;
  String name;
  String author;
  String coverUrl;

  Book(this._id, this.name, this.author, this.coverUrl);
  String get id => _id;
}