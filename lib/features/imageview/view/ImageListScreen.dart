import 'package:flutter/material.dart';
import 'package:my_test_project/features/imageview/view_model/image_view_model.dart';

class ImageListScreen extends StatefulWidget {
  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  final ImageViewModel _viewModel = ImageViewModel();

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    await _viewModel.fetchImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: _viewModel.images.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _viewModel.images.length,
        itemBuilder: (context, index) {
          final image = _viewModel.images[index];
          return Card(
            child: Column(
              children: [
                Image.network(image.downloadUrl,width: 100,height: 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Author: ${image.author}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}