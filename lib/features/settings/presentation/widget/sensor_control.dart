import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';
import 'package:pulseboard/features/dashboard/presentation/provider/sensor_provider.dart';
import 'package:pulseboard/features/settings/presentation/widget/anomoly_indicator.dart';

class SensorControl extends ConsumerWidget {
  const SensorControl({super.key, required this.sensor});
  final SensorData sensor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    sensor.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Switch(
                  value: sensor.isOnline ?? false,
                  onChanged: (value) {
                    ref
                        .read(sensorProvider.notifier)
                        .updateSensorStatus(sensor.id ?? "", value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Simulate Anomaly:'),
            Slider(
              value: sensor.anomalyLevel ?? 0.0,
              min: 0,
              max: 100,
              divisions: 4,
              label: '${sensor.anomalyLevel?.toInt()}%',
              onChanged: sensor.isOnline ?? false
                  ? (value) {
                      ref
                          .read(sensorProvider.notifier)
                          .simulateAnomaly(sensor.id ?? "", value);
                    }
                  : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnomolyIndicator(label: '0%', color: Colors.green),
                AnomolyIndicator(label: '25%', color: Colors.yellow),
                AnomolyIndicator(label: '50%', color: Colors.orange),
                AnomolyIndicator(label: '75%', color: Colors.red),
                AnomolyIndicator(label: '100%', color: Colors.red[900]!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
