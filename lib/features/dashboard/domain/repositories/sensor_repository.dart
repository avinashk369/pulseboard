import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';

abstract class SensorRepository {
  Future<List<SensorData>> getSensors();
  Future<SensorData> getSensorDetails(String sensorId);
  Future<void> updateSensorStatus(String sensorId, bool isOnline);
  Future<void> simulateAnomaly(String sensorId, double anomalyLevel);
}
