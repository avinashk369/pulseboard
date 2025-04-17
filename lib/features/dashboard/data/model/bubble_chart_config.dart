class BubbleChartConfig {
  final bool sizeByHumidity;
  final bool sizeByPressure;
  final bool colorByAnomoly;

  const BubbleChartConfig({
    this.sizeByHumidity = true,
    this.sizeByPressure = false,
    this.colorByAnomoly = true,
  });

  BubbleChartConfig copyWith({
    bool? sizeByHumidity,
    bool? sizeByPressure,
    bool? colorByAnomoly,
  }) {
    return BubbleChartConfig(
      sizeByHumidity: sizeByHumidity ?? this.sizeByHumidity,
      sizeByPressure: sizeByPressure ?? this.sizeByPressure,
      colorByAnomoly: colorByAnomoly ?? this.colorByAnomoly,
    );
  }
}
