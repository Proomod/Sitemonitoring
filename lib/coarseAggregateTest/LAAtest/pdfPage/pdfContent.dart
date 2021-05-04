import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

Future<String> coarseLAAtestReport() async {
  Document doc = Document();
  doc.addPage(
    MultiPage(build: (Context context) {
      return [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
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
                  border: TableBorder.all(
                    color: PdfColors.black,
                  ),
                  children: [
                    TableRow(children: [
                      Header(
                        child: Center(
                          child: Text('Los Angeles Abrasion Value Test',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Center(
                          child: Text(
                        "As per IS: 2386(Part IV)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                    ]),
                  ]),
              Table.fromTextArray(columnWidths: {
                0: FlexColumnWidth(0.2),
                1: FlexColumnWidth(1),
              }, data: [
                ['Description of materials'],
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
                        ["Material Source", ""]
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
              Center(child: Text("Grading of test samples")),
              Column(
                children: [
                  Table.fromTextArray(
                    context: context,
                    headerCount: 0,
                    data: [
                      ["Sieve Size(mm)", "Mass of indicated Sizes(g)"]
                    ],
                  ),
                  Table.fromTextArray(
                    headerCount: 0,
                    context: context,
                    data: [
                      [
                        "Passing",
                        "Retained on",
                        "A",
                        'B',
                        "C",
                        "D",
                        "E",
                        "F",
                        "G"
                      ],
                      [
                        "80",
                        "63",
                        "-------",
                        "-------",
                        "-------",
                        "2500±50",
                        '-------',
                        '-------'
                      ],
                      [
                        '63',
                        '50',
                        "-------",
                        "-------",
                        "-------",
                        "2500±50",
                        '-------',
                        '-------'
                      ],
                      [
                        "50,40",
                        "-------",
                        "-------",
                        "-------",
                        "5000±100",
                        '5000±100',
                        '-------'
                      ],
                      [
                        "40",
                        "25",
                        "1250±25",
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                        "5000±100",
                        '5000±100'
                      ],
                      [
                        "25",
                        '20',
                        "1250±25",
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                        '5000±100'
                      ],
                      [
                        '20',
                        '12.50',
                        '1250±10',
                        '2500±10',
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                      ],
                      [
                        '12.50',
                        '10.00',
                        '1250±10',
                        '2500±10',
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                      ],
                      [
                        '10.00',
                        '6.30',
                        "-------",
                        "-------",
                        '2500±10',
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                      ],
                      [
                        '6.30',
                        '4.75',
                        "-------",
                        "-------",
                        '2500±10',
                        "-------",
                        "-------",
                        "-------",
                        "-------",
                      ],
                      [
                        '4.75',
                        '2.36',
                        "-------",
                        "-------",
                        "-------",
                        '5000±10',
                        "-------",
                        "-------",
                        "-------",
                      ],
                      [
                        "",
                        "Total",
                        '5000±10'
                            '5000±10'
                            '5000±10'
                            '5000±10',
                        '10000±200'
                            '10000±200'
                            '10000±200'
                      ],
                      [
                        "No of Spheres",
                        "",
                        "12",
                        "11",
                        "8",
                        '6',
                        '12',
                        '12',
                        '12'
                      ]
                    ],
                  ),
                  Table.fromTextArray(
                      context: context,
                      // cellPadding:
                      //     const EdgeInsets.only(bottom: 20, top: 3, left: 4),
                      headerCount: 0,
                      border: TableBorder(),
                      // columnWidths: {
                      //   0: FixedColumnWidth(50),
                      //   1: FlexColumnWidth(1),
                      // },
                      data: [
                        [
                          "General Remarks:-",
                          "No of Revolutions = 500 for grading A,B,C & D and 1000 for E,F & G grading"
                        ],
                      ]),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(style: BorderStyle.solid),
                      left: BorderSide(style: BorderStyle.solid),
                      right: BorderSide(style: BorderStyle.solid),
                    ),
                  ),
                  child: Text(
                    "Testing of material",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  Table.fromTextArray(data: [
                    [
                      "Specimen No.",
                      "grade",
                      "No. of Charges",
                      "No. of Revolution",
                      'Weight Before Test(g)',
                    ],
                    ['1', 'B', '11', "500", "5000"],
                    ['2', 'B', '11', "500", "5000"],
                  ]),
                  Column(children: [
                    Table.fromTextArray(
                      headerCount: 0,
                      data: [
                        ['Weight in grams after test'],
                      ],
                    ),
                    Table.fromTextArray(data: [
                      [
                        "Retained on 1.7 mm Sieve",
                        "Passing Through 1.7mm Sieve",
                        "Total quantity Available",
                      ],
                      ["3562", "1438", "5000"],
                      ["3520", "1480", "5000"]
                    ]),
                  ]),
                  Table.fromTextArray(data: [
                    [
                      "Loss in grams",
                      "Percent wear",
                      "Mean wear in percent",
                    ],
                    ['-', "28.76", "29.18"],
                    ["-", "29.6"]
                  ]),
                ],
              ),
              SizedBox(height: 30),
              Row(children: [
                Table.fromTextArray(data: [
                  ["Los Angeles Abrasion Value(LAA)%=    29.18"]
                ]),
                Table.fromTextArray(data: [
                  ["Specifications Limit,<45% for ordinary concrete    "]
                ])
              ]),
              Table.fromTextArray(data: [
                ["Comments", ""]
              ]),
              Column(
                children: [
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
                          headerHeight: 10.0,
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
