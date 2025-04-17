import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pulseboard/features/dashboard/presentation/provider/sensor_provider.dart';
import 'package:pulseboard/features/details/presentation/pages/status_indicator.dart';
import 'package:pulseboard/features/details/presentation/widget/sensor_detail_chart.dart';

@RoutePage()
class DetailsScreen extends ConsumerWidget {
  final String sensorId;

  const DetailsScreen(
      {super.key, @PathParam('sensorId') required this.sensorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorsAsync = ref.watch(sensorProvider);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Sensor Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: sensorsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (sensors) {
          final sensor = sensors.firstWhere((s) => s.id == sensorId);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        sensor.name ?? '',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Location: ${sensor.location}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          StatusIndicator(
                            label: 'Temperature',
                            value:
                                '${sensor.temperature?.toStringAsFixed(1)}°C',
                            color:
                                _getTemperatureColor(sensor.temperature ?? 0.0),
                          ),
                          const SizedBox(width: 16),
                          StatusIndicator(
                            label: 'Humidity',
                            value: '${sensor.humidity?.toStringAsFixed(1)}%',
                            color: _getHumidityColor(sensor.humidity ?? 0.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          StatusIndicator(
                            label: 'Pressure',
                            value: '${sensor.pressure?.toStringAsFixed(1)} hPa',
                            color: _getPressureColor(sensor.pressure ?? 0.0),
                          ),
                          const SizedBox(width: 16),
                          StatusIndicator(
                            label: 'Status',
                            value:
                                sensor.isOnline ?? false ? 'Online' : 'Offline',
                            color: sensor.isOnline ?? false
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SensorDetailChart(sensor: sensor),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getTemperatureColor(double temperature) {
    if (temperature < 20) return Colors.blue;
    if (temperature < 30) return Colors.green;
    if (temperature < 40) return Colors.orange;
    return Colors.red;
  }

  Color _getHumidityColor(double humidity) {
    if (humidity < 30) return Colors.orange;
    if (humidity < 70) return Colors.green;
    return Colors.red;
  }

  Color _getPressureColor(double pressure) {
    if (pressure < 980) return Colors.red;
    if (pressure < 1010) return Colors.orange;
    if (pressure < 1030) return Colors.green;
    return Colors.red;
  }
}
