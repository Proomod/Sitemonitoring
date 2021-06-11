import 'package:site_monitoring/testlist/view/testlist_page.dart';
import 'package:flutter/material.dart';

class ProjectNameButton extends StatelessWidget {
  final String? projectName;

  ProjectNameButton({this.projectName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // backgroundColor: Colors.white,
              title: Text('Add tests?'),
              actions: [
                FlatButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TestList()));
                  },
                  child: Text("Proceed"),
                ),
                FlatButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Go back"),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(7.0),
        ),
        // constraints: BoxConstraints(
        //   minWidth: 150.0,
        //   maxHeight: 150.0,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              projectName!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
