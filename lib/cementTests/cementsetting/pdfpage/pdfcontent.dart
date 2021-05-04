import 'dart:async';
import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mt;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

Future<String> cementSettingReport() async {
  final doc = Document();

  doc.addPage(
    MultiPage(
      build: (Context context) => [
        // Center(
        //   child: Text('Hello World  baby motherfackewre!'),
        // ),
        Container(
            decoration: BoxDecoration(border: Border.all()),
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
              Table(border: TableBorder.all(width: 2.0), children: [
                TableRow(
                  children: [
                    Center(
                        child: Header(
                      child: Center(
                          child: Text(
                        "Setting time of cement".toUpperCase(),
                        textAlign: TextAlign.center,
                      )),
                    )),
                  ],
                ),
                TableRow(children: [
                  Center(
                    child: Text(
                      "As per IS:4031",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
              ]),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // alignment: Alignment.centerRight,
                children: [
                  Table.fromTextArray(
                    tableWidth: TableWidth.min,
                    defaultColumnWidth: FixedColumnWidth(90),
                    context: context,
                    // defaultColumnWidth: FlexColumnWidth(1.0),
                    headerCount: 0,
                    data: [
                      ["Lab Ref No.", ""],
                      ["Sample Location", ""],
                      ["Cement Brand/Source", ""]
                    ],
                  ),
                  Table.fromTextArray(
                    defaultColumnWidth: FixedColumnWidth(90),
                    headerCount: 0,
                    // defaultColumnWidth: FlexColumnWidth(1.0),
                    tableWidth: TableWidth.min,
                    context: context,
                    data: [
                      ["Date of Sampling", ""],
                      ["Date of Testing", ""],
                      ['Sample By:', ""]
                    ],
                  )
                ],
              ),
              Column(children: [
                SizedBox(height: 30),
                Center(
                  child: Table.fromTextArray(
                    tableWidth: TableWidth.min,
                    headerCount: 6,
                    data: [
                      ["Normal Consistency (%)", "    ", "hrs   ", "Minutes"],
                      ["Time When Water is added to cement(t1)", "", "", ""],
                      ["Time at initial setting(t2)", "", "", ""],
                      [
                        "Total Time taken for Intial setting=(t2-t1)",
                        "",
                        "",
                        ""
                      ],
                      ['Time at Final setting (t3)', "", ""],
                      [
                        "Total Time taken for final setting =(t3-t1)",
                        "",
                        "",
                        ""
                      ]
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Table.fromTextArray(
                    border: TableBorder.all(width: 0.0),
                    tableWidth: TableWidth.min,
                    context: context,
                    headerCount: 0,
                    cellStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    data: [
                      ["INTIAL SETTING TIME OF  CEMENT =			", "", "Minutes"],
                      [""],
                      ["FINAL SETTING TIME OF CEMENT =			", "", "Minutes"]
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ]),
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
                      cellHeight: 100.0,
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
            ]))
      ],
    ),
  );
  // Completer<File> completer = Completer();
  final String appDocDirPath = (await getApplicationDocumentsDirectory()).path;
  final String path = '$appDocDirPath/cementSettingReport.pdf';
  final file = File(path);
  file.writeAsBytes(await doc.save());

  return path;
}
