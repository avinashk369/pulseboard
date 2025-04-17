import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pulseboard/core/router/app_router.dart';
import 'package:pulseboard/features/dashboard/presentation/provider/sensor_provider.dart';
import 'package:pulseboard/features/dashboard/presentation/widget/bubble_chart.dart';
import 'package:pulseboard/features/dashboard/presentation/widget/sensor_summary_card.dart';

@RoutePage()
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorsAsync = ref.watch(sensorProvider);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Sensor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.router.push(const SettingsRoute()),
          ),
        ],
      ),
      body: sensorsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (sensors) {
          final onlineSensors =
              sensors.where((s) => s.isOnline ?? false).length;
          final offlineSensors = sensors.length - onlineSensors;
          final anomalies =
              sensors.where((s) => (s.anomalyLevel ?? 0.0) > 0).length;

          return Padding(
              padding: const EdgeInsets.all(16),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          children: [
                            Expanded(
                              child: SensorSummaryCard(
                                title: 'Total Sensors',
                                value: sensors.length.toString(),
                                icon: Icons.sensors,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SensorSummaryCard(
                                title: 'Online',
                                value: onlineSensors.toString(),
                                icon: Icons.check_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: SensorSummaryCard(
                                title: 'Offline',
                                value: offlineSensors.toString(),
                                icon: Icons.offline_bolt,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SensorSummaryCard(
                                title: 'Anomalies',
                                value: anomalies.toString(),
                                icon: Icons.warning,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Sensor Overview',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 400,
                          child: SensorBubbleChart(
                            sensors: sensors,
                            onBubbleTapped: (sensor) {
                              context.router.push(
                                  DetailsRoute(sensorId: sensor.id ?? ''));
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
