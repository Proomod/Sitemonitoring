import 'dart:async';

import 'package:site_monitoring/cementTests/cementsetting/pdfpage/pdfcontent.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class CementSettingPdfViewer extends StatefulWidget {
//   @override
//   _CementSettingPdfViewerState createState() => _CementSettingPdfViewerState();
// }

// class _CementSettingPdfViewerState extends State<CementSettingPdfViewer> {
//   File file;

//   PDFDocument document;

//   bool _isLoading = false;

//   loadPdf() async {
//     _isLoading = true;
//     file = await pdfContent();

//     this.document = await PDFDocument.fromFile(file);
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     loadPdf();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: Text('CementSetting'),
//       ),
//       body: Center(
//           child: _isLoading
//               ? Center(
//                   child: CircularProgressIndicator(
//                   backgroundColor: Colors.red,
//                 ))
//               : PDFViewer(document: this.document)),
//     );
//   }
// }

class CementSetting extends StatefulWidget {
  @override
  _CementSettingState createState() => _CementSettingState();
}

class _CementSettingState extends State<CementSetting> {
  String pathPDF = '';
  @override
  void initState() {
    getPath();
    super.initState();
  }

  getPath() async {
    pathPDF = await cementSettingReport();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('CementSettingTest')),
        body: Center(child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                RaisedButton(
                    child: Text("Open PDF"),
                    onPressed: () {
                      if (pathPDF != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFScreen(path: pathPDF)),
                        );
                      }
                    }),
              ],
            );
          },
        )),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String path;
  PDFScreen({Key? key, required this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  // int pages = 0;
  // bool isReady = false;
  // String errorMessage = '';
  // GlobalKey pdfKey = GlobalKey();
  // bool isActive = true;
  // double scale = 1.0;
  // double top = 200.0;
  // double initialLocalFocalPoint;
  // @override
  // Widget build(BuildContext context) {
  //   return OrientationBuilder(
  //       builder: (BuildContext context, Orientation orientation) {
  //     if (orientation == Orientation.portrait) {
  //       final Completer<PDFViewController> _controller =
  //           Completer<PDFViewController>();
  //       return Scaffold(
  //         appBar: AppBar(
  //           title: Text("Document"),
  //           actions: <Widget>[
  //             IconButton(
  //               icon: Icon(Icons.share),
  //               onPressed: () {},
  //             ),
  //           ],
  //         ),
  //         body: Stack(
  //           children: <Widget>[
  //             Container(
  //               color: Colors.black,
  //               child: PDFView(
  //                   key: pdfKey,
  //                   filePath: widget.path,
  //                   fitEachPage: true,
  //                   fitPolicy: FitPolicy.BOTH,
  //                   dualPageMode: false,
  //                   enableSwipe: true,
  //                   swipeHorizontal: true,
  //                   autoSpacing: true,
  //                   pageFling: true,
  //                   defaultPage: 8,
  //                   pageSnap: true,
  //                   backgroundColor: bgcolors.BLACK,
  //                   onRender: (_pages) {
  //                     print("OK RENDERED!!!!!");
  //                     setState(() {
  //                       pages = _pages;
  //                       isReady = true;
  //                     });
  //                   },
  //                   onError: (error) {
  //                     setState(() {
  //                       errorMessage = error.toString();
  //                     });
  //                     print(error.toString());
  //                   },
  //                   onPageError: (page, error) {
  //                     setState(() {
  //                       errorMessage = '$page: ${error.toString()}';
  //                     });
  //                     print('$page: ${error.toString()}');
  //                   },
  //                   onViewCreated: (PDFViewController pdfViewController) {
  //                     _controller.complete(pdfViewController);
  //                   },
  //                   onPageChanged: (int page, int total) {
  //                     print('page change: $page/$total');
  //                   },
  //                   onZoomChanged: (double zoom) {
  //                     print("Zoom is now $zoom");
  //                   }),
  //             ),
  //             errorMessage.isEmpty
  //                 ? !isReady
  //                     ? Center(
  //                         child: CircularProgressIndicator(),
  //                       )
  //                     : Container()
  //                 : Center(child: Text(errorMessage))
  //           ],
  //         ),
  //         floatingActionButton: FutureBuilder<PDFViewController>(
  //           future: _controller.future,
  //           builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
  //             if (snapshot.hasData) {
  //               return FloatingActionButton.extended(
  //                 label: Text("Go to ${pages ~/ 2}"),
  //                 onPressed: () async {
  //                   print(await snapshot.data.getZoom());
  //                   print(await snapshot.data.getPageWidth(1));
  //                   print(await snapshot.data.getPageHeight(1));
  //                   //await snapshot.data.setPage(pages ~/ 2);
  //                   await snapshot.data.resetZoom(1);
  //                   await snapshot.data.setZoom(3.0);
  //                   //print(await snapshot.data.getScreenWidth());
  //                 },
  //               );
  //             }

  //             return Container();
  //           },
  //         ),
  //       );
  //     } else {
  //       final Completer<PDFViewController> _controller =
  //           Completer<PDFViewController>();
  //       return PDFView(
  //         filePath: widget.path,
  //         fitEachPage: false,
  //         dualPageMode: true,
  //         displayAsBook: true,
  //         dualPageWithBreak: true,
  //         enableSwipe: true,
  //         swipeHorizontal: true,
  //         autoSpacing: false,
  //         pageFling: true,
  //         defaultPage: 0,
  //         pageSnap: true,
  //         backgroundColor: bgcolors.BLACK,
  //         onRender: (_pages) {
  //           print("OK RENDERED!!!!!");
  //           setState(() {
  //             pages = _pages;
  //             isReady = true;
  //           });
  //         },
  //         onError: (error) {
  //           setState(() {
  //             errorMessage = error.toString();
  //           });
  //           print(error.toString());
  //         },
  //         onPageError: (page, error) {
  //           setState(() {
  //             errorMessage = '$page: ${error.toString()}';
  //           });
  //           print('$page: ${error.toString()}');
  //         },
  //         onViewCreated: (PDFViewController pdfViewController) {
  //           _controller.complete(pdfViewController);
  //         },
  //         onPageChanged: (int page, int total) {
  //           print('page change: $page/$total');
  //         },
  //       );
  //     }
  //   });
  // }

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(widget.path),
      key: _pdfViewerKey,
    );
  }
}
