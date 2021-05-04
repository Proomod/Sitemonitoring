import 'package:site_monitoring/cementTests/consistencyTest/pdfPage/pdfcontent.dart';
import 'package:site_monitoring/cementTests/finenessTest/pdfPage/pdfContent.dart';
import 'package:site_monitoring/components/pdfScreen.dart';
import 'package:flutter/material.dart';

class CementFiness extends StatefulWidget {
  @override
  _CementFinessState createState() => _CementFinessState();
}

class _CementFinessState extends State<CementFiness> {
  String pathPDF = '';

  @override
  void initState() {
    getPath();
    super.initState();
  }

  getPath() async {
    pathPDF = await cementFinenessReport();
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
