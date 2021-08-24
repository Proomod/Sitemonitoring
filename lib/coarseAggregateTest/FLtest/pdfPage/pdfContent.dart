import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
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
                          child: Text('Flakiness Index'.toUpperCase()),
                        ),
                      ]),
                      TableRow(children: [
                        Text("As per IS:2386",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                    ]),
                Table.fromTextArray(
                  headerAlignment: Alignment.centerLeft,
                  tableWidth: TableWidth.max,
                  data: [
                    ["Description of materials:"],
                  ],
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table.fromTextArray(
                          headerCount: 0,
                          tableWidth: TableWidth.max,
                          defaultColumnWidth:
                              FixedColumnWidth(PdfPageFormat.a4.width / 5),
                          data: [
                            ["Lab Ref No.", ""],
                            ["Source:", ""],
                            ["Date of Test:", ""],
                            ["Total wt. of Sample \n(gm)", ""],
                          ]),
                      Table.fromTextArray(
                        headerCount: 0,
                        defaultColumnWidth:
                            FixedColumnWidth(PdfPageFormat.a4.width / 4 - 40),
                        tableWidth: TableWidth.max,
                        data: [
                          ["1. Date of Sampling", ""],
                          ["2.Sample Location/Ch", ""],
                          ["3. Sampled By", ""],
                        ],
                      ),
                    ]),
                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Table.fromTextArray(
                      tableWidth: TableWidth.max,
                      columnWidths: {
                        0: IntrinsicColumnWidth(),

                        // 2: FixedColumnWidth(20.0),
                        // 3: FixedColumnWidth(20.0),
                        // 4: FixedColumnWidth(20.0),
                        // 5: FixedColumnWidth(20.0),
                      },
                      headers: [
                        "Fraction Size",
                        "Sieve \n Size mm",
                        "Test \n Wt. (g)",
                        "Wt.\n passing (g)",
                        "% \nFlaky",
                        "Remarks"
                      ],
                      headerCount: 1,
                      data: [
                        ["> 15% 200 pieces minimum", "63-50", ""],
                        ["", "50 - 40 ", ""],
                        [">5 <15% 100 pieces minimum", "40 - 31.5", ""],
                        [" ", "31.5 - 25", ""],
                        ["<5% Not Tested", "25 - 20", ""],
                        [" ", "20 - 16", "405"],
                        [" ", "16 - 12.5", "304"],
                        [" ", "12.5 - 10", "1140"],
                        [" ", "10 - 6.3", "1234"],
                        ["", "Total wt.", ""]
                      ],
                    ),
                    Table.fromTextArray(
                        headerCount: 2,
                        columnWidths: {
                          0: FixedColumnWidth(41.5),
                          1: FixedColumnWidth(40.0),
                        },
                        tableWidth: TableWidth.max,
                        context: context,
                        data: [
                          [
                            "Flakiness Index",
                            "20.6",
                          ],
                          [
                            "Specifications Limit",
                            "Not more than 25% for ordinary concrete",
                          ]
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
                    )
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
  final String path = '$appDocDirPath/CompressiveCementReport.pdf';
  final File file = File(path);

  await file.writeAsBytes(await pdf.save());

  return file;
}
