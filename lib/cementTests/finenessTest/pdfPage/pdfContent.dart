import 'package:flutter/material.dart' as mt;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:async';
import 'dart:io';

Future<String> cementFinenessReport() async {
  final doc = Document();
  doc.addPage(
    MultiPage(build: (Context context) {
      return [
        Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
                vertical: BorderSide(style: BorderStyle.solid)),
          ),
          child: Column(
            children: [
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
                  border: TableBorder(
                    verticalInside: BorderSide(style: BorderStyle.solid),
                    top: BorderSide(style: BorderStyle.solid),
                    left: BorderSide(style: BorderStyle.solid),
                    right: BorderSide(style: BorderStyle.solid),
                  ),
                  children: [
                    TableRow(children: [
                      Header(
                        child: Center(
                          child: Text(
                            'Fineness of Cement'.toUpperCase(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Center(
                          child: Text(
                        "As per IS:4031",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
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
                          1: FixedColumnWidth(114),
                          2: FixedColumnWidth(20),
                          3: FixedColumnWidth(20),
                          4: FixedColumnWidth(20),
                          5: FixedColumnWidth(20),
                          6: FixedColumnWidth(20),
                        },
                        headerCount: 0,
                        data: [
                          ["A", "Wt. of cement", "", "", "", "", "gms"],
                          ["B", "Wt. of residue Sample", "", "", "", "", "gms"],
                          ["C1", "% of residue", "", "", "", "", "%"],
                          ["C2", "Fineness(%)", "", "", "", "", "%"],
                        ]),
                  ),
                  Center(
                    child: Table.fromTextArray(
                      border: TableBorder(),
                      // tableWidth: TableWidth.min,
                      context: context,

                      headerCount: 0,
                      cellAlignments: {
                        5: Alignment.center,
                      },
                      cellStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      data: [
                        ["Average Value", "", "", "", "", "%"],
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Table.fromTextArray(
                      tableWidth: TableWidth.values[1],
                      border: TableBorder.symmetric(
                          inside: BorderSide(style: BorderStyle(paint: true)),
                          outside: BorderSide(style: BorderStyle(paint: true))),
                      // tableWidth: TableWidth.min,
                      context: context,

                      headerCount: 0,
                      cellStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      data: [
                        ["FINENESS OF  CEMENT =", "", "%"],
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                children: [
                  Table.fromTextArray(
                      context: context,
                      cellPadding:
                          const EdgeInsets.only(bottom: 20, top: 3, left: 4),
                      headerCount: 0,
                      columnWidths: {
                        0: FixedColumnWidth(50),
                        1: FlexColumnWidth(1),
                      },
                      data: [
                        ["Remarks:", ""],
                      ]),
                  Table.fromTextArray(columnWidths: {
                    0: FixedColumnWidth(217),
                    1: FlexColumnWidth(1),
                    2: FixedColumnWidth(0)
                  }, data: [
                    ["Contractor", "Client"],
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Table.fromTextArray(
                          tableWidth: TableWidth.max,
                          headerHeight: 40.0,
                          data: [
                            ["", ""],
                            ["Tested By", "Checked By"],
                            ['Lab technician', "Senior Lab Technician"]
                          ],
                        ),
                        Table.fromTextArray(
                          border: TableBorder(),
                          headerHeight: 40.0,
                          tableWidth: TableWidth.max,
                          defaultColumnWidth: FixedColumnWidth(132),
                          data: [
                            ["", ""],
                            ["Recommended By", "Approved By"],
                            ['Site Engineer', ""]
                          ],
                        ),
                      ])
                ],
              )
            ],
          ),
        )
      ];
    }),
  );
  final String appDocDirPath = (await getApplicationDocumentsDirectory()).path;
  final String path = '$appDocDirPath/cementFinenessReport.pdf';
  final file = File(path);
  file.writeAsBytes(await doc.save());

  return path;
}
