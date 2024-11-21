import '../models/book.dart';
import '../services/storage.dart';

class Library {
  List<Book> _bookList = [];

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
      Storage().updateData(book);
      return;
    }
    print('Book not found 🥺');
  }

  saveBooks() {
    for (Book book in _bookList) {
      Storage().saveData(book.getStorageKey(), book.toJson());
    }
  }

  void _loadBooks() {
    List<Map> allData = Storage().getAllData();
    _bookList = allData.map((Map item) => Book.fromJson(item.cast())).toList();
  }
}
