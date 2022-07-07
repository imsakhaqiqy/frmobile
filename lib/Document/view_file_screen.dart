import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  String judul = "";
  PDFScreen(this.pathPDF, this.judul);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFViewerScaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            toolbarHeight: 100,
            title: Text(
              this.judul,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[],
          ),
          path: pathPDF),
    );
  }
}
