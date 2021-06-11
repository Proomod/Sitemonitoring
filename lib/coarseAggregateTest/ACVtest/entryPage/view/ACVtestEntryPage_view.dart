import 'package:flutter/material.dart';
import 'package:site_monitoring/coarseAggregateTest/ACVtest/model/acvTestModel.dart';

class ACVTestEntry extends StatefulWidget {
  ACVTestEntry({Key? key}) : super(key: key);

  @override
  _ACVTestEntryState createState() => _ACVTestEntryState();
}

class _ACVTestEntryState extends State<ACVTestEntry> {
  String? errorMessage;
  bool isDataAdded = false;
  List<ACVTestModel> acvTestModelList = [];
  TextEditingController _wtOfAggregateCylinderController =
      TextEditingController();
  TextEditingController _wtOfCylinderController = TextEditingController();
  TextEditingController _wtOfAggregatePassingSieveController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: Center(
              child: ElevatedButton(
                child: Text("Add new Data"),
                onPressed: () async {
                  ACVTestModel? data = await _openDataEntryDialog();
                  if (data != null) {
                    setState(() {
                      isDataAdded = true;
                      acvTestModelList.add(data);
                    });
                  }
                },
              ),
            ),
          ),
          isDataAdded ? _createOrAppendDataTable() : SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<ACVTestModel?> _openDataEntryDialog() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Add new Data"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DataInputField(
                    textController: _wtOfAggregateCylinderController,
                    inputLabel: "Wt. of aggregate + Cylindrical",
                  ),
                  _DataInputField(
                    textController: _wtOfCylinderController,
                    inputLabel: "Wt. of cylinder",
                  ),
                  _DataInputField(
                    textController: _wtOfAggregatePassingSieveController,
                    inputLabel: "Wt. of aggregate passing on seive",
                  ),
                  Text(errorMessage.toString(),
                      style: TextStyle(color: Colors.red))
                ],
              ),
              actions: [
                TextButton(
                    child: Text("ok"),
                    onPressed: () {
                      ACVTestModel? acvData;
                      try {
                        acvData = ACVTestModel(
                          wtOfAggregateAndCylindrical: double.tryParse(
                              _wtOfAggregateCylinderController.text)!,
                          wtOfCylinder:
                              double.tryParse(_wtOfCylinderController.text)!,
                          wtOfAggregateAfterPassingSeive: double.tryParse(
                              _wtOfAggregatePassingSieveController.text)!,
                        );
                      } catch (e) {
                        print(e);
                      }
                      if (acvData == null) {
                        setState(() {
                          errorMessage = "Please input all the values";
                        });
                      } else {
                        setState(() {
                          _wtOfAggregatePassingSieveController.clear();
                          _wtOfCylinderController.clear();
                          _wtOfAggregatePassingSieveController.clear();
                          errorMessage = "";
                        });
                        Navigator.pop(context, acvData);
                      }
                    }),
                TextButton(
                  child: Text("cancel", style: TextStyle(color: Colors.red)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  _createOrAppendDataTable() {
    if (acvTestModelList.length >= 3) {
      return;
    }
    return Flexible(
        flex: 5,
        fit: FlexFit.tight,
        child: SingleChildScrollView(
            child: Row(
          children: [
            Column(
              children: _buildCells(
                [
                  Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Total Wt. of a agg. + cylindrical, W1 g"),
                  Text("Wt. of cylinder, W2 g"),
                  Text(
                      "Wt. of Agg. passing on 2.36 mm sieve after the test = W4 g")
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildColumns(acvTestModelList, context),
                ),
              ),
            )
          ],
        )));
  }

  List<Widget> _buildCells(List<Widget> items) {
    return List.generate(
      items.length,
      (index) => Container(
        alignment: Alignment.center,
        height: 80.0,
        width: 120.0,
        color: Colors.black26,
        margin: EdgeInsets.all(4.0),
        child: items[index],
      ),
    );
  }

  List<Widget> _buildColumns(List<ACVTestModel> data, context) {
    return List.generate(
        data.length,
        (index) => GestureDetector(
              onLongPress: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Delete?"),
                          actions: [
                            TextButton(
                                onPressed: () {},
                                child: Text('ok',
                                    style: TextStyle(color: Colors.green))),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('cancel',
                                    style: TextStyle(color: Colors.red)))
                          ],
                        ));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildCells([
                  Text((index + 1).toString()),
                  Text(data[index].wtOfAggregateAndCylindrical.toString()),
                  Text(data[index].wtOfCylinder.toString()),
                  Text(data[index].wtOfAggregateAfterPassingSeive.toString()),
                ]),
              ),
            ));
  }
}

class _DataInputField extends StatelessWidget {
  const _DataInputField({
    required textController,
    required inputLabel,
    Key? key,
  })  : _controller = textController,
        _inputLabel = inputLabel,
        super(key: key);

  final TextEditingController _controller;
  final String _inputLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_inputLabel),
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
