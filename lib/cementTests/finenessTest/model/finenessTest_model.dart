class FinenessTestModel {
  const FinenessTestModel({
    required this.wtOfCementSample,
    required this.wtOfResidueSample,
  });

  FinenessTestModel.fromJson(Map<String, dynamic> json)
      : this.wtOfCementSample = json['wtOfCementSample'],
        this.wtOfResidueSample = json['wtOfResidueSample'];

  final double wtOfCementSample;
  final double wtOfResidueSample;

  Map<String, dynamic> toJson() => {
        'wtOfCementSample': this.wtOfCementSample,
        'wtOfResidueSample': this.wtOfResidueSample
      };
}
