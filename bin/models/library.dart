import 'dart:convert';
import 'dart:io';

import 'book.dart';

class Library {
  List<Book> _bookList = [];
  static const String _path = 'bin/books.json';

  Library() {
    _loadBooks();
  }

  void addBook(String title, String author, String year) {
    int id = _bookList.length + 1;
    _bookList.add(Book.byYearString(id: id, title: title, author: author, year: year));
    print('Book added successfully');
    saveBooks();
  }

  void viewBooks() {
    if (_bookList.isEmpty) {
      print('No books in the library');
      return;
    }
    for (Book book in _bookList) {
      print(book);
    }
    printEmptyLine();
    printEmptyLine();
  }

  void checkoutBook(int id) {
    _updateBookAvailableStatus(id, false);
  }

  void returnBook(int id) {
    _updateBookAvailableStatus(id, true);
  }

  static printEmptyLine() {
    print('');
  }

  Book? _findBookById(int id) {
    int index = _bookList.indexWhere((Book book) => book.id == id);
    if (index == -1) {
      return null;
    }
    return _bookList.elementAt(index);
  }

  void _updateBookAvailableStatus(int id, bool status) {
    Book? book = _findBookById(id);
    if (book != null) {
      book.isAvailable = status;
      print(status ? 'Book returned successfully' : 'Book checked out successfully');
      return;
    }
    print('Book not found 🥺');
  }

  saveBooks() {
    List<Map<String, dynamic>> map = _bookList.map((Book book) => book.toJson()).toList();
    String jsonEncode2 = jsonEncode(map);
    File(_path).writeAsStringSync(jsonEncode2);
  }

  void _loadBooks() {
    List<dynamic> jsonData = jsonDecode(File(_path).readAsStringSync());
    _bookList = jsonData.map((item) => Book.fromJson(item)).toList();
  }
}
