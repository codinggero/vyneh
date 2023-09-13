import '/package.dart';

export 'models/index.dart';
export 'services/index.dart';
export 'mixins/index.dart';
export 'enum/index.dart';

class Api {
  Perm permissions = Perm();
  Request request = Request();
  Userss user = Userss();
  Packages package = Packages();
  Chat chat = Chat();
  Google google = Google();

  static Api get instance {
    return Api();
  }

  void backend() {
    request.notificationList(
      onIndicator: (response) {},
      onCache: (res) {},
      onSuccess: (response) {},
      onError: (err) {},
    );
  }

  Future init() {
    return user.init().then((value) {
      return true;
    });
  }
}
