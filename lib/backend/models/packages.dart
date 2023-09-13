import '/package.dart';

class Packages {
  late Box<dynamic> box;

  Packages() {
    init().then((value) {
      box.clear();
    });
  }

  Future<Box> init() {
    return Hive.openBox('packages').then((db) {
      box = db;
      return box;
    });
  }

  Future putAll(Map<dynamic, dynamic> entries) {
    return box.putAll(entries).then((a) {
      return init().then((b) {
        return true;
      });
    });
  }

  Future put(dynamic key, dynamic value) {
    return box.put(key, value).then((a) {
      return init().then((b) {
        return true;
      });
    });
  }
}
