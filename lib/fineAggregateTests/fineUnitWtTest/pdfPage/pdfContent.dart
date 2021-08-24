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
                          child: Text('UNIT WEIGHT TEST'.toUpperCase()),
                        ),
                      ]),
                      TableRow(children: [
                        Text("IS: 2386 (Part III) - 1963",
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
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Table(border: TableBorder.all(), children: [
                      TableRow(
                        children: [
                          Table.fromTextArray(
                              columnWidths: {
                                0: FixedColumnWidth(14.5),
                                1: FixedColumnWidth(
                                    (PdfPageFormat.a4.availableWidth / 10) +
                                        0.3),
                                2: FixedColumnWidth(14.0),
                              },
                              headerCount: 1,
                              headerPadding: const EdgeInsets.only(
                                top: 19.5,
                                bottom: 2.0,
                              ),
                              data: [
                                ["S.No.", "Description", 'Unit'],
                              ]),
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('Sample No.'),
                            ),
                            Table.fromTextArray(
                                headerPadding: const EdgeInsets.all(2.0),
                                defaultColumnWidth: FixedColumnWidth(18.5),
                                context: context,
                                data: [
                                  ["I", "II", "III"],
                                ]),
                          ]),
                          Table.fromTextArray(
                              tableWidth: TableWidth.max,
                              defaultColumnWidth: FixedColumnWidth(40.0),
                              headerPadding:
                                  const EdgeInsets.only(top: 20.0, bottom: 2.0),
                              context: context,
                              data: [
                                ["Remarks"],
                              ])
                        ],
                      )
                    ]),
                    Table.fromTextArray(
                        headerCount: 1,
                        columnWidths: {
                          0: FixedColumnWidth(14.8),
                          1: FixedColumnWidth(
                              (PdfPageFormat.a4.availableWidth / 10)),
                          2: FixedColumnWidth(14.3),
                          3: FixedColumnWidth(19.5),
                          4: FixedColumnWidth(19.5),
                          5: FixedColumnWidth(19.5),
                          6: FixedColumnWidth(40.0)
                        },
                        context: context,
                        data: [
                          [
                            "A",
                            "Rodded Unit Weight",
                          ],
                          [
                            1,
                            "Wt. of mould",
                            "gm",
                            "15269",
                            "15269",
                            "15269",
                            ""
                          ],
                          [2, "Wt. of moild + sample"],
                          [3, "Wt. of the Sample, W1"],
                          [4, "Vol. of the Mould, W2", "gm"],
                          [5, "Unit Weight, (W1/W2)", "gm"],
                          [6, "Average compacted unit\n Weight"]
                        ]),
                    Table.fromTextArray(
                        headerCount: 1,
                        columnWidths: {
                          0: FixedColumnWidth(14.8),
                          1: FixedColumnWidth(
                              (PdfPageFormat.a4.availableWidth / 10)),
                          2: FixedColumnWidth(14.3),
                          3: FixedColumnWidth(19.5),
                          4: FixedColumnWidth(19.5),
                          5: FixedColumnWidth(19.5),
                          6: FixedColumnWidth(40.0)
                        },
                        context: context,
                        data: [
                          [
                            "B",
                            "Loose Unit Weight",
                          ],
                          [
                            1,
                            "Wt. of mould",
                            "gm",
                            "15269",
                            "15269",
                            "15269",
                            ""
                          ],
                          [2, "Wt. of moild + sample"],
                          [3, "Wt. of the Sample, W1"],
                          [4, "Vol. of the Mould, W2", "gm"],
                          [5, "Unit Weight, (W1/W2)", "gm"],
                        ]),
                    Table.fromTextArray(
                        cellAlignment: Alignment.bottomCenter,
                        headerCount: 0,
                        columnWidths: {
                          0: FixedColumnWidth(14.8),
                          1: FixedColumnWidth(
                              (PdfPageFormat.a4.availableWidth / 10)),
                          2: FixedColumnWidth(14.3),
                          3: FixedColumnWidth(19.5 * 3),
                          4: FixedColumnWidth(40),
                          // 5: FixedColumnWidth(19.5),
                          // 6: FixedColumnWidth(40.0)
                        },
                        data: [
                          [
                            6,
                            "Average compacted unit\n Weight",
                            "gm/cc",
                            "1.682",
                            ""
                          ]
                        ]),
                    Table.fromTextArray(
                      headerStyle: TextStyle(fontWeight: FontWeight.bold),
                      headerCount: 1,
                      columnWidths: {
                        0: FixedColumnWidth(14.8),
                        1: FixedColumnWidth(
                            (PdfPageFormat.a4.availableWidth / 10)),
                        2: FixedColumnWidth(14.3),
                        3: FixedColumnWidth(19.5 * 3),
                        4: FixedColumnWidth(40),
                        // 5: FixedColumnWidth(19.5),
                        // 6: FixedColumnWidth(40.0)
                      },
                      data: [
                        ["C", "Average unit weight", "gm/cc", "1.486", ""]
                      ],
                    ),
                    Container(
                      height: 30.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(width: 1),
                              top: BorderSide(width: 1))),
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
