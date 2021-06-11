import 'package:site_monitoring/conf.dart';
import 'package:flutter/material.dart';

class ReportDataEntry extends StatefulWidget {
  @override
  _ReportDataEntryState createState() => _ReportDataEntryState();
}

class _ReportDataEntryState extends State<ReportDataEntry> {
  String? sandWeight;
  String? cementWeight;
  String? normalConsistency;
  String? mixProportion;

  String? sampleLocation;
  String? waterWeight;
  // String cube7;
  // String cube8;

  // String cube9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compressive Strength'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
            ),
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 50.0,
            ),
            child: Text(
              "Cement Test",
            ),
          ),
          Flexible(
            child: GridView.count(
              childAspectRatio: 5 / 2,
              crossAxisCount: 2,
              children: [
                InputField(
                  label: "Cement wt.",
                  getCubeValue: (value) {
                    cementWeight = value;
                    print(cementWeight);
                  },
                ),
                InputField(
                  label: "Sand wt.",
                  getCubeValue: (value) {
                    setState(() {
                      sandWeight = value;
                    });
                  },
                ),
                InputField(
                  label: "Water",
                  getCubeValue: (value) {
                    setState(() {
                      waterWeight = value;
                    });
                  },
                ),
                InputField(
                  label: "SampleLocation",
                  getCubeValue: (value) {
                    setState(() {
                      sampleLocation = value;
                    });
                  },
                ),
                InputField(
                  label: "mixProportion",
                  getCubeValue: (value) {
                    setState(() {
                      mixProportion = value;
                    });
                  },
                ),
                InputField(
                  label: "NormalConsistency",
                  getCubeValue: (value) {
                    setState(() {
                      normalConsistency = value;
                    });
                  },
                ),
                // InputField(
                //   label: "Cube7",
                //   getCubeValue: (value) {
                //     setState(() {
                //       cube7 = value;
                //     });
                //   },
                // ),
                // InputField(
                //   label: "Cube8",
                //   getCubeValue: (value) {
                //     setState(() {
                //       cube8 = value;
                //     });
                //   },
                // ),
                // InputField(
                //   label: "Cube9",
                //   getCubeValue: (value) {
                //     setState(() {
                //       cube9 = value;
                //     });
                //   },
                // )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: MaterialButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              padding: new EdgeInsets.symmetric(vertical: 20.0),
              color: Colors.purple,
              elevation: 2.0,
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.lightBlue,
                        ),
                      ],
                    );
                  },
                );
                // try {
                //   var response = await http.post(
                //       'https://civilbackend.herokuapp.com/cement-create/',
                //       body: {
                //         "test_title": "arbixyo ho",
                //         "cube_1_w": 250,
                //         "cube_2_w": 250,
                //         "cube_3_w": 216,
                //         "cube_4_w": 123,
                //         "cube_5_w": 345,
                //         "cube_6_w": 123214,
                //         "cube_7_w": 254,
                //         "cube_8_w": 326,
                //         "cube_9_w": 154
                //       });
                //   print(response.body);
                // } catch (e) {
                //   print(e);
                // }

                Navigator.pushNamed(context, '/reportPage',
                    arguments: ExtraDataForReport(
                        sandWeight: sandWeight,
                        cementWeight: cementWeight,
                        normalConsistency: normalConsistency,
                        mixProportion: mixProportion,
                        sampleLocation: sampleLocation,
                        waterWeight: waterWeight));
              },
              child: Text(
                "Calculate",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ExtraDataForReport {
  final String? sandWeight;
  final String? waterWeight;
  final String? cementWeight;
  final String? normalConsistency;
  final String? mixProportion;
  final String? sampleLocation;

  ExtraDataForReport(
      {this.sandWeight,
      this.cementWeight,
      this.mixProportion,
      this.normalConsistency,
      this.sampleLocation,
      this.waterWeight});
}

class InputField extends StatefulWidget {
  final String? label;
  final Function? getCubeValue;
  InputField({this.label, this.getCubeValue});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {});
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        controller: _textController,
        // keyboardType: TextInputType.number,
        autofocus: true,
        onSubmitted: this.widget.getCubeValue as void Function(String)?,
        textInputAction: TextInputAction.next,
        decoration: kinputFieldDecoration.copyWith(
          labelText: this.widget.label,
        ),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
