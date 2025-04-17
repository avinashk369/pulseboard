import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';
import 'package:pulseboard/features/dashboard/domain/repositories/sensor_repository.dart';
import 'package:uuid/uuid.dart';

class SensorRepositoryImpl implements SensorRepository {
  final List<SensorData> _mockSensors = [];

  SensorRepositoryImpl() {
    _initializeMockData();
  }

  void _initializeMockData() {
    final locations = ['Line A', 'Line B', 'Line C'];
    final uuid = Uuid();

    for (var i = 0; i < 12; i++) {
      final location = locations[i % locations.length];
      final hour = 8 + (i % 10);
      final timestamp = DateTime.now().copyWith(
        hour: hour,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

      _mockSensors.add(
        SensorData(
          id: uuid.v4(),
          name: 'Sensor ${i + 1}',
          location: location,
          temperature: 22.0 + (i * 2.5),
          humidity: 45.0 + (i * 1.5),
          pressure: 1013.0 - 10 + (i * 2),
          anomalyLevel: i % 3 == 0
              ? 0.0
              : i % 3 == 1
                  ? 25.0
                  : 75.0,
          isOnline: i % 5 != 0, // Every 5th sensor is offline
          timestamp: timestamp,
        ),
      );
    }
  }

  @override
  Future<List<SensorData>> getSensors() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate network delay
    return _mockSensors;
  }

  @override
  Future<SensorData> getSensorDetails(String sensorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockSensors.firstWhere((sensor) => sensor.id == sensorId);
  }

  @override
  Future<void> updateSensorStatus(String sensorId, bool isOnline) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _mockSensors.indexWhere((sensor) => sensor.id == sensorId);
    if (index != -1) {
      _mockSensors[index] = _mockSensors[index].copyWith(isOnline: isOnline);
    }
  }

  @override
  Future<void> simulateAnomaly(String sensorId, double anomalyLevel) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _mockSensors.indexWhere((sensor) => sensor.id == sensorId);
    if (index != -1) {
      _mockSensors[index] =
          _mockSensors[index].copyWith(anomalyLevel: anomalyLevel);
    }
  }
}
