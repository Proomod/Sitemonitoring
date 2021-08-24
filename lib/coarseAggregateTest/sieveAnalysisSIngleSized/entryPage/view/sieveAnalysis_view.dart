import 'package:flutter/material.dart';
import 'package:site_monitoring/coarseAggregateTest/sieveAnalysisSIngleSized/model/SieveAnalysisSingleModel.dart';

class SieveAnalysisSingleEntry extends StatefulWidget {
  SieveAnalysisSingleEntry({Key? key}) : super(key: key);

  @override
  _SieveAnalysisSingleEntryState createState() =>
      _SieveAnalysisSingleEntryState();
}

class _SieveAnalysisSingleEntryState extends State<SieveAnalysisSingleEntry> {
  TextEditingController _wtRetainedController = TextEditingController();
  String? sieveSizeValue;
  List<SieveAnalyisisSingleModel> sieveAnalysisSingleList = [];

  String? errorText;
  bool isDataAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sieve Analysis Single Sized")),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: Text("Add Data"),
              onPressed: () async {
                SieveAnalyisisSingleModel? data = await _openDataEntryDialog();
                if (data != null) {
                  setState(() {
                    isDataAdded = true;
                    sieveAnalysisSingleList.add(data);
                  });
                }
              },
            ),
          ),
          isDataAdded ? _createOrUpdateDataTable() : SizedBox.shrink()
        ],
      ),
    );
  }

  Future<SieveAnalyisisSingleModel?> _openDataEntryDialog() async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DataEntryTextField(
                        name: "Weight Retained",
                        controller: _wtRetainedController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sieve Size (mm)"),
                        DropdownButton<String>(
                          value: sieveSizeValue,
                          items: SieveAnalyisisSingleModel.sieveSizeValues
                              .map(
                                (sieveval) => DropdownMenuItem(
                                    child: Text(sieveval), value: sieveval),
                              )
                              .toList(),
                          onChanged: (val) {
                            print(sieveSizeValue);
                            setState(() {
                              sieveSizeValue = val;
                            });
                          },
                          hint: Text("Select one"),
                        ),
                      ],
                    ),
                    errorText != null
                        ? Text(errorText!, style: TextStyle(color: Colors.red))
                        : SizedBox.shrink()
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('ok'),
                    onPressed: () async {
                      SieveAnalyisisSingleModel? modelData;
                      try {
                        modelData = SieveAnalyisisSingleModel(
                            sieveSize: sieveSizeValue!,
                            wtRetained:
                                double.tryParse(_wtRetainedController.text)!);
                      } catch (e) {}
                      if (modelData == null) {
                        setState(() {
                          errorText = "Please check all the values";
                        });
                      } else {
                        setState(() {
                          errorText = null;
                          sieveSizeValue = null;
                          _wtRetainedController.clear();
                        });
                        Navigator.pop(context, modelData);
                      }
                    },
                  ),
                  TextButton(
                    child: Text('cancel', style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
  }

  _createOrUpdateDataTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text("Sieve Size")),
        DataColumn(label: Text("Weight retained"))
      ],
      rows: sieveAnalysisSingleList.map((data) {
        return DataRow(cells: [
          DataCell(Text(data.sieveSize)),
          DataCell(Text(data.wtRetained.toString()))
        ]);
      }).toList(),
    );
  }
}

class _DataEntryTextField extends StatelessWidget {
  const _DataEntryTextField({
    required TextEditingController controller,
    required this.name,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
        ),
        SizedBox(
          width: 60.0,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );
  }
}
