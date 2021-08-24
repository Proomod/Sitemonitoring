class SpecificGravityModel {
  final double wtOfPychnometer;
  final double wtOfPychnometerAndDrySample;
  final double wtOfPychnometerSampleAndWater;
  final double wtOfPychnometerAndWater;
// !all unit must be declared in grams value

  SpecificGravityModel(
    this.wtOfPychnometer,
    this.wtOfPychnometerAndDrySample,
    this.wtOfPychnometerSampleAndWater,
    this.wtOfPychnometerAndWater,
  );
}
