import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'pdfContent.dart';

class SieveAnalysisTestPdf extends StatefulWidget {
  SieveAnalysisTestPdf({Key? key}) : super(key: key);

  @override
  _SieveAnalysisTestPdfState createState() => _SieveAnalysisTestPdfState();
}

class _SieveAnalysisTestPdfState extends State<SieveAnalysisTestPdf> {
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
        appBar: AppBar(title: Text("Fine unit test pdf"), actions: [
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
