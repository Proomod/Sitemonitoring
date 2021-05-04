import 'package:flutter/material.dart';
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
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _settingTimes,
        builder: (context, snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              children.add(Text("SUCcessfully completed"));
            }
          } else if (snapshot.hasError) {
            children = [Text('Some error occured')];
          }
          return Column(
            children: children,
          );
        },
      ),
    );
  }
}
