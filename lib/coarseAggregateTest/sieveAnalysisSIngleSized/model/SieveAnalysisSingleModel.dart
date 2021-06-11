class SieveAnalyisisSingleModel {
  const SieveAnalyisisSingleModel(
      {required this.sieveSize, required this.wtRetained});

  static List<String> sieveSizeValues = [
    "40.0",
    "20.0",
    "10.0",
    "4.750",
    "Pan"
  ];

  final String sieveSize;
  final double wtRetained;

  // todo need to implement json conversion functions

  String operator [](String key) {
    return key;
  }
}

main(List<String> args) {
  SieveAnalyisisSingleModel model = SieveAnalyisisSingleModel(
    sieveSize: '',
    wtRetained: 12.0,
  );
  print(model["Hey jude don't make it bad"]);
}
