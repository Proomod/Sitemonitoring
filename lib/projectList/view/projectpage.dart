import 'package:site_monitoring/projectList/bloc/projectlist_bloc.dart';
import 'package:site_monitoring/projectList/view/components/ProjectNameButton/projectNameButton.dart';
import 'package:site_monitoring/projectList/view/components/newProjectButton/newProjectButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Align(
          child: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        title: Hero(
          tag: 'listPage1',
          child: Text(
            'My Projects',
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ProjectlistBloc(),
        child: ProjectPageContent(),
      ),
    );
  }
}

class ProjectPageContent extends StatefulWidget {
  @override
  _ProjectPageContentState createState() => _ProjectPageContentState();
}

class _ProjectPageContentState extends State<ProjectPageContent> {
  @override
  void initState() {
    _loadProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectlistBloc, ProjectlistState>(
      listener: (context, state) {},
      child: ProjectListGrid(),
    );
  }

  void _loadProjects() async {
    context.read<ProjectlistBloc>().add(FetchProject());
  }
}

class ProjectListGrid extends StatelessWidget {
  const ProjectListGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectlistBloc, ProjectlistState>(
      builder: (context, state) {
        if (state is ProjectlistLoadInProgress) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.white12,
          ));
        }
        if (state is ProjectlistSuccess) {
          List<Widget> gridChildren = [NewProject()];
          List<Widget> projectList = state.projects!
              .map((project) =>
                  ProjectNameButton(projectName: project.projectName))
              .toList();
          gridChildren = [...projectList, gridChildren.removeLast()];
          return GridView.builder(
              itemCount: gridChildren.length,
              primary: false,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10.0),
                  child: gridChildren[index],
                );
              });
        }

        if (state is ProjectlistFailure) {
          return Center(
            child: Text("Couldn't load please try again"),
          );
        }
        return Text("Something went wrong");
      },
    );
  }
}
