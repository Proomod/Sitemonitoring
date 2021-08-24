import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'pdfContent.dart';

class ACVTestPdf extends StatefulWidget {
  ACVTestPdf({Key? key}) : super(key: key);

  @override
  _ACVTestPdfState createState() => _ACVTestPdfState();
}

class _ACVTestPdfState extends State<ACVTestPdf> {
  File? file;
  @override
  void initState() {
    super.initState();
    getFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("This is the landing page to open pdf")),
        body: Center(
          child: TextButton(
            child: Text("Open Pdf"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PDFViewer(file: file!)));
            },
          ),
        ));
  }

  Future<void> getFile() async {
    file = await pdfContent();
  }
}

class PDFViewer extends StatefulWidget {
  const PDFViewer({required this.file, Key? key}) : super(key: key);

  final File file;

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("FI test pdf"), actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          )
        ]),
        body: SfPdfViewer.file(widget.file, key: _pdfViewerKey));
  }
}
