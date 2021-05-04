import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class SpiritLevel extends StatefulWidget {
  @override
  _SpiritLevelState createState() => _SpiritLevelState();
}

class _SpiritLevelState extends State<SpiritLevel>
    with TickerProviderStateMixin {
  StreamSubscription<GyroscopeEvent> _streamSubscription;
  AnimationController _controller;
  GyroscopeEvent gyroData;

  @override
  void initState() {
    _controller = AnimationController();
    _streamSubscription = gyroscopeEvents.listen((event) {
      setState(() {
        gyroData = event;
      });
    });

    // print(mapGyroValue());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamSubscription.cancel();
    super.dispose();
  }

  mapGyroValue() {
    var xScreen = MediaQuery.of(context).size.width;
    var yScreen = MediaQuery.of(context).size.height;
    var screenX;
    var screenY;

    setState(() {
      screenX = ((gyroData.x * 57.295779513 * 10 + 180) * (xScreen / 2) / 360);
      screenY = ((gyroData.y * 57.295779513 * 10 + 180) * (yScreen / 2) / 360);
    });
    return {'screenX': screenX, 'screenY': screenY};
  }

  @override
  Widget build(BuildContext context) {
    // double screenX=mapGyroValue()['']
    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            onTap: () {
              print(MediaQuery.of(context).size);
            },
            child: CustomPaint(
              painter: OpenPainter(200, 200, Colors.green),
            ),
          ),
          CustomPaint(
            painter: OpenPainter(
                200, MediaQuery.of(context).size.height / 2, Colors.red),
          ),
          Align(
            child: Text(
              'X-axis:${(gyroData.x * 57.295779513 * 10).toStringAsFixed(1)}°',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.05),
            child: Text(
              'Y-axis:${(gyroData.y * 57.295779513 * 10).toStringAsFixed(1)}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          FlatButton(
              onPressed: () {
                print(MediaQuery.of(context).size);
                print(mapGyroValue());
              },
              child: Text('Clickme'))
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  double positonX;
  double positonY;
  Color color;
  OpenPainter(this.positonX, this.positonY, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(positonX, positonY), 100, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
