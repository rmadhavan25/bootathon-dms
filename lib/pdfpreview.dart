import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart' as p;


class PDFView extends StatefulWidget {
  @override
  _PDFViewState createState() => _PDFViewState(path);
  String path;
  PDFView(this.path);

}

class _PDFViewState extends State<PDFView> {
  String path;
  _PDFViewState(this.path);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: p.PDFView(
          filePath: path,
      ),
    );
  }
}
