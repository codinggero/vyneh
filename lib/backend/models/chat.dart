import '/package.dart';

class Chat {
  late Box<dynamic> box;

  Chat() {
    init().then((value) {
      box.clear();
    });
  }

  Future<Box> init() {
    return Hive.openBox('chats').then((db) {
      box = db;
      return box;
    });
  }

  var chatuserlist = [
    {
      "id": 3,
      "first_name": "Advisor",
      "last_name": "Test",
      "image": null,
      "updated_at": "2023-07-20T04:43:39.000000Z"
    }
  ];
  var getuserchat = [
    {
      "id": 3,
      "sender_id": "26",
      "receiver_id": "39",
      "message": "DHA Pakistan",
      "is_read": "0",
      "message_type": "recieve"
    }
  ];
  var data = {"receiver_id": "39", "message": "Hi", "sender_id": 26};

  List get users => box.get('chat-user-list', defaultValue: []);
  List get chats => box.get('get-user-chat', defaultValue: []);
  List get messages => box.get('post-message', defaultValue: []);

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
