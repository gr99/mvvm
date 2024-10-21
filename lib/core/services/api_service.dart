import 'package:dio/dio.dart';

class ApiService {
  // Private constructor
  ApiService._internal() {
    init(); // Initialize Dio here
  }

  // The singleton instance
  static final ApiService _instance = ApiService._internal();

  // Public factory constructor
  factory ApiService() => _instance;

  // Dio instance
  late Dio dio;

  // Initialization
  void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://picsum.photos',
      ),
    );

    // Add interceptors if necessary
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add any request modifications here
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle response
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          // Handle errors
          return handler.next(e);
        },
      ),
    );
  }
}
