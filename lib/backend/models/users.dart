import '/package.dart';

class Userss {
  late Box<dynamic> box;

  Userss() {
    init().then((value) {
      box.clear();
    });
  }

  Future<Box> init() {
    return Hive.openBox('users').then((db) {
      box = db;
      return box;
    });
  }

  get address => box.get('address');
  get cnicBack => box.get('cnic_back');
  get cnicFront => box.get('cnic_front');
  get contact => box.get('contact');
  get createdAt => box.get('created_at');
  get currentLat => box.get('current_lat');
  get currentLng => box.get('current_long');
  get deletedAt => box.get('deleted_at');
  get dob => box.get('dob');
  get drivingLinence => box.get('driving_linence');
  get email => box.get('email');
  get emailVerifiedAt => box.get('email_verified_at');
  get firstName => box.get('first_name');
  get id => box.get('id');
  get image => box.get('image');
  get lastName => box.get('last_name');
  get otp => box.get('otp');
  get password => box.get('password');
  get phoneVerifiedAt => box.get('phone_verified_at');
  get role => box.get('role');
  get roles => box.get('roles');
  get status => box.get('status');
  get token => box.get('token');
  get updatedAt => box.get('updated_at');
  get user => box.get('user');
  get username => box.get('username');
  get currentUser => box.get('currentUser');
  get notificationList => box.get('notificationList');
  get packageDelivery => box.get('package_delivery');
  get chatUserList => box.get('chat_user_list', defaultValue: [
        {
          "id": id,
          "first_name": firstName,
          "last_name": lastName,
          "image": image,
          "updated_at": DateTime.now()
        }
      ]);
  get getUserChat => box.get('get_user_chat', defaultValue: [
        {
          "id": 0,
          "sender_id": id,
          "receiver_id": id,
          "message": "Send Test",
          "is_read": "0",
          "message_type": "send"
        },
        {
          "id": 0,
          "sender_id": id,
          "receiver_id": id,
          "message": "Recieve Test",
          "is_read": "0",
          "message_type": "recieve"
        },
      ]);

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
