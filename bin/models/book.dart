class Book {
  int id;
  String title;
  String author;
  int year;
  bool isAvailable;

  String getStorageKey() {
    return 'book_id_$id';
  }

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
    this.isAvailable = true,
  });

  factory Book.byYearString({
    required int id,
    required String title,
    required String author,
    required String year,
  }) {
    int yearInt = int.tryParse(year) ?? 0;
    return Book(id: id, title: title, author: author, year: yearInt);
  }

  @override
  toString() {
    return 'Id: $id | Title: $title | Author: $author | Year: $year | Status: ${!isAvailable ? "Unavailable" : "Available"}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'year': year,
      'isAvailable': isAvailable,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      year: json['year'],
      isAvailable: json['isAvailable'],
    );
  }
}
