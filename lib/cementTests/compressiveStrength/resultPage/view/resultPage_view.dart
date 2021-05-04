import 'dart:convert';

import 'package:site_monitoring/cementTests/compressiveStrength/reportDataEntry/view/reportdata_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class CompressiveStrengthResult extends StatefulWidget {
  @override
  _CompressiveStrengthResultState createState() =>
      _CompressiveStrengthResultState();
}

class _CompressiveStrengthResultState extends State<CompressiveStrengthResult> {
  _resultDataProcess() async {
    FlutterSecureStorage storage = FlutterSecureStorage();

    try {
      String token = await storage.read(key: 'AuthKey');
      var res = await http.get(
          'https://dammiapi.herokuapp.com/api/tests/cementResultComp/10/',
          headers: {"Authorization": 'Token $token'});
      return jsonDecode(res.body);
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    _resultDataProcess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: Center(
          child: FutureBuilder(
            future: _resultDataProcess(),
            builder: (context, AsyncSnapshot snapshot) {
              List<Widget> children = [];
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  children = [
                    DataTable(
                        dataTextStyle: TextStyle(
                          wordSpacing: 20.0,
                        ),
                        horizontalMargin: 3.0,
                        showBottomBorder: true,
                        dividerThickness: 1,
                        columnSpacing: 20.0,
                        columns: [
                          DataColumn(label: Text('Test Day')),
                          DataColumn(label: Text('Cube No')),
                          DataColumn(
                              label: Column(
                            children: [
                              Text('Strength, (M/A)x1000'),
                              Text('N/mm2'),
                            ],
                          )),
                          DataColumn(
                            label: Column(
                              children: [
                                Text('Average strength'),
                                Text('N/mm2'),
                              ],
                            ),
                          )
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Center(child: Text('3'))),
                            DataCell(Center(child: Text('1'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot?.data['strength_1']?.toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text('')),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text('3'))),
                            DataCell(Center(child: Text('2'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot.data['strength_2']?.toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text(
                                '${snapshot.data['avg_strength_1'].toStringAsFixed(2)}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text('3'))),
                            DataCell(Center(child: Text('3'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot.data['strength_3'].toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text('')),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text('7'))),
                            DataCell(Center(child: Text('4'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot.data['strength_4'].toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text('')),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text('7'))),
                            DataCell(Center(child: Text('5'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot.data['strength_5'].toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text(
                                '${snapshot.data['avg_strength_2'].toStringAsFixed(2)}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text('7'))),
                            DataCell(Center(child: Text('6'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot.data['strength_6'].toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text('')),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text('27'))),
                            DataCell(Center(child: Text('7'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot.data['strength_7'].toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text('')),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text('27'))),
                            DataCell(Center(child: Text('8'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot.data['strength_8'].toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text(
                                '${snapshot.data['avg_strength_3'].toStringAsFixed(2)}')),
                          ]),
                          DataRow(cells: [
                            DataCell(Center(child: Text('27'))),
                            DataCell(Center(child: Text('9'))),
                            DataCell(
                              Center(
                                child: Text(
                                    '${snapshot.data['strength_9'].toStringAsFixed(2)}'),
                              ),
                            ),
                            DataCell(Text('')),
                          ])
                        ]),
                    FlatButton(
                      color: Colors.blueAccent,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return ReportDataEntry();
                        },
                      ),
                      child: Text("Generate report"),
                    )
                  ];
                }
              } else {
                children = [
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ];
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children,
              );
            },
          ),
        ));
  }
}
