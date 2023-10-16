import 'package:dio/dio.dart';

import 'interceptor/logging.dart';

class DioRepo {
  late final Dio dio;
  int retryCount = 0;

  final host = "https://dummyjson.com/";

  Dio baseConfig() {
    Dio dio = Dio();
    dio.options.baseUrl = host;
    dio.options.connectTimeout = const Duration(milliseconds: 15000);
    dio.options.receiveTimeout = const Duration(milliseconds: 15000);

    return dio;
  }

  DioRepo() {
    dio = baseConfig();
    dio.interceptors.addAll([
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          // ignore: todo
          //TODO: get token value

          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            if (retryCount < 3) {
              return;
            }

            return handler.next(e);
          }

          return handler.next(e);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
      ),
      LoggingInterceptors()
    ]);
  }
}
