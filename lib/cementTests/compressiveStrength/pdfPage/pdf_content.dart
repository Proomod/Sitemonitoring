import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';

import "package:path_provider/path_provider.dart";

final ktableBorder = TableBorder.all(
  width: 2.0,
  color: PdfColors.black,
);

Future<File> pdfContent(data, extraData) async {
  final Document pdf = Document();
  var dateNow = DateTime.tryParse(data["date_of_casting"])!;
  var formatteddateNow = DateFormat('yyyy-MM-dd').format(dateNow);
  var dateAfter3Days =
      DateFormat('yyyy-MM-dd').format(dateNow.add(Duration(days: 3)));
  var dateAfter7Days =
      DateFormat('yyyy-MM-dd').format(dateNow.add(Duration(days: 7)));
  var dateAfter28Days =
      DateFormat('yyyy-MM-dd').format(dateNow.add(Duration(days: 28)));

  pdf.addPage(
    MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) {
          if (context.pageNumber != 1) {
            return Text('');
          }
          return Table.fromTextArray(headerCount: 3, data: [
            ["Lab in Soil Mechanics"],
            ['Municipal Building'],
            ['071-072/BEE/36-42'],
          ]);
        },
        build: (Context context) {
          return <Widget>[
            SizedBox(height: 50),
            Table.fromTextArray(
              data: [
                ["Consultant* Ram Hari - Floyd JV"],
                ["Contractor* Ram Hari - Floyd JV"],
              ],
            ),
            Table(
              border: TableBorder.all(
                color: PdfColors.black,
              ),
              children: [
                TableRow(
                  children: [
                    Header(
                      text: "Determination Of Compressive Strength of cement"
                          .toUpperCase(),
                    ),
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
                TableRow(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Sample Location: ${data["sampleLocation"]}'),
                          Text('Sample Location: ${extraData.sampleLocation}'),
                          Text('Cement Brand/Source: ${data["cementSource"]}'),
                          Text('Sample By:'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(children: [
              Positioned(
                  left: 300,
                  child: Table.fromTextArray(
                      tableWidth: TableWidth.min,
                      context: context,
                      data: [
                        // ['Ingredient for 1cube'],
                        // ["cement", '${data["mixPorportion"]}', 'gm'],
                        // ["sand", '${data["sand_w"]}', 'gm'],
                        // ["TotalMass", '${data["totalMass"]}', 'gm'],
                        // ["water", '${data["water"]}', 'ml'],
                        // ["W/C", '${data["W_by_c"]}', 'ml']
                        ['Ingredient for 1cube'],
                        ["cement", '${extraData.cementWeight}', 'gm'],
                        ["sand", '${extraData.sandWeight}', 'gm'],
                        ["TotalMass", '', 'gm'],
                        ["water", '${extraData.waterWeight}', 'ml'],
                        ["W/C", '${data["W_by_c"]}', 'ml']
                      ])),
              Table(children: [
                TableRow(children: [
                  Text('Lab Ref no:'),
                ]),
                TableRow(children: [
                  Table.fromTextArray(
                      context: context,
                      headerCount: 0,
                      tableWidth: TableWidth.min,
                      columnWidths: {
                        0: FixedColumnWidth(180),
                        1: FixedColumnWidth(30),
                        2: FixedColumnWidth(30)
                      },
                      data: [
                        // ['Mixed Proportion:', '${data["mixPorportion"]}', ''],
                        ['Mixed Proportion:', '${extraData.mixProportion}', ''],
                        [
                          "Water required = (P/4+3) * Total Mass =",
                          "${data["waterRequired"]}",
                          'ml'
                        ],
                        [
                          'Normal Consistency of cement:',
                          '${data["NormalConsistencyOfCement"]}',
                          '%'
                        ]
                      ])
                ]),
                TableRow(children: [
                  Table.fromTextArray(
                    tableWidth: TableWidth.min,
                    columnWidths: {
                      0: FixedColumnWidth(180),
                      1: FixedColumnWidth(30),
                    },
                    context: context,
                    data: [
                      ['lab Ref/Cube Code no', ''],
                      ['Length of cube, L cm', '7'],
                      ['Breadth of cube, B cm', '7'],
                      ["Height of cube, H cm", '7'],
                      ['Volume of Cube, cm3 ', '${(7 * 7 * 7) / 109}'],
                      ["Loaded Area,A mm2", "${7 * 7}"]
                    ],
                  )
                ]),
                TableRow(children: [
                  Table.fromTextArray(
                    headerCount: 0,
                    data: [
                      ["Date of Casting $formatteddateNow"]
                    ],
                  )
                ])
              ]),
            ]),
            Table(border: ktableBorder, columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            }, children: [
              TableRow(children: [
                Text(''),
                Text("Compressive Strength Test 3 day"),
                Text("Compressive Strength Test 7 day"),
                Text("Compressive Strength Test 28 day"),
              ]),
              TableRow(children: [
                Text("Date of Test"),
                Text("$dateAfter3Days"),
                Text("$dateAfter7Days"),
                Text("$dateAfter28Days")
              ]),
              TableRow(
                children: [
                  Table.fromTextArray(
                    headerCount: 0,
                    cellStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
                    context: context,
                    data: [
                      ["Cube No:"],
                      ["Weight of cube, gm"],
                      [
                        "Density, D=m/V gm/cc",
                      ]
                    ],
                  ),
                  Table.fromTextArray(
                    headerCount: 0,
                    context: context,
                    data: [
                      [1, 2, 3],
                      [
                        data["cube_weight_1"].toStringAsFixed(2),
                        data["cube_weight_2"].toStringAsFixed(2),
                        data["cube_weight_3"].toStringAsFixed(2)
                      ],
                      [
                        data["density_1"].toStringAsFixed(2),
                        data["density_2"].toStringAsFixed(2),
                        data["density_3"].toStringAsFixed(2)
                      ]
                    ],
                  ),
                  Table.fromTextArray(
                    headerCount: 0,
                    context: context,
                    data: [
                      [4, 5, 6],
                      [
                        data["cube_weight_4"].toStringAsFixed(2),
                        data["cube_weight_5"].toStringAsFixed(2),
                        data["cube_weight_6"].toStringAsFixed(2)
                      ],
                      [
                        data["density_4"].toStringAsFixed(2),
                        data["density_5"].toStringAsFixed(2),
                        data["density_6"].toStringAsFixed(2)
                      ]
                    ],
                  ),
                  Table.fromTextArray(
                    headerCount: 0,
                    context: context,
                    data: [
                      [7, 8, 9],
                      [
                        data["cube_weight_7"].toStringAsFixed(2),
                        data["cube_weight_8"].toStringAsFixed(2),
                        data["cube_weight_9"].toStringAsFixed(2)
                      ],
                      [
                        data["density_7"].toStringAsFixed(2),
                        data["density_8"].toStringAsFixed(2),
                        data["density_9"].toStringAsFixed(2)
                      ]
                    ],
                  )
                ],
              ),
              // TableRow(
              //   children: [Text("")],
              // ),
              TableRow(children: [
                Table.fromTextArray(
                  headerCount: 0,
                  cellStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                  context: context,
                  data: [
                    ["Load  KN"],
                    ["Strength,(M/A)x1000"],
                  ],
                ),
                Table.fromTextArray(
                  headerCount: 0,
                  context: context,
                  data: [
                    [
                      data["cube_load_1"].toStringAsFixed(2),
                      data["cube_load_2"].toStringAsFixed(2),
                      data["cube_load_3"].toStringAsFixed(2)
                    ],
                    [
                      data["strength_1"].toStringAsFixed(2),
                      data["strength_2"].toStringAsFixed(2),
                      data["strength_3"].toStringAsFixed(2)
                    ]
                  ],
                ),
                Table.fromTextArray(
                  headerCount: 0,
                  context: context,
                  data: [
                    [
                      data["cube_load_4"].toStringAsFixed(2),
                      data["cube_load_5"].toStringAsFixed(2),
                      data["cube_load_6"].toStringAsFixed(2)
                    ],
                    [
                      data["strength_4"].toStringAsFixed(2),
                      data["strength_5"].toStringAsFixed(2),
                      data["strength_6"].toStringAsFixed(2)
                    ],
                  ],
                ),
                Table.fromTextArray(
                  headerCount: 0,
                  context: context,
                  data: [
                    [
                      data["cube_load_7"].toStringAsFixed(2),
                      data["cube_load_8"].toStringAsFixed(2),
                      data["cube_load_9"].toStringAsFixed(2)
                    ],
                    [
                      data["strength_7"].toStringAsFixed(2),
                      data["strength_8"].toStringAsFixed(2),
                      data["strength_9"].toStringAsFixed(2)
                    ],
                  ],
                ),
              ]),
              TableRow(children: [
                Text('Average Strength N/mm2'),
                Text('${data["avg_strength_1"].toStringAsFixed(2)}'),
                Text('${data["avg_strength_2"].toStringAsFixed(2)}'),
                Text('${data["avg_strength_3"].toStringAsFixed(2)}'),
              ]),
              TableRow(children: [
                Table.fromTextArray(
                  border: null,
                  headerCount: 0,
                  cellHeight: 50.0,
                  data: [
                    ["Remarks"]
                  ],
                )
              ]),
            ]),
            Table(border: ktableBorder, columnWidths: {
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
              )
            ])
          ];
        }),
  );
  final String appDocDirPath = (await getApplicationDocumentsDirectory()).path;
  final String path = '$appDocDirPath/CompressiveCementReport.pdf';
  final File file = File(path);

  await file.writeAsBytes(await pdf.save());

  return file;
}
