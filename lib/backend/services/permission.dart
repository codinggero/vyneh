import '/package.dart';

class Perm {
  static Perm get instance {
    return Perm();
  }

  Future init(Permission permission) async {
    return permission.status.then((status) {
      if (status.isGranted) {
        return true;
      } else if (status.isDenied) {
        return request(permission).then((req) {
          return req;
        });
      }
    });
  }

  Future status(Permission permission) async {
    return permission.status.then((status) {
      return status;
    });
  }

  Future request(Permission permission) async {
    return permission.request().then((status) {
      return status;
    });
  }

  Future multiPermissionStatus(List<Permission> collection) async {
    for (var permission in collection) {
      PermissionStatus permissionStatus = await permission.status;
      if (permissionStatus.isDenied) {
        return Future.error(
          "${permission.toString().split('.').join(' ')} Status is ${permissionStatus.name} Please Enable."
              .toUpperCase(),
        );
      }
      if (permissionStatus.isPermanentlyDenied) {
        return Future.error(
          "${permission.toString().split('.').join(' ')} Status is ${permissionStatus.name} Please Enable."
              .toUpperCase(),
        );
      }
    }

    return true;
  }

  Future multiServiceStatus(List<PermissionWithService> collection) async {
    for (var permission in collection) {
      ServiceStatus serviceStatus = await permission.serviceStatus;
      if (serviceStatus.isDisabled) {
        return Future.error(
          "${permission.toString().split('.').join(' ')} Service is ${serviceStatus.name} Please Enable."
              .toUpperCase(),
        );
      }
    }
    return true;
  }

  Future<bool> service(PermissionWithService permission) async {
    return permission.serviceStatus.then((status) {
      if (status.isEnabled) {
        return true;
      } else {
        return false;
      }
    });
  }
}
