import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:site_monitoring/cementTests/compressiveStrength/utilities/compressiveTest/CompressiveStrength.dart';

class CompressiveStrengthProcessing {
  CompressiveStrengthProcessing({this.cubes});
  double cube1_w;

  double cube2_w;
  double cube3_w;
  double cube4_w;
  double cube5_w;
  double cube6_w;
  double cube7_w;
  double cube8_w;
  double cube9_w;
  double cube1_l;
  double cube2_l;
  double cube3_l;
  double cube4_l;
  double cube5_l;
  double cube6_l;
  double cube7_l;
  double cube8_l;
  double cube9_l;

  List<CompressiveStrength> cubes = [];

  _mapData() {
    cubes.forEach((cube) {
      if (cube.cubeNo == 1) {
        cube1_w = cube.cubeWeight;
        cube1_l = cube.cubeLoad;
      }
      if (cube.cubeNo == 2) {
        cube2_w = cube.cubeWeight;
        cube2_l = cube.cubeLoad;
      }
      if (cube.cubeNo == 3) {
        cube3_w = cube.cubeWeight;
        cube3_l = cube.cubeLoad;
      }
      if (cube.cubeNo == 4) {
        cube4_w = cube.cubeWeight;
        cube4_l = cube.cubeLoad;
      }
      if (cube.cubeNo == 5) {
        cube5_w = cube.cubeWeight;
        cube5_l = cube.cubeLoad;
      }
      if (cube.cubeNo == 6) {
        cube6_w = cube.cubeWeight;
        cube6_l = cube.cubeLoad;
      }
      if (cube.cubeNo == 7) {
        cube7_w = cube.cubeWeight;
        cube7_l = cube.cubeLoad;
      }
      if (cube.cubeNo == 8) {
        cube8_w = cube.cubeWeight;
        cube8_l = cube.cubeLoad;
      }
      if (cube.cubeNo == 9) {
        cube9_w = cube.cubeWeight;
        cube9_l = cube.cubeLoad;
      }
    });
  }

  sendCompressiveData() async {
    _mapData();
    try {
      var res = await http.post(
          'https://dammiapi.herokuapp.com/api/tests/cementCreateComp/',
          body: {
            "cube_weight_1": "$cube1_w",
            "cube_weight_2": "$cube2_w",
            "cube_weight_3": "$cube3_w",
            "cube_weight_4": "$cube4_w",
            "cube_weight_5": "$cube5_w",
            "cube_weight_6": "$cube6_w",
            "cube_weight_7": "$cube7_w",
            "cube_weight_8": "$cube8_w",
            "cube_weight_9": "$cube9_w",
            "cube_load_1": "$cube1_l",
            "cube_load_2": "$cube2_l",
            "cube_load_3": "$cube3_l",
            "cube_load_4": "$cube4_l",
            "cube_load_5": "$cube5_l",
            "cube_load_6": "$cube6_l",
            "cube_load_7": "$cube7_l",
            "cube_load_8": "$cube8_l",
            "cube_load_9": "$cube9_l"
          },
          headers: {
            "Authorization": "Token 5eda0122c6faf13dcf4a0c890a0554dd96a8c7b9",
          });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data['pk'];
      }
      print(data);
    } catch (e) {
      print(e);
    }
  }
}
