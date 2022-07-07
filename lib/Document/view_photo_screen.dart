import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class ImageApp extends StatefulWidget {
  @override
  _ImageApp createState() => _ImageApp();

  String path;
  String title;

  ImageApp(this.path, this.title);
}

class _ImageApp extends State<ImageApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: Image.network(
            'https://www.nabasa.co.id/field_recruitment/' + widget.path),
      ),
    );
  }
}
