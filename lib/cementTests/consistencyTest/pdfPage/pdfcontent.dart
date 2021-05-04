import 'dart:async';
import 'dart:io';

// import 'package:flutter/material.dart';

import 'package:flutter/material.dart' as mt;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

Future<String> cementConsistencyReport() async {
  final doc = Document();
  doc.addPage(MultiPage(
    build: (Context context) {
      return [
        Container(
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(style: BorderStyle.solid),
            right: BorderSide(style: BorderStyle.solid),
          )),
          child: Column(children: [
            Header(
              level: 3,
              margin: EdgeInsets.only(top: 0.0),
              child: Column(
                children: [
                  Table.fromTextArray(
                      context: context,
                      cellAlignment: Alignment.center,
                      headerCount: 0,
                      cellStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      data: [
                        ['Lab Name'],
                        ["Project Name"],
                        ['Contract No.'],
                      ]),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Table.fromTextArray(
                          context: context,
                          tableWidth: TableWidth.min,
                          headerCount: 0,
                          cellAlignment: Alignment.topLeft,
                          data: [
                            ["Consultant"],
                            ["Contractor"],
                          ])),
                ],
              ),
            ),
            Table(
                border: TableBorder.all(
                  color: PdfColors.black,
                ),
                children: [
                  TableRow(children: [
                    Header(
                      child: Center(
                        child:
                            Text('Normal Consistency of Cement'.toUpperCase()),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text("As per IS:4031",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
                ]),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Table.fromTextArray(
                    tableWidth: TableWidth.max,
                    defaultColumnWidth:
                        FixedColumnWidth(PdfPageFormat.a4.width / 4 - 30),
                    context: context,
                    headerCount: 0,
                    data: [
                      ["Lab Ref No.", ""],
                      ["Sample Location", ""],
                      ["Cement Brand/Source", ""]
                    ],
                  ),
                  Table.fromTextArray(
                    // defaultColumnWidth: FlexColumnWidth(1),
                    headerCount: 0,
                    defaultColumnWidth:
                        FixedColumnWidth(PdfPageFormat.a4.width / 4 - 30),
                    tableWidth: TableWidth.max,
                    context: context,
                    data: [
                      ["Date of Sampling", ""],
                      ["Date of Testing", ""],
                      ['Sample By:', ""]
                    ],
                  ),
                ]),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Table.fromTextArray(
                    cellStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    // tableWidth: TableWidth.min,
                    context: context,
                    columnWidths: {
                      1: FixedColumnWidth(20),
                      2: FixedColumnWidth(20),
                      3: FixedColumnWidth(20),
                      4: FixedColumnWidth(20),
                      5: FixedColumnWidth(20),
                    },
                    headerCount: 0,
                    data: [
                      ["Determination Number", "1", "2", "3", "4", ""],
                      ["Percentage of water Added", "", "", "", "", "gms"]
                    ],
                  ),
                ),
                Center(
                  child: Table.fromTextArray(
                    cellStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    context: context,
                    columnWidths: {
                      1: FixedColumnWidth(139),
                      2: FixedColumnWidth(20),
                      3: FixedColumnWidth(20),
                      4: FixedColumnWidth(20),
                      5: FixedColumnWidth(20),
                      6: FixedColumnWidth(20),
                    },
                    headerCount: 0,
                    data: [
                      ["A", "Wt. of cement", "", "", "", "", "gms"],
                      ["B", "Wt. of water Added", "", "", "", "", "gms"],
                      [
                        "C1",
                        "Initial reading of indicator",
                        "",
                        "",
                        "",
                        "",
                        "mm"
                      ],
                      [
                        "C2",
                        "Final reading of indicator",
                        "",
                        "",
                        "",
                        "",
                        "mm"
                      ],
                      [
                        "C",
                        "Penetration of plunger(C1-C2)",
                        "",
                        "",
                        "",
                        "",
                        "mm"
                      ],
                      ["", "Average value".toUpperCase(), "mm"]
                    ],
                  ),
                ),
                Center(
                  child: Table.fromTextArray(
                    border: TableBorder(),
                    // tableWidth: TableWidth.min,
                    context: context,

                    headerCount: 0,
                    cellStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    data: [
                      ["NORMAL CONSISTENCY OF  CEMENT =", "31.00", ""],
                      [""],
                      ["WATER/CEMENT RATIO(B/A) =			", "", ""]
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Table(border: TableBorder.all(), columnWidths: {
              0: FlexColumnWidth(1.0),
              1: FlexColumnWidth(2.0),
            }, children: [
              TableRow(children: [
                Table.fromTextArray(
                  context: context,
                  headerStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  data: [
                    ['Contractor', "Client"],
                  ],
                )
              ]),
              TableRow(
                children: [
                  Table.fromTextArray(
                    columnWidths: {
                      0: FlexColumnWidth(0.8),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1.5),
                    },
                    context: context,
                    cellHeight: 30.0,
                    data: [
                      ["", "", "", ""]
                    ],
                  )
                ],
              ),
              TableRow(
                children: [
                  Table.fromTextArray(
                    headerStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    context: context,
                    headerCount: 1,
                    data: [
                      [
                        "Tested By ",
                        "Checked By",
                        "Recommended By",
                        "Approved By"
                      ],
                      [
                        "lab technician",
                        "Senior Lab technician",
                        "Site Engineer",
                        ""
                      ]
                    ],
                  )
                ],
              ),
            ]),
          ]),
        ),
      ];
    },
  ));
  final String appDocDirPath = (await getApplicationDocumentsDirectory()).path;
  final String path = '$appDocDirPath/cementSettingReport.pdf';
  final file = File(path);
  file.writeAsBytes(await doc.save());

  return path;
}
