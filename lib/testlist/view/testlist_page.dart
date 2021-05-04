import 'package:site_monitoring/cementTests/cementsetting/entryPage/view/cementSettingEntryPage.dart';
import 'package:site_monitoring/cementTests/cementsetting/pdfpage/pdf_viewer.dart';
import 'package:site_monitoring/cementTests/compressiveStrength/entryPage/compressiveEntryPage.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:site_monitoring/cementTests/consistencyTest/pdfPage/pdfViewer.dart';

class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Civil LAB"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            elevation: 2.0,
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(),
              child: Text(
                "Tests",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Container(
              // child: Flexible(
              //   child: GridView.count(
              //     primary: false,
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 10.0,
              //     children: [
              //       TestsContainer(
              //         onPress: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => CementTests()));
              //         },
              //       ),
              //       TestsContainer(),
              //       TestsContainer(),
              //       TestsContainer(),
              //       TestsContainer(),
              //       TestsContainer(),
              //       TestsContainer(),
              //     ],
              //   ),
              // ),
              child: Flexible(
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text("Cement Tests",
                      style: TextStyle(color: Colors.white)),
                  children: [
                    TestsContainer(
                      testName: "Cement Setting",
                      onPress: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CementSettingEntry(),
                          )),
                    ),
                    TestsContainer(
                        testName: "Compressive Strength",
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompressiveStrengthEntry(),
                            ))),
                    TestsContainer(
                        testName: "Consistency Test",
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompressiveStrengthEntry(),
                            ))),
                    TestsContainer(
                        testName: "Fineness Test",
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompressiveStrengthEntry(),
                            )))
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "Coarse Aggregate Test",
                    style: TextStyle(color: Colors.white),
                  ),
                  children: [
                    TestsContainer(testName: "LAAtest"),
                    TestsContainer(testName: "Sieve Analysis Graded"),
                    TestsContainer(testName: "Sieve Analysis singlesized")
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Share.share("hello This is mic Text");
        },
        child: Icon(Icons.share),
      ),
    );
  }
}

class TestsContainer extends StatelessWidget {
  final Function onPress;
  final String testName;
  TestsContainer({this.onPress, this.testName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color(0xFF111328),
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        child: Text(
          testName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
