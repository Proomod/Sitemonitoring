import 'package:site_monitoring/coarseAggregateTest/components/pdfScreen.dart';
import 'package:site_monitoring/coarseAggregateTest/sieveAnalysisSIngleSized/pdfPage/pdfContent.dart';
import 'package:flutter/material.dart';

class SieveAnalysisSigleSize extends StatefulWidget {
  @override
  _SieveAnalysisSigleSizeState createState() => _SieveAnalysisSigleSizeState();
}

class _SieveAnalysisSigleSizeState extends State<SieveAnalysisSigleSize> {
  String pathPDF = '';

  @override
  void initState() {
    getPath();
    super.initState();
  }

  getPath() async {
    pathPDF = await sieveAnalysisSingeSizedReport();
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
                ElevatedButton(
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
