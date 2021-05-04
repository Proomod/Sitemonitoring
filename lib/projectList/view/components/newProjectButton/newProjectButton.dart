import 'package:site_monitoring/conf.dart';
import 'package:site_monitoring/projectList/bloc/projectlist_bloc.dart';
import 'package:site_monitoring/projectList/models/project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewProject extends StatelessWidget {
  const NewProject({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectlistBloc, ProjectlistState>(
        builder: (context, state) {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext c) {
              TextEditingController _projectNameController =
                  TextEditingController();
              TextEditingController _labNameController =
                  TextEditingController();
              TextEditingController _contractNoController =
                  TextEditingController();
              Widget contentDialogBox = Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        controller: _projectNameController,
                        decoration: kinputFieldDecoration.copyWith(
                          labelText: "*Project Name",
                          labelStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        controller: _labNameController,
                        decoration: kinputFieldDecoration.copyWith(
                          labelText: "Lab Name",
                          labelStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        controller: _contractNoController,
                        decoration: kinputFieldDecoration.copyWith(
                          labelText: "Contract No",
                          labelStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // TextFormField(
                      //   decoration: kinputFieldDecoration.copyWith(
                      //     labelText: "Consultant",
                      //     labelStyle: TextStyle(
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // TextFormField(
                      //   decoration: kinputFieldDecoration.copyWith(
                      //     labelText: "Contractor",
                      //     labelStyle: TextStyle(
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                    ],
                  ),
                ),
              );
              return StatefulBuilder(builder: (c, setState) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: AlertDialog(
                      title: Text(
                        'New Project',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      content: contentDialogBox,
                      actions: [
                        FlatButton(
                          color: Colors.blue,
                          onPressed: () async {
                            setState(() {
                              contentDialogBox = Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              );
                            });
                            // dynamic resultStatus =
                            //     await Provider.of<ProjectList>(context,
                            //             listen: false)
                            //         .addNewProjectData(
                            //             _projectNameController.text,
                            //             _labNameController.text);
                            ProjectData project = ProjectData(
                                projectName: _projectNameController.text,
                                labName: _labNameController.text);

                            context
                                .read<ProjectlistBloc>()
                                .add(ProjectAdded(project));
                            // await Provider.of<ProjectList>(context, listen: false)
                            //     .getProjectList();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => TestList()));
                            if (state is ProjectlistFailure) {
                              setState(() {
                                contentDialogBox = Text(
                                  'Can\'t create project',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                );
                              });
                            }
                            if (state is ProjectlistSuccess) {
                              Navigator.pop(c);
                            }
                          },
                          child: Text("Create Project"),
                        ),
                        FlatButton(
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(c).pop();
                          },
                          child: Text("Cancel"),
                        )
                      ]),
                );
              });
            },
          );
          // Provider.of<ProjectList>(context, listen: false)
          //     .addNewProject(Text("hello World"));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.white,
          ),
          // constraints: BoxConstraints(
          //   minWidth: 150.0,
          //   maxHeight: 150.0,
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.black,
                size: 50.0,
              ),
              Text("New project"),
            ],
          ),
        ),
      );
    });
  }
}
