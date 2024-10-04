class Book {
  final int _id;
  String name;
  String author;
  String coverUrl;

  Book(this._id, this.name, this.author, this.coverUrl);
  int get id => _id;
}