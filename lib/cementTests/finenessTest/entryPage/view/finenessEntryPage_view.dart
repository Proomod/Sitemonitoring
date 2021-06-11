import 'package:flutter/material.dart';
import 'package:site_monitoring/cementTests/finenessTest/model/finenessTest_model.dart';

class FinenessTestEntry extends StatefulWidget {
  const FinenessTestEntry({Key? key}) : super(key: key);

  @override
  _FinenessTestEntryState createState() => _FinenessTestEntryState();
}

class _FinenessTestEntryState extends State<FinenessTestEntry> {
  TextEditingController _wtOfCementInputController = TextEditingController();
  TextEditingController _wtOfResidueInputController = TextEditingController();
  List<FinenessTestModel> finenessDataList = [];
  bool isDataAdded = false;
  String? errorMessage = '';

  @override
  void dispose() {
    _wtOfCementInputController.dispose();
    _wtOfResidueInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fineness Test Entry"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: Center(
              child: ElevatedButton(
                child: Text("Add new Data"),
                onPressed: () async {
                  FinenessTestModel? data = await _openDataEntryDialog();
                  if (data != null) {
                    setState(() {
                      isDataAdded = true;
                      finenessDataList.add(data);
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

  Future<FinenessTestModel?> _openDataEntryDialog() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Add new Data"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Wt of Cement Sample",
                      ),
                      SizedBox(
                        width: 60.0,
                        child: TextField(
                          controller: _wtOfCementInputController,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Wt of Residue Sample",
                      ),
                      SizedBox(
                        width: 60.0,
                        child: TextField(
                          controller: _wtOfResidueInputController,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  Text(errorMessage.toString(),
                      style: TextStyle(color: Colors.red))
                ],
              ),
              actions: [
                TextButton(
                    child: Text("ok"),
                    onPressed: () {
                      FinenessTestModel? finenessData;
                      try {
                        finenessData = FinenessTestModel(
                            wtOfCementSample: double.tryParse(
                                _wtOfCementInputController.text)!,
                            wtOfResidueSample: double.tryParse(
                                _wtOfResidueInputController.text)!);
                      } catch (e) {
                        print(e);
                      }
                      if (finenessData == null) {
                        setState(() {
                          errorMessage = "Please input all the values";
                        });
                      } else {
                        setState(() {
                          _wtOfCementInputController.clear();
                          _wtOfResidueInputController.clear();
                          errorMessage = "";
                        });
                        Navigator.pop(context, finenessData);
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
    return Flexible(
        flex: 5,
        fit: FlexFit.tight,
        child: SingleChildScrollView(
            child: Row(
          children: [
            Column(
              children: _buildCells(
                [
                  Text("Determination Number"),
                  Text("A Wt of cement Sample"),
                  Text("B Wt of residue Sample")
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildColumns(finenessDataList, context),
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

  List<Widget> _buildColumns(List<FinenessTestModel> data, context) {
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
                  Text(data[index].wtOfCementSample.toString()),
                  Text(data[index].wtOfResidueSample.toString()),
                ]),
              ),
            ));
  }
}
