import 'package:flutter/material.dart';
import 'package:site_monitoring/cementTests/compressiveStrength/utilities/compressiveTest/CompressiveStrength.dart';
import 'package:site_monitoring/cementTests/compressiveStrength/utilities/compressiveTest/compressiveData.dart';

class CompressiveStrengthEntry extends StatefulWidget {
  @override
  _CompressiveStrengthEntryState createState() =>
      _CompressiveStrengthEntryState();
}

class _CompressiveStrengthEntryState extends State<CompressiveStrengthEntry> {
  Future<List<CompressiveStrength>>? _cubes;

  List<CompressiveStrength>? selectedCubes;
  List<CompressiveStrength>? finalCubes;
  @override
  void initState() {
    selectedCubes = [];
    CompressiveStrength.addCubesToDataBase();
    super.initState();
    _cubes = getCubes();
  }

  Future<List<CompressiveStrength>> getCubes() async {
    List<CompressiveStrength> temp;
    temp = await CompressiveStrength.getCubes();
    finalCubes = temp;
    return temp;
  }

  onSelectedRow(bool? selected, CompressiveStrength cube) async {
    setState(() {
      if (selected!) {
        selectedCubes!.add(cube);
        print(selectedCubes);
      } else {
        selectedCubes!.remove(cube);
      }
    });
  }

  deleteCube(cube) async {
    int id = await CompressiveStrength.deleteCubeData(cube);
    if (id != null) {
      finalCubes!.remove(cube);
      selectedCubes!.remove(cube);
    }
  }

  deleteSelected() async {
    setState(() {
      if (selectedCubes!.isNotEmpty) {
        List<CompressiveStrength> temp = [];
        temp.addAll(selectedCubes!);
        for (CompressiveStrength cube in temp) {
          deleteCube(cube);
        }
      }
    });
  }

  Widget dataBody() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,

          // constraints: BoxConstraints(
          //     minHeight: MediaQuery.of(context).size.height * .5),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: DataTable(
              showCheckboxColumn: false,
              dataTextStyle: TextStyle(
                color: Colors.white,
              ),
              sortColumnIndex: 0,
              horizontalMargin: 8.0,
              headingTextStyle: TextStyle(
                color: Colors.blue,
                fontSize: 15.0,
              ),
              columnSpacing: 28.0,
              sortAscending: true,
              columns: [
                DataColumn(
                  label: Text('Cube No'),
                  numeric: true,
                  tooltip: " Day of Observation ",
                ),
                DataColumn(
                  label: Text('CubeNo'),
                  numeric: true,
                  tooltip: "Cube Number",
                ),
                DataColumn(
                  label: Text('Weight'),
                  numeric: true,
                  tooltip: "Weight of cube ",
                ),
                DataColumn(
                  label: Text('Load'),
                  numeric: true,
                  tooltip: "Load of the cube ",
                ),
              ],
              rows: finalCubes!
                  .map(
                    (cube) => DataRow(
                      selected: selectedCubes!.contains(cube),
                      onSelectChanged: (value) {
                        print(value);
                        onSelectedRow(value, cube);
                      },
                      cells: [
                        DataCell(
                          Container(
                            width: 50.0,
                            child: Text(
                              cube.cubeNo.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(Container(
                          width: 50.0,
                          child: Text(
                            cube.cubeDay.toString(),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        DataCell(
                          Container(
                              width: 80.0,
                              child: Text(
                                cube.cubeWeight.toString(),
                                textAlign: TextAlign.right,
                              )),
                        ),
                        DataCell(
                          Container(
                            width: 90.0,
                            child: Text(
                              cube.cubeLoad.toString(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Cement Tests',
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _cubes,
        builder: (context, snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              children = [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      child: Text("Add New Cube"),
                      onPressed: () async {
                        List<int?> temList = [];

                        finalCubes!.forEach((cube) {
                          temList.add(cube.cubeNo);
                        });
                        temList = List.generate(
                          9,
                          (index) {
                            if (!(temList.contains(index + 1))) {
                              return index + 1;
                            }
                          },
                        );
                        temList = temList.toSet().toList();
                        temList.remove(null);
                        CompressiveStrength cube = CompressiveStrength();
                        cube.cubeDay = 3;
                        cube.cubeNo = (temList..shuffle()).first;
                        cube.cubeWeight = null;
                        cube.cubeLoad = null;

                        // setState(() {});
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Add new cube"),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Cube Day"),
                                          DropdownButton(
                                              value: cube.cubeDay,
                                              hint: Text("Cube Day"),
                                              icon: Icon(Icons.arrow_downward),
                                              iconSize: 24,
                                              elevation: 16,
                                              items: <dynamic>[3, 7, 28]
                                                  .map(
                                                    (num) => DropdownMenuItem<
                                                        dynamic>(
                                                      value: num,
                                                      child: Text(
                                                        num.toString(),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (dynamic value) {
                                                setState(() {
                                                  cube.cubeDay = value;
                                                });
                                              }),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Cube No"),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                                hint: Text("Cube No",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                value: cube.cubeNo,
                                                icon:
                                                    Icon(Icons.arrow_downward),
                                                iconSize: 24,
                                                elevation: 16,
                                                items: temList
                                                    .map(
                                                      (num) => DropdownMenuItem<
                                                          dynamic>(
                                                        value: num,
                                                        child: Text(
                                                          num.toString(),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (dynamic value) {
                                                  {
                                                    setState(() {
                                                      cube.cubeNo = value;
                                                    });
                                                  }
                                                }),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            cube.cubeLoad = double.parse(value);
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Load",
                                        ),
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            cube.cubeWeight =
                                                double.parse(value);
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Weight",
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                actions: [
                                  TextButton(
                                    autofocus: false,
                                    child: Text("Approve",
                                        style: TextStyle(color: Colors.blue)),
                                    onPressed: () async {
                                      setState(() {
                                        finalCubes!.add(cube);
                                      });
                                      await CompressiveStrength.addCubeData(
                                          cube);

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    autofocus: true,
                                    child: Text('Cancel',
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                    ElevatedButton(
                      child: Text("Process Data"),
                      onPressed: () async {
                        var primaryKey = await CompressiveStrengthProcessing(
                                cubes: finalCubes)
                            .sendCompressiveData();
                        finalCubes!.forEach((cube) {});
                        Navigator.pushNamed(context, '/resultPage', arguments: {
                          primaryKey: primaryKey,
                        });
                      },
                    ),
                  ],
                ),
                dataBody(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: OutlinedButton(
                        child: Text("Selected ${selectedCubes!.length}"),
                        onPressed: () => {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: OutlinedButton(
                        child: Text("Delete Selected",
                            style: TextStyle(
                                color: selectedCubes!.isEmpty
                                    ? Colors.grey
                                    : Colors.red)),
                        onPressed: selectedCubes!.isEmpty
                            ? null
                            : () {
                                deleteSelected();
                              },
                      ),
                    )
                  ],
                ),
              ];
            }
          } else if (snapshot.hasError) {
            children = [
              Text("An Error OCCOURED", style: TextStyle(color: Colors.red))
            ];
          } else {
            children = [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                ),
              )
            ];
          }

          return SingleChildScrollView(
              child:
                  Column(mainAxisSize: MainAxisSize.min, children: children));
        },
      ),
    );
  }
}
