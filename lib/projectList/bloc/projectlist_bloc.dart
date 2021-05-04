import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:site_monitoring/projectList/models/project.dart';

part 'projectlist_event.dart';
part 'projectlist_state.dart';

class ProjectlistBloc extends Bloc<ProjectlistEvent, ProjectlistState> {
  ProjectlistBloc() : super(ProjectlistLoadInProgress());

  final storage = FlutterSecureStorage();

  @override
  Stream<ProjectlistState> mapEventToState(
    ProjectlistEvent event,
  ) async* {
    if (event is FetchProject) {
      try {
        var authToken = await storage.read(key: 'AuthKey');

        var res = await http.get(
            'https://dammiapi.herokuapp.com/api/tests/my_projects_list/',
            headers: {'Authorization': 'Token $authToken'});

        if (res.statusCode == 200) {
          var projects = jsonDecode(res.body);
          print(projects);
          List<ProjectData> updatedProjects = projects
              .map<ProjectData>((project) => ProjectData.fromJson(project))
              .toList();
          print(updatedProjects);
          yield ProjectlistSuccess(updatedProjects);
        }
      } catch (e) {
        print(e);
        yield ProjectlistFailure();
      }
    } else if (event is ProjectAdded) {
      if (state is ProjectlistSuccess) {
        // yield ProjectlistLoadInProgress();
        bool successFullyCreated = await _saveProjects(event.project);
        if (successFullyCreated) {
          final List<ProjectData> updatedProjects =
              List.from((state as ProjectlistSuccess).projects)
                ..add(event.project);
          yield ProjectlistSuccess(updatedProjects);
        } else {
          yield ProjectlistFailure();
        }
      }
    } else if (event is ProjectDeleted) {
      if (state is ProjectlistSuccess) {
        final updatedprojects = (state as ProjectlistSuccess)
            .projects
            .where(
                (project) => project.projectName != event.project.projectName)
            .toList();
        yield ProjectlistSuccess(updatedprojects);
        _delProject();
      }
    }
  }

  Future<bool> _saveProjects(ProjectData project) async {
    Map<String, dynamic> map = {
      "project_name": project.projectName,
      "lab_name": project.labName,
      "contractor": "fuckweewayou",
      "consultant": "iknlkdfs",
      "contract_no": 23
    };
    try {
      final String authToken = await storage.read(key: 'AuthKey');
      var res = await http.post(
          'https://dammiapi.herokuapp.com/api/tests/create_project/',
          body: jsonEncode(map),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token $authToken'
          });
      var data = jsonDecode(res.body);

      print(data);
      return true;
    } catch (_) {
      return false;
    }
  }

  void _delProject() {}
}
