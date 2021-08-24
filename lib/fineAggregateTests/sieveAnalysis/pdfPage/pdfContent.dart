import 'dart:io';
import 'package:pdf/pdf.dart';
import "package:path_provider/path_provider.dart";
import 'package:pdf/widgets.dart';

final ktableBorder = TableBorder.all(width: 2.0, color: PdfColors.black);

Future<File> pdfContent() async {
  final Document pdf = Document();

  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      theme: ThemeData().copyWith(
          defaultTextStyle: TextStyle(
        fontSize: 10.0,
      )),
      build: (Context context) {
        print(PdfPageFormat.a4.availableWidth);
        return [
          Container(
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(style: BorderStyle.solid),
              right: BorderSide(style: BorderStyle.solid),
            )),
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
                      SizedBox(height: 10),
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
                        Center(
                          child: Text('GRADATION TEST'.toUpperCase()),
                        ),
                      ]),
                      TableRow(children: [
                        Text("IS 383-1970; Grading Zone I",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                    ]),
                // Table.fromTextArray(
                //   headerAlignment: Alignment.centerLeft,
                //   tableWidth: TableWidth.max,
                //   data: [
                //     ["Sample Information::"]
                //   ],
                // ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 43.0,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Sample Information:",
                                    textAlign: TextAlign.left),
                              )),
                          Table.fromTextArray(
                              headerCount: 0,
                              tableWidth: TableWidth.max,
                              defaultColumnWidth: FixedColumnWidth(
                                  PdfPageFormat.a4.availableWidth / 4),
                              data: [
                                ["Lab Ref No.", ""],
                                ["Date of Test:", ""],
                                ["Total wt. of the\n sample, gm:"]
                              ])
                        ],
                      ),
                      Table.fromTextArray(
                        defaultColumnWidth: FixedColumnWidth(
                            PdfPageFormat.a4.availableWidth / 4),
                        headerCount: 0,
                        tableWidth: TableWidth.max,
                        data: [
                          ["1. Date of Sampling:", ""],
                          ["2.Location of sample:"],
                          ["3.Source of sample:", ""],
                          ["4. Sampled By:", "Jointly"],
                        ],
                      ),
                    ]),
                SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Table(border: TableBorder.all(), children: [
                      TableRow(
                        children: [
                          Table.fromTextArray(
                              defaultColumnWidth: FixedColumnWidth(50.0),
                              headerCount: 1,
                              headerStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              cellAlignment: Alignment.center,
                              headerPadding: const EdgeInsets.only(
                                top: 36.50,
                                bottom: 2.0,
                              ),
                              cellHeight: 22.1,
                              data: [
                                ["Sieve Size in mm"],
                                ["10"],
                                ["4.75"],
                                ["2.36"],
                                ["1.18"],
                                ["0.6"],
                                ["0.3"],
                                ["0.15"],
                                ["Pan"],
                              ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('Actual Obtained',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Table.fromTextArray(
                                cellHeight: 22.0,
                                cellAlignment: Alignment.center,
                                // headerPadding: const EdgeInsets.all(2.0),
                                defaultColumnWidth: FixedColumnWidth(40.0),
                                context: context,
                                data: [
                                  [
                                    "Wt.\nRetained",
                                    "Cumm. Wt.\n Passing",
                                    "% Passing"
                                  ],
                                  ["2345.34", "1234.45", ""],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                ]),
                          ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('Specification',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Table.fromTextArray(
                                cellHeight: 22.0,
                                cellAlignment: Alignment.center,
                                tableWidth: TableWidth.max,
                                defaultColumnWidth: FixedColumnWidth(40.0),
                                // headerPadding: const EdgeInsets.only(
                                //     top: 20.0, bottom: 2.0),
                                context: context,
                                data: [
                                  [
                                    "% Passing,\nMin.",
                                    "% Passing,\nMax.",
                                  ],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                  ["2345.34", "1234.45"],
                                ]),
                          ]),
                          Table.fromTextArray(
                              headerCount: 1,
                              headerPadding: const EdgeInsets.only(top: 38.6),
                              cellHeight: 22.0,
                              border: TableBorder(
                                top: BorderSide.none,
                                bottom: BorderSide.none,
                                left: BorderSide.none,
                                verticalInside:
                                    BorderSide(style: BorderStyle.solid),
                                horizontalInside:
                                    BorderSide(style: BorderStyle.solid),
                              ),
                              data: [
                                ["Remarks"],
                                [""],
                                [""],
                                [""],
                                [""],
                                [""],
                                [""],
                                [""],
                                [""]
                              ])
                        ],
                      )
                    ]),
                    // Table.fromTextArray(
                    //     headerCount: 0,
                    //     columnWidths: {
                    //       0: FixedColumnWidth(14.8),
                    //       1: FixedColumnWidth(
                    //           (PdfPageFormat.a4.availableWidth / 10)),
                    //       2: FixedColumnWidth(14.3),
                    //       3: FixedColumnWidth(19.5),
                    //       4: FixedColumnWidth(19.5),
                    //       5: FixedColumnWidth(19.5),
                    //       6: FixedColumnWidth(40.0)
                    //     },
                    //     context: context,
                    //     data: [
                    //       [
                    //         1,
                    //         "Total Weight of the sample",
                    //         "gm",
                    //         "15269",
                    //         "15269",
                    //         "15269",
                    //         ""
                    //       ],
                    //       [
                    //         2,
                    //         "Weight of the sample Retained on 0.075 mm  sieve"
                    //       ],
                    //       [
                    //         3,
                    //         "Weight of the sample Passing through 0.075 mm  sieve"
                    //       ],
                    //       [
                    //         4,
                    //         "% of sample passing through 0.075 mm sieve clay & silt",
                    //         "gm"
                    //       ],
                    //       [5, "Unit Weight, (W1/W2)", "gm"],
                    //       [6, "Average Clay & silt content %"]
                    //     ]),

                    Container(
                      height: 38.0,
                      padding: const EdgeInsets.only(top: 2, left: 2),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                        right: BorderSide(width: 1),
                      )),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Comments:",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),

                    Table.fromTextArray(
                      context: context,
                      defaultColumnWidth: FlexColumnWidth(1),
                      headerStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                      data: [
                        ['Contractor', "Client"],
                      ],
                    ),
                    Table.fromTextArray(context: context, data: [
                      [
                        "",
                        "",
                      ],
                    ]),
                    Table.fromTextArray(
                      headerStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      context: context,
                      headerCount: 1,
                      data: [
                        [
                          "Tested By",
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
                    ),
                  ],
                )
              ],
            ),
          )
        ];
      },
    ),
  );
  final String appDocDirPath = (await getApplicationDocumentsDirectory()).path;
  final String path = '$appDocDirPath/ACVtestReport.pdf';
  final File file = File(path);

  await file.writeAsBytes(await pdf.save());
  return file;
}
