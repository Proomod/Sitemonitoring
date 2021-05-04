import 'package:equatable/equatable.dart';

class ProjectData extends Equatable {
  final String labName;
  final String projectName;
  final int contractNo;
  final String consultant;
  final String contractor;

  ProjectData(
      {this.labName,
      this.projectName,
      this.contractNo,
      this.consultant,
      this.contractor});

  // addData() {}

  ProjectData copywith(String labName, String projectName, String contractNo,
      String consultant, String contractor) {
    return ProjectData(
        labName: labName ?? this.labName,
        projectName: projectName ?? this.projectName,
        contractNo: contractNo ?? this.contractNo,
        consultant: consultant ?? this.consultant,
        contractor: contractor ?? this.contractor);
  }

  @override
  List<Object> get props =>
      [labName, projectName, contractNo, consultant, contractor];

  static ProjectData fromJson(project) {
    return ProjectData(
        projectName: project['project_name'],
        labName: project['lab_name'] ?? '',
        consultant: project['consultant'] ?? '',
        contractor: project['contractor'] ?? '',
        contractNo: project['contract_no'] ?? '');
  }
}
