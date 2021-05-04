import 'package:flutter/material.dart' as mt;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:async';
import 'dart:io';

Future<String> sieveAnalysisSingeSizedReport() async {
  final doc = Document();
  doc.addPage(
    MultiPage(
        pageTheme: PageTheme(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 60),
            theme: ThemeData(
              defaultTextStyle: TextStyle(fontSize: 9.3),
            )),
        build: (Context context) {
          return [
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(style: BorderStyle.solid),
                ),
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
                                'SIEVE ANALYSIS'.toUpperCase(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Center(
                              child: Text(
                            "As per IS:2386",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                        ]),
                      ]),
                  Table.fromTextArray(
                    headerCount: 0,
                    context: context,
                    data: [
                      ["Description of materials:", ""]
                    ],
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table.fromTextArray(
                          tableWidth: TableWidth.max,
                          defaultColumnWidth:
                              FixedColumnWidth(PdfPageFormat.a4.width / 4 - 30),
                          context: context,
                          headerCount: 0,
                          data: [
                            ["Lab Ref No.", ""],
                            ["Source:", ""],
                            ["Date of Test:", ""],
                            ["Total wt.of sample (gm):"]
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
                            ["Sample Loaction", ""],
                            ['Sampled By:', ""]
                          ],
                        ),
                      ]),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("A. SIEVING DATA",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Table.fromTextArray(
                        cellAlignment: Alignment.center,
                        headerCount: 1,
                        cellPadding: const EdgeInsets.all(5.2),
                        headerPadding: const EdgeInsets.only(
                            bottom: 14.5, top: 14.5, left: 2, right: 2),
                        data: [
                          [
                            "Sieve Size(mm)",
                            "Weight Retained",
                            "Cummulative Weight Retained",
                            "Cummmulative Retained(%)",
                            "% passing"
                          ],
                          ["40.00", "0.0", "0.0", "0.0", "100.0"],
                          ["20.00", "512", "512", "512.34", "9.55"],
                          ["10.00", "512", "512", "512.34", "9.55"],
                          ["4.750", "512", "512", "512.34", "9.55"],
                          ["Pan", "512", "512", "9.55"],
                          ["Total Wt. gm", "11400"]
                        ]),
                    Container(
                      child: Column(children: [
                        Table.fromTextArray(
                            cellPadding: const EdgeInsets.only(
                                left: 5, right: 5, top: 2, bottom: 1.5),
                            headerCount: 0,
                            defaultColumnWidth: FixedColumnWidth(135),
                            border: TableBorder(
                              left: BorderSide.none,
                              right: BorderSide.none,
                              horizontalInside: BorderSide.none,
                            ),
                            context: context,
                            data: [
                              ["Specification  Limits (Single "],
                              ["sized) IS 383 Table 7"]
                            ]),
                        Table.fromTextArray(
                            headerCount: 0,
                            defaultColumnWidth: FixedColumnWidth(68),
                            context: context,
                            border: TableBorder(
                                right: BorderSide.none, left: BorderSide.none),
                            data: [
                              ["Minimum %", "Maximum %"],
                              ["100.0", "100.0"],
                              ["95.0", "100.0"],
                              ["25.0", "55.0"],
                              ["0.0", "10.0"],
                              ["-", "-"],
                              ["-", "-"]
                            ]),
                      ]),
                    ),
                  ]),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Table.fromTextArray(
                          context: context,
                          cellPadding: const EdgeInsets.only(
                              bottom: 20, top: 3, left: 4),
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
                              columnWidths: {
                                0: FixedColumnWidth(100),
                                1: FixedColumnWidth(117)
                              },
                              headerHeight: 40.0,
                              data: [
                                ["", ""],
                                ["Tested By", "Checked By"],
                                ['Lab technician', "Senior Lab Technician"]
                              ],
                            ),
                            Table.fromTextArray(
                              border: TableBorder(left: BorderSide.none),
                              headerHeight: 40.0,
                              tableWidth: TableWidth.max,
                              defaultColumnWidth: FixedColumnWidth(180),
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
  final String path = '$appDocDirPath/cementSettingReport.pdf';
  final file = File(path);
  file.writeAsBytes(await doc.save());

  return path;
}
