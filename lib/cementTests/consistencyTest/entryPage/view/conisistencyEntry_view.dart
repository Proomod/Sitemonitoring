import 'package:flutter/material.dart';
import 'package:site_monitoring/cementTests/consistencyTest/utilities/utilities.dart';

class ConsistencyEntryCement extends StatefulWidget {
  const ConsistencyEntryCement({Key? key}) : super(key: key);

  @override
  _ConsistencyEntryCementState createState() => _ConsistencyEntryCementState();
}

class _ConsistencyEntryCementState extends State<ConsistencyEntryCement> {
  TextEditingController _percentageInputController = TextEditingController();
  TextEditingController _wtOfCementInputController = TextEditingController();
  TextEditingController _wtOfWaterInputController = TextEditingController();
  TextEditingController _initialReadingInputController =
      TextEditingController();
  TextEditingController _finalReadingnputController = TextEditingController();
  bool isDataAdded = false;
  String? errorMessage;
  List<ConsistencyCementModel> cementConsistencyList = [];

  @override
  void dispose() {
    _percentageInputController.dispose();
    _wtOfCementInputController.dispose();
    _wtOfWaterInputController.dispose();
    _initialReadingInputController.dispose();
    _finalReadingnputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consistency Test of Cement"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: Container(
                child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async {
                  var inputData = await _createDataEntryDialog(context);
                  if (inputData != null) {
                    setState(() {
                      isDataAdded = true;
                      cementConsistencyList.add(inputData);
                    });
                  }
                },
                child: Text("Add Data"),
              ),
            )),
          ),
          isDataAdded ? _createOrAppendDataTable() : SizedBox.shrink(),
          if (isDataAdded)
            ElevatedButton(
              onPressed: () {},
              child: Text("Process Data"),
            )
          else
            SizedBox.shrink()
        ],
      ),
    );
  }

  Future<ConsistencyCementModel?> _createDataEntryDialog(
      BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
              builder: (BuildContext context, setState) => AlertDialog(
                  title: Text("Add new Data"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text("Percentage Of water Added"),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _percentageInputController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "In gms",
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("(A) Wt. of cement"),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
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
                          Text("(B) Wt. of water Added"),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextField(
                              controller: _wtOfWaterInputController,
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(" (C1) Initial reading of indicator"),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextField(
                              controller: _initialReadingInputController,
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text("(C2) Final reading Of Indicator"),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextField(
                              controller: _finalReadingnputController,
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                      errorMessage != null
                          ? Text(errorMessage!,
                              style: TextStyle(color: Colors.red))
                          : SizedBox.shrink()
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text("Confirm",
                          style: TextStyle(color: Colors.green)),
                      onPressed: () {
                        ConsistencyCementModel? cementConsistency;
                        try {
                          cementConsistency = ConsistencyCementModel(
                            percentageOfWater: double.tryParse(
                                _percentageInputController.text)!,
                            wtOfCement: double.tryParse(
                                _wtOfCementInputController.text)!,
                            wtOfWaterAdded: double.tryParse(
                                _wtOfWaterInputController.text)!,
                            initialReadingOfIndicator: double.tryParse(
                                _initialReadingInputController.text)!,
                            finalReadingOfIndicator: double.tryParse(
                                _finalReadingnputController.text)!,
                          );
                        } catch (e) {}

                        if (cementConsistency == null) {
                          setState(() {
                            errorMessage = "Please Update all the values";
                          });
                        } else
                          Navigator.pop(context, cementConsistency);
                      },
                    ),
                    TextButton(
                        child:
                            Text("Cancel", style: TextStyle(color: Colors.red)),
                        onPressed: () => Navigator.pop(context)),
                  ]),
            ));
  }

  Widget _createOrAppendDataTable() {
    return Flexible(
      flex: 5,
      fit: FlexFit.tight,
      child: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildCells([
                _Header(topic: "Determination Number"),
                _Header(topic: "Percentage of water Added"),
                _Header(topic: "Wt. of cement"),
                _Header(topic: "Initial Reading"),
                _Header(topic: "Final Reading"),
              ]),
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildColumns(cementConsistencyList, context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
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

List<Widget> _buildColumns(List<ConsistencyCementModel> data, context) {
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
                Text(data[index].percentageOfWater.toString()),
                Text(data[index].wtOfCement.toString()),
                Text(data[index].wtOfWaterAdded.toString()),
                Text(data[index].initialReadingOfIndicator.toString()),
                Text(data[index].finalReadingOfIndicator.toString()),
              ]),
            ),
          ));
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.topic,
  }) : super(key: key);
  final String topic;
  @override
  Widget build(BuildContext context) {
    return Text(topic,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0));
  }
}
