import 'package:flutter/material.dart';

class TestButton extends StatelessWidget {
  final String? testTitle;
  final Function? action;
  const TestButton({this.testTitle, this.action});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      onPressed: action as void Function()?,
      // () {
      //   action();
      //   // showDialog(
      //   //     context: context,
      //   //     builder: (context) {
      //   //       return AlertDialog(
      //   //         title: Text('Hello'),
      //   //         content: SingleChildScrollView(
      //   //           child: ListBody(
      //   //             children: <Widget>[
      //   //               Text('Go for a test?'),
      //   //             ],
      //   //           ),
      //   //         ),
      //   //         actions: [
      //   //           FlatButton(
      //   //             child: Text('GO'),
      //   //             onPressed: () {
      //   //               // Navigator.of(context).push(MaterialPageRoute(
      //   //               //     builder: (context) => CementTestEntry()));
      //   //             },
      //   //           ),
      //   //         ],
      //   //       );
      //   //     });
      // },,
      child: Text(
        this.testTitle!,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
