part of 'projectlist_bloc.dart';

abstract class ProjectlistEvent extends Equatable {
  const ProjectlistEvent();

  @override
  List<Object> get props => [];
}

class ProjectAdded extends ProjectlistEvent {
  final ProjectData project;
  const ProjectAdded(this.project);

  @override
  List<Object> get props => [project];
}

class ProjectDeleted extends ProjectlistEvent {
  final ProjectData project;
  const ProjectDeleted(this.project);

  @override
  List<Object> get props => [project];
}

class FetchProject extends ProjectlistEvent {}
