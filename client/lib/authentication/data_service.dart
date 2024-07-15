import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // I was following a youtube video for this lol

  ///Stores the token into the secure storage
  Future<bool?> addItem(String key, String value) async{
    try {
      // if 
      if(await secureStorage.read(key: key) == null) {
        await secureStorage.write(key: key, value: value);
        return true;
      } else {
        return false;
      }
    } catch(error) {
      print(error);
      return false;
    }
  }

  ///Grab token method
  Future<String?> TryGetItem(String key) async {
    try {
      return await secureStorage.read(key: key);
    } catch (error) {
      print(error);
      return null;
    }
  }
}