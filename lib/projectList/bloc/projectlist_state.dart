part of 'projectlist_bloc.dart';

abstract class ProjectlistState extends Equatable {
  const ProjectlistState();

  @override
  List<Object> get props => [];
}

class ProjectlistLoadInProgress extends ProjectlistState {}

class ProjectlistSuccess extends ProjectlistState {
  final List<ProjectData> projects;

  const ProjectlistSuccess([this.projects = const []]);

  @override
  List<Object> get props => [projects];
}

class ProjectlistFailure extends ProjectlistState {}
