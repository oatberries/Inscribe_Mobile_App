import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService {

  static final DataService _instance = DataService._internal();
  FlutterSecureStorage secureStorage = new FlutterSecureStorage();

  // Initizlize the flutter secure sctr
  DataService._internal() {
    secureStorage = const FlutterSecureStorage();
  }

  static DataService get getInstance => _instance;

  Future read(String key) async {
    return await secureStorage.read(key: key);
  }


  ///Stores the token into the secure storage
  void addItem(String key, String value) async{
    await secureStorage.write(key: key, value: value);
  }

  void delete(String key) async{
      await secureStorage.deleteAll();
  }
}