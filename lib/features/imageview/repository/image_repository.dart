import 'package:dio/dio.dart';
import 'package:my_test_project/core/services/api_service.dart';
import 'package:my_test_project/features/imageview/model/image_model.dart';

class ImageRepository {
  final Dio _dio = ApiService().dio;

  Future<List<ImageModel>> fetchImages() async {
    try {
      final response = await _dio.get('/v2/lists');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((image) => ImageModel.fromJson(image))
            .toList();
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error fetching images: $e');
      throw e; // Re-throw the exception for the ViewModel to handle
    }
  }
}
