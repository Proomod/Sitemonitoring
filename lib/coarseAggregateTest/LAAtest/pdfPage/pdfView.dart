import 'package:site_monitoring/coarseAggregateTest/LAAtest/pdfPage/pdfContent.dart';
import 'package:site_monitoring/components/pdfScreen.dart';
import 'package:flutter/material.dart';

class CoarseLAAtest extends StatefulWidget {
  @override
  _CoarseLAAtestState createState() => _CoarseLAAtestState();
}

class _CoarseLAAtestState extends State<CoarseLAAtest> {
  String pathPDF = '';

  @override
  void initState() {
    getPath();
    super.initState();
  }

  getPath() async {
    pathPDF = await coarseLAAtestReport();
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
