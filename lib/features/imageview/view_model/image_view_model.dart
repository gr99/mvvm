// view_model/image_view_model.dart

import 'package:dio/dio.dart';
import 'package:my_test_project/features/imageview/model/image_model.dart';
import 'package:my_test_project/features/imageview/repository/image_repository.dart';

class ImageViewModel {
  final ImageRepository _imageRepository = ImageRepository();
  List<ImageModel> images = [];

  Future<void> fetchImages() async {
    try {
      images=await _imageRepository.fetchImages();
    } catch (e) {
      print('Failed to load images: $e');
      throw(e);
    }
  }
}
