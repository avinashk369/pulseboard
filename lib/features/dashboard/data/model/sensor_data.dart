import 'package:freezed_annotation/freezed_annotation.dart';
part 'sensor_data.freezed.dart';
part 'sensor_data.g.dart';

@freezed
abstract class SensorData with _$SensorData {
  const factory SensorData({
    String? id,
    String? name,
    String? location,
    double? temperature,
    double? humidity,
    double? pressure,
    double? anomalyLevel,
    DateTime? timestamp,
    @Default(false) bool? isOnline,
  }) = _SensorData;

  factory SensorData.fromJson(Map<String, Object?> json) =>
      _$SensorDataFromJson(json);
}
