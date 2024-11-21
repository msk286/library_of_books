import 'dart:io';

import 'services/library_service.dart';
import 'services/storage.dart';

void main() async {
  await Storage.init();

  Library lib = Library();

  bool isWorking = true;

  print('Welcome to the library management system');

  const List<String> messages = [
    'Please choose an option:', // 0
    'Add a new book', // 1
    'View all books', // 2
    'Checkout a book', // 3
    'Return a book', // 4
    'Exit', // 5
  ];

  while (isWorking) {
    for (int i = 0; i < messages.length; i++) {
      String msg = messages[i];
      if (i == 0) {
        print(msg);
      } else {
        print('$i. $msg');
      }
    }

    stdout.write('Enter your choice (1 - ${messages.length - 1}):');
    Library.printEmptyLine();

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter book title:');
        String? title = stdin.readLineSync();
        stdout.write('Enter book author:');
        String? author = stdin.readLineSync();
        stdout.write('Enter book year:');
        String? yearString = stdin.readLineSync();
        if (title != null && author != null && yearString != null) {
          lib.addBook(title, author, yearString);
        }
        break;

      case '2':
        lib.viewBooks();
        break;

      case '3':
        stdout.write('Enter book ID:');
        String? idString = stdin.readLineSync();
        int id = int.tryParse(idString ?? '') ?? 0;
        lib.checkoutBook(id);
        break;

      case '4':
        stdout.write('Enter book ID:');
        String? idString = stdin.readLineSync();
        int id = int.tryParse(idString ?? '') ?? 0;
        lib.returnBook(id);
        break;
      case '5':
        isWorking = false;
        break;
    }
  }
}
