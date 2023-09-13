import '/package.dart';

class Res {
  bool? success;
  dynamic data;
  int? status;
  String? message;

  Res({
    this.success = false,
    this.data = const [],
    this.status = 500,
    this.message = '700 Internal Error',
  });
}

class Request {
  containsKey(map, key) {
    if (map != null) {
      if (map.containsKey(key)) {
        return map[key];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  void toPrint(String endpoint, dynamic response) {
    if (response.runtimeType == Res) {
      Res res = response as Res;
      log("${{
        'endpoint': endpoint,
        'success': res.success,
        'status': res.status,
        'message': res.message,
        'data': res.data,
      }}");
    } else {
      Response res = response as Response;
      log("${{
        'endpoint': endpoint,
        'statusCode': res.statusCode,
        'statusMessage': res.statusMessage,
        'data': res.data,
      }}");
    }
  }

  Future<Dio> headers({
    String method = 'GET',
    String contentType = 'application/json',
  }) async {
    final dio = Dio();
    dio.options.baseUrl = Config.baseUrl;
    dio.options.contentType = contentType;
    dio.options.method = method;
    dio.options.responseType = ResponseType.json;
    dio.options.headers = {
      'Accept': '*/*',
      'Authorization': 'Bearer ${Config.token}',
    };

    return dio;
  }

  Res onResponse({
    required String method,
    required String path,
    required Response response,
    required void Function(bool) onIndicator,
    required void Function(Res) onBackend,
  }) {
    onIndicator(false);
    Res res = Res();
    log("${{
      'method': method,
      'path': path,
      'response.statusCode': response.statusCode,
      'data': response.data,
    }}");
    if (response.statusCode == 200) {
      Res res = Res(
        data: response.data['data'],
        message: response.data['message'],
        status: response.data['status'],
        success: response.data['success'],
      );
      onBackend(res);
      return res;
    }
    return res;
  }

