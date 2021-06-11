class ConsistencyCementModel {
  ConsistencyCementModel(
      {required this.percentageOfWater,
      required this.wtOfCement,
      required this.wtOfWaterAdded,
      required this.initialReadingOfIndicator,
      required this.finalReadingOfIndicator});

  final double percentageOfWater;
  final double wtOfCement;
  final double wtOfWaterAdded;
  final double initialReadingOfIndicator;
  final double finalReadingOfIndicator;

  addToDataBase() async {}
}
