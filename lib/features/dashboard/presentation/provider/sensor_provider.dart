import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';
import 'package:pulseboard/features/dashboard/data/repositories/sensor_repository_impl.dart';
import 'package:pulseboard/features/dashboard/domain/repositories/sensor_repository.dart';

class SensorNotifier extends StateNotifier<AsyncValue<List<SensorData>>> {
  final SensorRepository _sensorRepository;

  SensorNotifier(this._sensorRepository) : super(const AsyncValue.loading()) {
    loadSensors();
  }

  Future<void> loadSensors() async {
    state = const AsyncValue.loading();
    try {
      final sensors = await _sensorRepository.getSensors();
      state = AsyncValue.data(sensors);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateSensorStatus(String sensorId, bool isOnline) async {
    try {
      await _sensorRepository.updateSensorStatus(sensorId, isOnline);
      state.whenData((sensors) {
        final updatedSensors = sensors.map((sensor) {
          if (sensor.id == sensorId) {
            return sensor.copyWith(isOnline: isOnline);
          }
          return sensor;
        }).toList();
        state = AsyncValue.data(updatedSensors);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> simulateAnomaly(String sensorId, double anomalyLevel) async {
    try {
      await _sensorRepository.simulateAnomaly(sensorId, anomalyLevel);
      state.whenData((sensors) {
        final updatedSensors = sensors.map((sensor) {
          if (sensor.id == sensorId) {
            return sensor.copyWith(anomalyLevel: anomalyLevel);
          }
          return sensor;
        }).toList();
        state = AsyncValue.data(updatedSensors);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final sensorRepositoryProvider = Provider<SensorRepository>((ref) {
  return SensorRepositoryImpl();
});

final sensorProvider =
    StateNotifierProvider<SensorNotifier, AsyncValue<List<SensorData>>>((ref) {
  final repository = ref.watch(sensorRepositoryProvider);
  return SensorNotifier(repository);
});