  onError({
    required String method,
    required String path,
    required dynamic error,
    required void Function(bool) onIndicator,
    required void Function(Res) onBackend,
  }) {
    onIndicator(false);
    log("${{'method': method, 'path': path, 'error': error}}");

    bool? success = false;
    int? status = 500;
    dynamic data = [];
    String? message = '700 Internal Error';

    if (error.runtimeType == DioException) {
      DioException err = error as DioException;
      log("${{
        'type': err.type,
        'message': err.message,
        'response': err.response
      }}");
      if (err.type == DioExceptionType.badResponse) {
        dynamic response = err.response?.data;
        if (response != null) {
          success = response['success'];
          status = response['status'];
          message = response['message'];
          data = response['data'];
        } else {
          data = err.response?.data;
          status = err.response?.statusCode ?? 700;
          message = err.response?.statusMessage ?? err.message;
        }

        log("${{
          'response': response,
          'success': success,
          'status': status,
          'message': message,
          'data': data,
        }}");
        return Future.error(Res(
          success: success,
          status: status,
          message: message,
          data: data,
        ));
      } else {
        data = err.response?.data;
        status = err.response?.statusCode ?? 700;
        message = err.response?.statusMessage ?? err.message;
        log("${{
          'success': success,
          'status': status,
          'message': message,
          'data': data,
        }}");
        return Future.error(Res(
          success: success,
          status: status,
          message: message,
          data: data,
        ));
      }
    } else {
      message = error.toString();
      log("${{
        'success': success,
        'status': status,
        'message': message,
        'data': data,
      }}");
      return Future.error(Res(
        success: success,
        status: status,
        message: message,
        data: data,
      ));
    }
  }

  Future get(
    String path, {
    Map<String, dynamic> data = const {},
    Options? options,
    CancelToken? cancelToken,
    String method = 'GET',
    required void Function(bool) onIndicator,
    required void Function(Res) onBackend,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      onIndicator(true);
      Dio dio = await headers(method: method);
      log("${{'method': method, 'path': path, 'data': data}}");
      Response response = await dio.get(
        path,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return onResponse(
        method: method,
        path: path,
        response: response,
        onIndicator: onIndicator,
        onBackend: onBackend,
      );
    } catch (error) {
      return onError(
        method: method,
        path: path,
        error: error,
        onIndicator: onIndicator,
        onBackend: onBackend,
      );
    }
  }

  Future post(
    String path, {
    Map<String, dynamic> data = const {},
    Options? options,
    CancelToken? cancelToken,
    String method = 'POST',
    required void Function(bool) onIndicator,
    required void Function(Res) onBackend,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      onIndicator(true);
      Dio dio = await headers(method: method);

      log("${{'method': method, 'path': path, 'data': data}}");

      Response response = await dio.post(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return onResponse(
        method: method,
        path: path,
        response: response,
        onIndicator: onIndicator,
        onBackend: onBackend,
      );
    } catch (error) {
      return onError(
        method: method,
        path: path,
        error: error,
        onIndicator: onIndicator,
        onBackend: onBackend,
      );
    }
  }

  Future upload(
    String path, {
    Object? data,
    Options? options,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
    String method = 'POST',
    required void Function(bool) onIndicator,
    required void Function(Res) onBackend,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      onIndicator(true);

      Dio dio = await headers(
        method: method,
        contentType: 'multipart/form-data',
      );

      if (data.runtimeType == FormData) {
        FormData formData = data as FormData;
        log("${{
          'method': method,
          'path': path,
          'data': {
            'boundary': formData.boundary,
            'camelCaseContentDisposition': formData.camelCaseContentDisposition,
            'fields': formData.fields,
            'files': formData.files,
            'formData': formData.toString(),
          }
        }}");
      } else {
        log("${{'method': method, 'path': path, 'data': data}}");
      }

      Response response = await dio.post(
        path,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return onResponse(
        method: method,
        path: path,
        response: response,
        onIndicator: onIndicator,
        onBackend: onBackend,
      );
    } catch (error) {
      return onError(
        method: method,
        path: path,
        error: error,
        onIndicator: onIndicator,
        onBackend: onBackend,
      );
    }
  }

  Future futurePlans({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/future-plans',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return get(
      endpoint,
      data: {
        'old_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);
      return response;
    }, onError: (err) {
      onError(err);
      return Future.error(err);
    });
  }

  Future chengeRole({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/chenge-role',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {},
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (err) {
      onError(err);
      return Future.error(err);
    });
  }

  Future currentLocation({
    required String address,
    required String currentLat,
    required String currentLng,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/current-location',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'address': address,
        'current_lat': currentLat,
        'current_long': currentLng,
      },
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);
      return response;
    }, onError: (err) {
      onError(err);
      return Future.error(err);
    });
  }

  Future<Res?> login({
    required dynamic email,
    required dynamic password,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/user-login',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'email': email,
        'password': password,
      },
      onIndicator: onIndicator,
      onBackend: (response) async {
        Map map = {
          'token': response.data['token'],
          'role': response.data['role'],
          'password': password,
        };
        map.addAll(response.data['user']);
        await api.user.putAll(map);
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future<Res?> logout({
    Map<String, dynamic> arguments = const {},
    String endpoint = '/user-logout',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    onIndicator(false);
    return api.user.putAll({
      'currentUser': null,
      'email': null,
      'password': null,
    }).then((response) {
      onIndicator(false);
      onSuccess(Res());
      return Res();
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future<Res?> signup({
    required dynamic contact,
    required dynamic dob,
    required dynamic email,
    required dynamic firstName,
    required dynamic lastName,
    required dynamic password,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/user-signup',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'contact': contact,
        'dob': dob,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
      },
      onIndicator: onIndicator,
      onBackend: (response) async {
        Map map = {
          'token': response.data['token'],
          'role': response.data['role'],
          'password': password,
        };
        map.addAll(response.data['user']);
        await api.user.putAll(map);
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future resendOtp({
    required String email,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/resend-otp',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {'email': email},
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (err) {
      onError(err);
      return Future.error(err);
    });
  }

  Future sendForgotOtp({
    dynamic email,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/send-forgot-otp',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {'email': email},
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future confirmOtp({
    required String email,
    required String otp,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/confirm-otp',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {'email': email, 'otp': otp},
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future resetPassword({
    required dynamic email,
    required dynamic password,
    required dynamic passwordConfirmation,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/reset-password',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
      onIndicator: onIndicator,
      onBackend: (response) async {
        await api.user.putAll({'password': password});
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future registration({
    required dynamic arguments,
    required void Function(bool) indicator,
    required void Function(String, dynamic) navigator,
    required void Function(dynamic, bool) callback,
  }) async {
    indicator(true);
    dynamic image = containsKey(arguments, 'image');
    dynamic cnicFront = containsKey(arguments, 'cnicFront');
    dynamic cnicBack = containsKey(arguments, 'cnicBack');
    dynamic drivingLinence = containsKey(arguments, 'drivingLinence');
    if (image == null) {
      indicator(false);
      navigator(ProfilePhoto.route, arguments);
    } else if (cnicFront == null) {
      indicator(false);
      navigator(CnicFront.route, arguments);
    } else if (cnicBack == null) {
      indicator(false);
      navigator(CnicBack.route, arguments);
    } else if (drivingLinence == null) {
      indicator(false);
      navigator(DriverLicense.route, arguments);
    } else {
      indicator(false);
      callback(arguments, true);
    }
  }

  Future becomeDriverDetails({
    required dynamic userId,
    required dynamic cnicFront,
    required dynamic cnicBack,
    required dynamic image,
    required dynamic drivingLinence,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/become-driver-details',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    final data = FormData.fromMap({
      'user_id': userId,
      'cnic_front': cnicFront == null
          ? null
          : await MultipartFile.fromFile(
              cnicFront.path,
              filename: (cnicFront.path),
            ),
      'cnic_back': cnicBack == null
          ? null
          : await MultipartFile.fromFile(
              cnicBack.path,
              filename: (cnicBack.path),
            ),
      'image': image == null
          ? null
          : await MultipartFile.fromFile(
              image.path,
              filename: (image.path),
            ),
      'driving_linence': drivingLinence == null
          ? null
          : await MultipartFile.fromFile(
              drivingLinence.path,
              filename: (drivingLinence.path),
            ),
    });
    upload(
      endpoint,
      data: data,
      onIndicator: onIndicator,
      onBackend: (response) {
        api.user.putAll(response.data['user']).then((value) {});
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future driverVehicleDetails({
    required dynamic driverId,
    required dynamic carName,
    required dynamic model,
    required dynamic plateNumber,
    required dynamic insuranceCompany,
    required dynamic ploicyNumber,
    required dynamic registrationDate,
    required dynamic policyHolder,
    required dynamic bodyStyle,
    required File? vehicleImage,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/driver-vehicle-details',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    final data = FormData.fromMap({
      'driver_id': driverId,
      'car_name': carName,
      'model': model,
      'plate_number': plateNumber,
      'insurance_company': insuranceCompany,
      'ploicy_number': ploicyNumber,
      'registration_date': registrationDate,
      'policy_holder': policyHolder,
      'body_style': bodyStyle,
      'vehicle_image': vehicleImage == null
          ? null
          : await MultipartFile.fromFile(
              vehicleImage.path,
              filename: (vehicleImage.path),
            ),
    });
    upload(
      endpoint,
      data: data,
      onIndicator: onIndicator,
      onBackend: (response) {
        api.user.putAll(response.data['user']).then((value) {});
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future getUser({
    required dynamic userId,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/get-user',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return get(
      endpoint,
      data: {
        'user_id': userId,
      },
      onIndicator: onIndicator,
      onBackend: (response) async {
        await api.user.putAll(response.data);
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future profileUpdate({
    required dynamic id,
    required dynamic firstName,
    required dynamic lastName,
    required dynamic dob,
    required dynamic email,
    required dynamic contact,
    required dynamic username,
    required File? image,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/profile-update',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    try {
      final data = FormData.fromMap({
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'dob': dob,
        'email': email,
        'contact': contact,
        'username': username,
        'image': image == null
            ? null
            : await MultipartFile.fromFile(image.path, filename: (image.path)),
      });

      return upload(
        endpoint,
        data: data,
        onIndicator: onIndicator,
        onBackend: (response) async {
          await api.user.putAll(response.data['user']);
        },
      ).then((response) {
        onSuccess(response);
        toPrint(endpoint, response);

        return response;
      }, onError: (error) {
        onError(error);
        return error;
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future passwordUpdate({
    required dynamic oldPassword,
    required dynamic newPassword,
    required dynamic newPasswordConfirmation,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/password-update',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'old_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
      onIndicator: onIndicator,
      onBackend: (response) async {
        await api.user.putAll({'password': newPassword});
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (err) {
      onError(err);
      return Future.error(err);
    });
  }

  Future notificationList({
    Map<String, dynamic> arguments = const {},
    String endpoint = '/notification-list',
    required void Function(dynamic) onCache,
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    onCache(api.user.notificationList);
    return get(
      endpoint,
      data: {},
      onIndicator: onIndicator,
      onBackend: (response) {
        api.user.putAll(response.data).then((value) {});
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future chatUserList({
    Map<String, dynamic> arguments = const {},
    String endpoint = '/chat-user-list',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onCache,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    onCache(api.user.chatUserList);

    return get(
      endpoint,
      onIndicator: onIndicator,
      onBackend: (response) async {
        await api.chat.put('chat_user_list', response.data);
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future getUserChat({
    Map<String, dynamic> arguments = const {},
    String endpoint = '/get-user-chat',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onCache,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    onCache(api.user.getUserChat);

    return get(
      endpoint,
      onIndicator: onIndicator,
      onBackend: (response) async {
        await api.chat.put('get_user_chat', response.data);
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future postMessage({
    required dynamic receiverId,
    required dynamic message,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/post-message',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'receiver_id': receiverId,
        'message': message,
      },
      onIndicator: onIndicator,
      onBackend: (response) async {
        // api.chat.chats.add(arguments);
        // await api.chat.put('get-user-chat', api.chat.chats);
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  void broadcast(callback) {
    Stream stream =
        Stream.periodic(const Duration(seconds: 30), (int count) async {
      //  return await notification_list();
    });
    callback(stream);
  }

  Future searchRide({
    required dynamic leavingFrom,
    required dynamic goingTo,
    required dynamic leavingDate,
    required dynamic leavingTime,
    required dynamic requiredSeats,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/search-ride',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'leaving_from': leavingFrom,
        'going_to': goingTo,
        'leaving_date': leavingDate,
        'leaving_time': leavingTime,
        'required_seats': requiredSeats,
      },
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future packageDelivery({
    required dynamic pickupAddress,
    required dynamic pickupLat,
    required dynamic pickupLng,
    required dynamic pickupCity,
    required dynamic dropoffAddress,
    required dynamic dropoffLat,
    required dynamic dropoffLng,
    required dynamic dropoffCity,
    required dynamic cityLong,
    required dynamic scheduleDate,
    required dynamic scheduleTime,
    required dynamic packageSize,
    required dynamic quantity,
    required dynamic type,
    required dynamic receiverNamber,
    required dynamic isSignatures,
    required dynamic isTrackingNumber,
    required dynamic description,
    required dynamic receiverName,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/package-delivery',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'pickup_address': pickupAddress,
        'pickup_lat': pickupLat,
        'pickup_long': pickupLng,
        'pickup_city': pickupCity,
        'dropoff_address': dropoffAddress,
        'dropoff_lat': dropoffLat,
        'dropoff_long': dropoffLng,
        'dropoff_city': dropoffCity,
        'city_long': cityLong,
        'schedule_date': scheduleDate,
        'schedule_time': scheduleTime,
        'package_size': packageSize,
        'quantity': quantity,
        'type': type,
        'receiver_namber': receiverNamber,
        'is_signatures': isSignatures,
        'is_tracking_number': isTrackingNumber,
        'description': description,
        'receiver_name': receiverName,
      },
      onIndicator: onIndicator,
      onBackend: (response) async {
        dynamic key = response.data['package']['id'];
        dynamic value = response.data['package'];
        await api.package.put(key, value);
      },
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return error;
    });
  }

  Future driverPostRide({
    required dynamic pickupAddress,
    required dynamic pickupLat,
    required dynamic pickupLng,
    required dynamic pickupCity,
    required dynamic dropoffAddress,
    required dynamic dropoffLat,
    required dynamic dropoffLng,
    required dynamic dropoffCity,
    required dynamic route,
    required dynamic stops,
    required dynamic scheduleDate,
    required dynamic scheduleTime,
    required dynamic totalSeats,
    required dynamic isMiddleSeatEmpty,
    required dynamic takenNumberOfPassengers,
    required dynamic availableSeats,
    required dynamic allowInstantBooking,
    required dynamic perSeatCharges,
    required dynamic phoneNumber,
    required dynamic isPhoneNumberVerified,
    required dynamic isReturnTrip,
    required dynamic status,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/driver-post-ride',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'pickup_address': pickupAddress,
        'pickup_lat': pickupLat,
        'pickup_long': pickupLng,
        'pickup_city': pickupCity,
        'dropoff_address': dropoffAddress,
        'dropoff_lat': dropoffLat,
        'dropoff_long': dropoffLng,
        'dropoff_city': dropoffCity,
        'route': route,
        'stops': stops,
        'schedule_date': scheduleDate,
        'schedule_time': scheduleTime,
        'total_seats': totalSeats,
        'is_middle_seat_empty': isMiddleSeatEmpty,
        'taken_number_of_passengers': takenNumberOfPassengers,
        'available_seats': availableSeats,
        'allow_instant_booking': allowInstantBooking,
        'per_seat_charges': perSeatCharges,
        'phone_number': phoneNumber,
        'is_phone_number_verified': isPhoneNumberVerified,
        'is_return_trip': isReturnTrip,
        'status': status,
      },
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future rideStopdetails({
    dynamic rideId,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/ride-stop-details',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {'ride_id': rideId},
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);
      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future bookride({
    dynamic driverId,
    dynamic rideId,
    dynamic stopId,
    dynamic requiredSeats,
    dynamic totalAmount,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/book-ride',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'driver_id': driverId,
        'ride_id': rideId,
        'stop_id': stopId,
        'required_seats': requiredSeats,
        'total_amount': totalAmount,
      },
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);
      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future stripePayment({
    required dynamic cardNumber,
    required dynamic expMonth,
    required dynamic expYear,
    required dynamic cvc,
    required dynamic cardHolderName,
    required dynamic totalMount,
    required dynamic bookingId,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/stripe-payment',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'card_number': cardNumber,
        'cvc': cvc,
        'exp_month': expMonth,
        'exp_year': expYear,
        'card_holder_name': cardHolderName,
        'total_mount': totalMount,
        'booking_id': bookingId,
      },
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future cashPayment({
    required dynamic totalMount,
    required dynamic bookingId,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/cash-payment',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'total_mount': totalMount,
        'booking_id': bookingId,
      },
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }

  Future verifyCashPayment({
    required dynamic paymentId,
    Map<String, dynamic> arguments = const {},
    String endpoint = '/verify-cash-payment',
    required void Function(dynamic) onSuccess,
    required void Function(dynamic) onError,
    required void Function(bool) onIndicator,
  }) async {
    return post(
      endpoint,
      data: {
        'payment_id': paymentId,
      },
      onIndicator: onIndicator,
      onBackend: (response) {},
    ).then((response) {
      onSuccess(response);
      toPrint(endpoint, response);

      return response;
    }, onError: (error) {
      onError(error);
      return Future.error(error);
    });
  }
}
