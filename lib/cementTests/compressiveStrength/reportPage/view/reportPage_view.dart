import 'dart:convert';
import 'dart:io';

import 'package:site_monitoring/cementTests/compressiveStrength/pdfPage/pdf_content.dart';
import 'package:site_monitoring/cementTests/compressiveStrength/pdfPage/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ReportCement extends StatefulWidget {
  @override
  _ReportCementState createState() => _ReportCementState();
}

class _ReportCementState extends State<ReportCement> {
  File? file;

  @override
  void initState() {
    super.initState();
  }

  getfileName(reportData, extraData) async {
    file = await pdfContent(reportData, extraData);
  }

  Future<String?> token = Future<String?>.microtask(
      () => FlutterSecureStorage().read(key: 'AuthKey'));
  Future<http.Response> _testdata = Future<http.Response>.microtask(() =>
      http.get(
          Uri.parse(
              'https://dammiapi.herokuapp.com/api/tests/cementReportComp/10'),
          headers: {
            "Authorization":
                "Token someting goes here which is not completed yet",
          }));
  @override
  Widget build(BuildContext context) {
    var extraData = ModalRoute.of(context)!.settings.arguments;
    print(extraData);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder(
          future: _testdata,
          builder: (context, AsyncSnapshot<http.Response> snapshot) {
            List<Widget> children = [];
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                getfileName(jsonDecode(snapshot.data!.body), extraData);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PdfViewer(path: filePath),
                //   ),
                // );

                children = [
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewer(pdfFile: file),
                        ),
                      );
                    },
                    color: Colors.black,
                    child: Text('push'),
                  ),
                  // Text('${snapshot.data.body}')
                ];
              } else if (snapshot.hasError) {
                children = [
                  Text('${snapshot.error}'),
                ];
              }
            } else {
              children = [CircularProgressIndicator()];
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            );
          },
        ),
      ),
    );
  }
}
