import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
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
                        Center(
                          child: Text(
                              'AGGREGATE CRUSHING VALUE OF 20mm COARSE AGGREGATE'
                                  .toUpperCase()),
                        ),
                      ]),
                      TableRow(children: [
                        Text("As per IS: 2386(Part III) -1963",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                    ]),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table.fromTextArray(
                          headerCount: 0,
                          tableWidth: TableWidth.max,
                          defaultColumnWidth: FixedColumnWidth(
                              PdfPageFormat.a4.availableWidth / 4),
                          data: [
                            ["Lab Ref No.", ""],
                            ["Source of sample:", ""],
                            ["Date of Test:", ""],
                          ]),
                      Table.fromTextArray(
                        defaultColumnWidth: FixedColumnWidth(
                            PdfPageFormat.a4.availableWidth / 4),
                        headerCount: 0,
                        tableWidth: TableWidth.max,
                        data: [
                          ["1. Date of Sampling", ""],
                          ["2.Sample Location", ""],
                          ["3. Sampled By", "Jointly"],
                        ],
                      ),
                    ]),
                SizedBox(height: 15),
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
                                    PdfPageFormat.a4.availableWidth / 4 - 12),
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
                                  [1, 2, 3],
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
                        headerCount: 0,
                        columnWidths: {
                          0: FixedColumnWidth(14.8),
                          1: FixedColumnWidth(
                              PdfPageFormat.a4.availableWidth / 4 - 11),
                          2: FixedColumnWidth(14.3),
                          3: FixedColumnWidth(19.5),
                          4: FixedColumnWidth(19.5),
                          5: FixedColumnWidth(19.5),
                          6: FixedColumnWidth(40.0)
                        },
                        context: context,
                        data: [
                          [
                            1,
                            "Total Wt. of a agg. + cylindrical, W1 g",
                            "gm",
                            "15269",
                            "15269",
                            "15269",
                            ""
                          ],
                          [2, "Wt. of cylinder, W2 g"],
                          [3, "Weight of Aggregate (W1 - W2) = W3 g"],
                          [
                            4,
                            "Wt. of Agg. passing on 2.36 mm sieve after the test = W4 g",
                            "gm"
                          ],
                          [5, "Aggregate Crushing value, % = W4/W3 x 100", "%"],
                        ]),
                    Table.fromTextArray(
                        columnWidths: {
                          0: FixedColumnWidth(8.3),
                          1: FixedColumnWidth(60.0),
                          2: FixedColumnWidth(8),
                          3: FixedColumnWidth(32.0),
                          4: FixedColumnWidth(22.0),
                        },
                        context: context,
                        data: [
                          [
                            6,
                            "Average Aggregate Crushing value",
                            "%",
                            "21.7",
                            ""
                          ],
                        ]),
                    Table.fromTextArray(
                        columnWidths: {
                          0: FixedColumnWidth(12),
                          1: FixedColumnWidth(89.2),
                          2: FixedColumnWidth(12.0),
                          3: FixedColumnWidth(80.0),
                        },
                        context: context,
                        data: [
                          ["", "Specification Limit:", r"<45%", ""],
                        ]),
                    Container(
                      height: 30.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(width: 1))),
                      child: Center(
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
