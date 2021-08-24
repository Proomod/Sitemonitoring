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
                              'SPECIFIC GRAVITY OF 20mm COARSE AGGREGATE '
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
                                // 0: FixedColumnWidth(14.5),
                                0: FixedColumnWidth(
                                    PdfPageFormat.a4.availableWidth / 6 + 0.5),
                                // 1: FixedColumnWidth(14.0),
                              },
                              headerCount: 1,
                              headerPadding: const EdgeInsets.only(
                                top: 19.5,
                                bottom: 2.0,
                              ),
                              data: [
                                ["Description", 'Unit'],
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
                                  [1, 2],
                                ]),
                          ]),
                          Table.fromTextArray(
                              tableWidth: TableWidth.max,
                              defaultColumnWidth: FixedColumnWidth(40.0),
                              headerPadding:
                                  const EdgeInsets.only(top: 20.0, bottom: 2.0),
                              context: context,
                              data: [
                                ["Average"],
                              ])
                        ],
                      )
                    ]),
                    Table.fromTextArray(
                        headerCount: 0,
                        columnWidths: {
                          0: FixedColumnWidth(
                              PdfPageFormat.a4.availableWidth / 12 - 1),
                          1: FixedColumnWidth(8.5),
                          // 1: FixedColumnWidth(
                          //     PdfPageFormat.a4.availableWidth / 4 - 11),
                          2: FixedColumnWidth(14.1),
                          3: FixedColumnWidth(14.1),
                          4: FixedColumnWidth(19.5),
                          // 5: FixedColumnWidth(19.5),
                          // 6: FixedColumnWidth(40.0)
                        },
                        context: context,
                        data: [
                          [
                            "Wt.of Sample + basket suspended in water",
                            "gms",
                            "15269",
                            "15269",
                            ""
                          ],
                          ["Wt.basket suspended in water", 'gms', 742.10],
                          [
                            "Wt. of saturated sample in water  (C) ",
                            'gms',
                            742.10
                          ],
                          ["Wt.of sat.surface dry Sample (B)", "gms"],
                          ["Wt. of oven dry Sample (A)", "%"],
                          ["Absorption=(B-A)/A*100"],
                          ["Apparent G =A/(A-C)"],
                          ["Bulk G (oven dry) = A/(B-C)"]
                        ]),
                    Table.fromTextArray(context: context, data: [
                      [
                        "NOTE:"
                            "A) SOAK SAMPLES FOR 24 HOURS TO OBTAIN BULK SPECIFIC GRAVITY",
                      ],
                    ]),
                    Row(children: [
                      Container(
                        width: (PdfPageFormat.a4.availableWidth / 2) + 10.5,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1),
                                right: BorderSide(width: 1))),
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  "As per specification table 20 400,3.4,C "),
                            )),
                      ),
                      Container(
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "DoR Standard Specification:Section 2003-4",
                                    textAlign: TextAlign.center))),
                      )
                    ]),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Table.fromTextArray(
                        headerCount: 0,
                        tableWidth: TableWidth.min,
                        data: [
                          ["", "Specific Gravity", "Water absorption"],
                          [
                            "Required",
                            "not less than 2.6 ",
                            "Not more than 2 %"
                          ]
                        ],
                      ),
                    ),
                    Divider(thickness: 1, height: 0),
                    Container(
                      height: 30.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(width: 1),
                              top: BorderSide(width: 1))),
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
