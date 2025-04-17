import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';
import 'package:pulseboard/features/dashboard/presentation/provider/bubble_chart_config_provider.dart';
import 'package:pulseboard/shared/widget/custom_chips.dart';

class SensorBubbleChart extends ConsumerStatefulWidget {
  final List<SensorData> sensors;
  final Function(SensorData)? onBubbleTapped;

  const SensorBubbleChart({
    super.key,
    required this.sensors,
    this.onBubbleTapped,
  });

  @override
  ConsumerState<SensorBubbleChart> createState() => _SensorBubbleChartState();
}

class _SensorBubbleChartState extends ConsumerState<SensorBubbleChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final config = ref.watch(bubbleChartConfigProvider);
                return CustomChips(
                  title: 'Size by Humidity',
                  isSelected: config.sizeByHumidity,
                  onSelected: (selected) {
                    ref
                        .read(bubbleChartConfigProvider.notifier)
                        .toggleSizeByHumidity(selected);
                  },
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final config = ref.watch(bubbleChartConfigProvider);

                return CustomChips(
                  title: 'Size by Pressure',
                  isSelected: config.sizeByPressure,
                  onSelected: (selected) {
                    ref
                        .read(bubbleChartConfigProvider.notifier)
                        .toggleSizeByPressure(selected);
                  },
                );
              },
            ),
            // Consumer(
            //   builder: (context, ref, child) {
            //     final config = ref.watch(bubbleChartConfigProvider);

            //     return CustomChips(
            //       title: 'Color by Anomoly',
            //       isSelected: config.colorByAnomoly,
            //       onSelected: (selected) {
            //         ref
            //             .read(bubbleChartConfigProvider.notifier)
            //             .toggleColorByAnomoly(selected);
            //       },
            //     );
            //   },
            // ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer(builder: (context, ref, child) {
              final state = ref.watch(bubbleChartConfigProvider);
              return ScatterChart(
                ScatterChartData(
                  scatterSpots: _buildScatterSpots(
                      state.sizeByHumidity, state.colorByAnomoly),
                  minX: 0,
                  maxX: widget.sensors.isNotEmpty
                      ? widget.sensors.length.toDouble()
                      : 0,
                  minY: 0,
                  maxY: 100,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                    verticalInterval: 1,
                    horizontalInterval: 20,
                    getDrawingVerticalLine: (value) {
                      if (value >= 0.0 &&
                          value <= widget.sensors.length - 0.5) {
                        return FlLine(
                          color: Colors.grey.withValues(alpha: 0.3),
                          strokeWidth: 1,
                        );
                      }
                      return const FlLine(color: Colors.transparent);
                    },
                  ),
                  titlesData: FlTitlesData(
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}°C');
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < widget.sensors.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                widget.sensors[index].location ?? "",
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  scatterTouchData: ScatterTouchData(
                    enabled: widget.onBubbleTapped != null,
                    touchCallback:
                        (FlTouchEvent event, ScatterTouchResponse? response) {
                      if (response?.touchedSpot != null &&
                          event is FlTapUpEvent) {
                        final spot = response!.touchedSpot;
                        final sensor = widget.sensors[spot!.spotIndex];
                        widget.onBubbleTapped?.call(sensor);
                      }
                    },
                    touchTooltipData: ScatterTouchTooltipData(
                      getTooltipItems: (touchedSpot) {
                        final sensor = widget.sensors[touchedSpot.x.toInt()];
                        return ScatterTooltipItem(
                          sensor.name ?? "",
                          children: [
                            TextSpan(
                              text: '\nLocation: ${sensor.location}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            TextSpan(
                              text:
                                  '\nTemp: ${sensor.temperature?.toStringAsFixed(1)}°C',
                              style: const TextStyle(fontSize: 12),
                            ),
                            TextSpan(
                              text:
                                  '\nHumidity: ${sensor.humidity?.toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 12),
                            ),
                            TextSpan(
                              text:
                                  '\nPressure: ${sensor.pressure?.toStringAsFixed(1)}hPa',
                              style: const TextStyle(fontSize: 12),
                            ),
                            TextSpan(
                              text:
                                  '\nStatus: ${sensor.isOnline ?? false ? 'Online' : 'Offline'}',
                              style: TextStyle(
                                fontSize: 12,
                                color: sensor.isOnline ?? false
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  List<ScatterSpot> _buildScatterSpots(
      bool sizeByHumidity, bool colorByAnomaly) {
    return widget.sensors.asMap().entries.map((entry) {
      final index = entry.key;
      final sensor = entry.value;

      double radius;
      if (sizeByHumidity) {
        radius =
            (sensor.humidity ?? 0.0) / 8; // Scale down for better visualization
      } else {
        radius = ((sensor.pressure ?? 0.0) - 900) /
            24; // Scale pressure from 900-1100 to 0-5
      }

      Color color;
      if (!sensor.isOnline!) {
        color = Colors.grey.withValues(alpha: 0.5);
      } else if (colorByAnomaly) {
        if (sensor.anomalyLevel == 0) {
          color = Colors.green;
        } else if ((sensor.anomalyLevel ?? 0.0) <= 50) {
          color = Colors.yellow;
        } else {
          color = Colors.red;
        }
      } else {
        // Color by temperature gradient
        final tempRatio = (sensor.temperature ?? 0.0) / 100;
        color = Color.lerp(Colors.blue, Colors.red, tempRatio)!;
      }

      return ScatterSpot(index.toDouble(), sensor.temperature ?? 0.0,
          dotPainter: FlDotCirclePainter(
            color:
                color.withValues(alpha: sensor.isOnline ?? false ? 1.0 : 0.5),
            radius: radius,
          ));
    }).toList();
  }
}
