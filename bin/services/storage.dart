import 'dart:io';

import 'package:hive_ce/hive.dart';

import '../models/book.dart';

class Storage {
  static Box<Map>? _box;

  static init() async {
    String myPath = '${Directory.current.path}/bin/box_storage';
    Hive.init(myPath);
    _box = await Hive.openBox('myLibrary');
  }

  Future<void> saveData(String key, Map value) {
    return _box!.put(key, value);
  }

  Map? readData(String key) {
    return _box!.get(key);
  }

  Future<void> deleteData(String key) {
    return _box!.delete(key);
  }

  bool checkDataExist(String key) {
    return _box!.containsKey(key);
  }

  Future<void> updateData(Book book) {
    String key = book.getStorageKey();
    Map<String, dynamic> value = book.toJson();
    return _box!.put(key, value);
  }

  Future<int> clearStorage() {
    return _box!.clear();
  }

  List<Map> getAllData() {
    return _box!.values.toList();
  }
}
