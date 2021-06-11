import 'package:site_monitoring/cementTests/cementsetting/pdfpage/pdf_viewer.dart';
import 'package:site_monitoring/cementTests/consistencyTest/pdfPage/pdfcontent.dart';
import 'package:flutter/material.dart';
import 'package:site_monitoring/coarseAggregateTest/components/pdfScreen.dart';

class CementConsistency extends StatefulWidget {
  @override
  _CementConsistencyState createState() => _CementConsistencyState();
}

class _CementConsistencyState extends State<CementConsistency> {
  String pathPDF = '';

  @override
  void initState() {
    getPath();
    super.initState();
  }

  getPath() async {
    pathPDF = await cementConsistencyReport();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('CementConsistencyTest')),
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
