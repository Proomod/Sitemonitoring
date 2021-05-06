import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:site_monitoring/cementTests/cementsetting/utilities/CementSetting.dart';

class CementSettingEntry extends StatefulWidget {
  @override
  _CementSettingEntryState createState() => _CementSettingEntryState();
}

class _CementSettingEntryState extends State<CementSettingEntry> {
  Future<List<CementSetting>> _settingTimes;
  List<CementSetting> selectedTimes;
  List<CementSetting> finalTimes;

  @override
  void initState() {
    selectedTimes = [];

    _settingTimes = getTimes();
    super.initState();
  }

  Future<List<CementSetting>> getTimes() async {
    List<CementSetting> temp;
    temp = await CementSetting.getData();
    finalTimes = temp;
    return temp;
  }

  onSelectedRow(bool selected, CementSetting time) async {
    setState(() {
      if (selected) {
        selectedTimes.add(time);
      } else {
        selectedTimes.remove(time);
      }
    });
  }

  deleteCube(time) async {
    try {
      int id = await CementSetting.deleteCubeData(time);
      print(id);
      if (id != null) {
        setState(() {
          finalTimes.remove(time);
          selectedTimes.remove(time);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  deleteSelected() async {
    if (selectedTimes.isNotEmpty) {
      List<CementSetting> temp = [];
      temp.addAll(selectedTimes);
      for (CementSetting time in temp) {
        await deleteCube(time);
      }
    }
  }

  addSettingTime(CementSetting cementSetting) {
    setState(() {
      finalTimes.add(cementSetting);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text("Cement Setting Test "),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _settingTimes,
        builder: (context, snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              children = [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    finalTimes.isNotEmpty
                        ? DataTable(
                            showCheckboxColumn: false,
                            columns: [
                              DataColumn(
                                label: Text("Obeservation"),
                              ),
                              DataColumn(
                                  label: Container(
                                child: Column(
                                  children: [
                                    Text("Observed Time"),
                                    Row(
                                      children: [Text("Hour"), Text('minute')],
                                    ),
                                  ],
                                ),
                              )),
                              DataColumn(label: Text('')),
                            ],
                            rows: finalTimes.map((data) {
                              return DataRow(
                                  selected: selectedTimes.contains(data),
                                  onSelectChanged: (value) {
                                    onSelectedRow(value, data);
                                  },
                                  cells: [
                                    DataCell(Text(data.settingType)),
                                    DataCell(Text(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                data.settingDateTime)
                                            .hour
                                            .toString())),
                                    DataCell(Text(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                data.settingDateTime)
                                            .minute
                                            .toString()))
                                  ]);
                            }).toList())
                        : SizedBox.shrink(),
                  ],
                ),
                finalTimes.length < 3
                    ? AddButton(
                        addSettingTime: (val) => addSettingTime(val),
                      )
                    : Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => {},
                      child: Text("Selected ${selectedTimes.length}"),
                    ),
                    OutlinedButton(
                        onPressed: () => selectedTimes.isEmpty
                            ? null
                            : showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Are you sure?"),
                                    actions: [
                                      TextButton.icon(
                                          onPressed: () async {
                                            await deleteSelected();
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          label: Text('')),
                                      TextButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          label: Text(""))
                                    ],
                                  );
                                }),
                        child: Text(
                          "Delete Selected",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ),
              ];
            }
          } else if (snapshot.hasError) {
            children = [
              Text(
                'Some error occured',
                style: TextStyle(color: Colors.red),
              )
            ];
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          );
        },
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final Function addSettingTime;
  const AddButton({
    this.addSettingTime,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          // List<int> tempList = [];
          // finalTimes.forEach((time) {
          //   tempList.add(time.cementSettingId);

          bool isSubmitting = false;

          DateTime recordTime;
          String errorMessage;

          String selectedItem;
          List<String> inputItems = [
            "Water Added Time",
            "Initial Setting Time",
            "Final Setting Time"
          ];
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text("Add Setting Time"),
                    content: !isSubmitting
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  DropdownButton(
                                    value: selectedItem,
                                    items: inputItems.map((item) {
                                      return DropdownMenuItem<String>(
                                          value: item, child: Text(item));
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedItem = value;
                                        print(selectedItem);
                                      });
                                    },
                                  ),
                                  TimePickerSpinner(
                                    time: DateTime.now(),
                                    normalTextStyle: TextStyle(fontSize: 12),
                                    highlightedTextStyle: TextStyle(
                                        fontSize: 16.0, color: Colors.blue),
                                    spacing: 10.0,
                                    itemHeight: 20,
                                    onTimeChange: (time) {
                                      setState(() {
                                        recordTime = time;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                    actions: [
                      TextButton(
                          child: Text("Save"),
                          onPressed: () async {
                            setState(() {
                              isSubmitting = true;
                            });
                            CementSetting cementTime = CementSetting(
                                settingType: selectedItem,
                                settingDateTime:
                                    recordTime.millisecondsSinceEpoch);

                            try {
                              await CementSetting.addData(cementTime);
                            } catch (e) {
                              print(e);
                            }
                            setState(() {
                              addSettingTime(cementTime);
                              isSubmitting = false;
                            });

                            Navigator.pop(context);

                            //write to database
                          }),
                      TextButton(
                          autofocus: true,
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  );
                });
              });
        },
        child: Text("Add New"));
  }
}
