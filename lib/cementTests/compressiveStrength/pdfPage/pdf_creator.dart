// import 'package:flutter/material.dart';
// import 'package:site_monitoring_System/screens/pdf_creation/pdf_content.dart';
// import 'package:site_monitoring_System/screens/pdf_creation/pdf_viewer.dart';

// class PdfCreator extends StatefulWidget {
//   @override
//   _PdfCreatorState createState() => _PdfCreatorState();
// }

// class _PdfCreatorState extends State<PdfCreator> {
//   String filePath;
//   @override
//   void initState() {
//     getfileName();

//     super.initState();
//   }

//   getfileName() async {
//     filePath = await pdfContent();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FlatButton(
//           onPressed: () async {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PdfViewer(path: filePath),
//               ),
//             );
//           },
//           child: Text('click me'),
//         ),
//       ),
//     );
//   }
// }
