import 'package:flutter/material.dart';
import 'package:site_monitoring/fineAggregateTests/fineUnitWtTest/model/fineUnitWtTestModel.dart';

class FineUnitWeightTestEntry extends StatefulWidget {
  const FineUnitWeightTestEntry({Key? key}) : super(key: key);

  @override
  _FineUnitWeightTestEntryState createState() =>
      _FineUnitWeightTestEntryState();
}

class _FineUnitWeightTestEntryState extends State<FineUnitWeightTestEntry> {
//ruw stands for rodded unit weight test values
//luw stands for loose unit weight tests values

  TextEditingController _ruwWtOfMouldInputController = TextEditingController();
  TextEditingController _ruwWtOfMouldAndSampleInputController =
      TextEditingController();
  TextEditingController _ruwVolOfMouldInputController = TextEditingController();
  TextEditingController _luwWtOfMouldInputController = TextEditingController();
  TextEditingController _luwWtOfMouldAndSampleInputController =
      TextEditingController();
  TextEditingController _luwVolOfMouldInputController = TextEditingController();
  List<FineUnitWtTestModel> fineUnitWtTestList = [];
  bool isDataAdded = false;
  String? errorMessage;

  @override
  void dispose() {
    _ruwVolOfMouldInputController.dispose();
    _ruwWtOfMouldAndSampleInputController.dispose();
    _ruwWtOfMouldInputController.dispose();
    _luwWtOfMouldAndSampleInputController.dispose();
    _luwWtOfMouldInputController.dispose();
    _luwVolOfMouldInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: ElevatedButton(
              child: Text("Add Data"),
              onPressed: () async {
                FineUnitWtTestModel? inputData = await _showEntryDialogBox();
                if (inputData != null) {
                  fineUnitWtTestList.add(inputData);
                }
              }),
        ),
        isDataAdded ? _addDataTableToView() : SizedBox.shrink()
      ],
    ));
  }

  Future<FineUnitWtTestModel?> _showEntryDialogBox() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Add new Data"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DataEntryTextField(
                    name: "Wt. of mould",
                    controller: _ruwWtOfMouldInputController,
                  ),
                  _DataEntryTextField(
                    controller: _ruwWtOfMouldAndSampleInputController,
                    name: "Wt. of mould + Sample",
                  ),
                  _DataEntryTextField(
                      controller: _ruwVolOfMouldInputController,
                      name: "Vol. of mould W2"),
                  _DataEntryTextField(
                    controller: _luwWtOfMouldInputController,
                    name: 'Wt. of mould',
                  ),
                  _DataEntryTextField(
                    controller: _luwWtOfMouldAndSampleInputController,
                    name: 'Wt. of mould + sample',
                  ),
                  _DataEntryTextField(
                    controller: _luwVolOfMouldInputController,
                    name: 'Vol. of mould,W2',
                  )
                ],
              ),
              actions: [
                TextButton(
                    child: Text("ok"),
                    onPressed: () {
                      FineUnitWtTestModel? unitWtTestData;
                      try {
                        unitWtTestData = FineUnitWtTestModel(
                            luwVolOfMould: double.tryParse(
                                _luwVolOfMouldInputController.text)!,
                            luwWtOfMouldAndSample: double.tryParse(
                                _luwWtOfMouldAndSampleInputController.text)!,
                            luwWtOfmold: double.tryParse(
                                _luwWtOfMouldInputController.text)!,
                            ruwVolOfMould: double.tryParse(
                                _ruwVolOfMouldInputController.text)!,
                            ruwWtOfmold: double.tryParse(
                                _ruwWtOfMouldInputController.text)!,
                            ruwWtOfMouldAndSample: double.tryParse(
                                _ruwWtOfMouldAndSampleInputController.text)!);
                      } catch (e) {
                        print(e);
                      }
                      if (unitWtTestData == null) {
                        setState(() {
                          errorMessage = "Please input all the values";
                        });
                      } else {
                        setState(() {
                          _ruwVolOfMouldInputController.clear();
                          _ruwWtOfMouldInputController.clear();
                          _ruwWtOfMouldAndSampleInputController.clear();
                          _luwVolOfMouldInputController.clear();
                          _luwWtOfMouldInputController.clear();
                          _luwWtOfMouldAndSampleInputController.clear();
                          errorMessage = "";
                        });
                        Navigator.pop(context, unitWtTestData);
                      }
                    }),
                TextButton(
                  child: Text("cancel", style: TextStyle(color: Colors.red)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  Widget _addDataTableToView() {
    return Text("Something as a placeholder");
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
