import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';
import 'package:pulseboard/features/dashboard/presentation/provider/sensor_provider.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorsAsync = ref.watch(sensorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: sensorsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (sensors) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Simulate Sensor States',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...sensors.map((sensor) => _buildSensorControl(sensor, ref)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSensorControl(SensorData sensor, WidgetRef ref) {
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
                _buildAnomalyIndicator(0, '0%', Colors.green),
                _buildAnomalyIndicator(25, '25%', Colors.yellow),
                _buildAnomalyIndicator(50, '50%', Colors.orange),
                _buildAnomalyIndicator(75, '75%', Colors.red),
                _buildAnomalyIndicator(100, '100%', Colors.red[900]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnomalyIndicator(int level, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
