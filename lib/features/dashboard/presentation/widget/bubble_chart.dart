import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';
import 'package:pulseboard/shared/widget/custom_chips.dart';

class SensorBubbleChart extends StatefulWidget {
  final List<SensorData> sensors;
  final Function(SensorData)? onBubbleTapped;

  const SensorBubbleChart({
    super.key,
    required this.sensors,
    this.onBubbleTapped,
  });

  @override
  State<SensorBubbleChart> createState() => _SensorBubbleChartState();
}

class _SensorBubbleChartState extends State<SensorBubbleChart> {
  bool _sizeByHumidity = true;
  bool _colorByAnomaly = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            CustomChips(
              title: 'Size by Humidity',
              isSelected: _sizeByHumidity,
              onSelected: (selected) {
                setState(() {
                  _sizeByHumidity = selected;
                  if (selected) _colorByAnomaly = !selected;
                });
              },
            ),
            CustomChips(
              title: 'Size by Pressure',
              isSelected: !_sizeByHumidity,
              onSelected: (selected) {
                setState(() {
                  _sizeByHumidity = !selected;
                  if (selected) _colorByAnomaly = !selected;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ScatterChart(
              ScatterChartData(
                scatterSpots: _buildScatterSpots(),
                minX: 0,
                maxX: widget.sensors.length.toDouble(),
                minY: 0,
                maxY: 100, // Max temperature
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: true),
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
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < widget.sensors.length) {
                          return Text(
                              widget.sensors[value.toInt()].location ?? "");
                        }
                        return const Text('');
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
                    // getTooltipItems: (List<ScatterSpot> touchedSpots) {
                    //   return touchedSpots.map((touchedSpot) {
                    //     final sensor = widget.sensors[touchedSpot.x.toInt()];
                    //     return ScatterTooltipItem(
                    //       sensor.name,
                    //       const TextStyle(color: Colors.white),
                    //       children: [
                    //         TextSpan(
                    //           text: '\nLocation: ${sensor.location}',
                    //           style: const TextStyle(fontSize: 12),
                    //         ),
                    //         TextSpan(
                    //           text:
                    //               '\nTemp: ${sensor.temperature.toStringAsFixed(1)}°C',
                    //           style: const TextStyle(fontSize: 12),
                    //         ),
                    //         TextSpan(
                    //           text:
                    //               '\nHumidity: ${sensor.humidity.toStringAsFixed(1)}%',
                    //           style: const TextStyle(fontSize: 12),
                    //         ),
                    //         TextSpan(
                    //           text:
                    //               '\nPressure: ${sensor.pressure.toStringAsFixed(1)}hPa',
                    //           style: const TextStyle(fontSize: 12),
                    //         ),
                    //         TextSpan(
                    //           text:
                    //               '\nStatus: ${sensor.isOnline ? 'Online' : 'Offline'}',
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: sensor.isOnline
                    //                 ? Colors.green
                    //                 : Colors.grey,
                    //           ),
                    //         ),
                    //       ],
                    //     );
                    //   }).toList();
                    // },

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
            ),
          ),
        ),
      ],
    );
  }

  List<ScatterSpot> _buildScatterSpots() {
    return widget.sensors.asMap().entries.map((entry) {
      final index = entry.key;
      final sensor = entry.value;

      double radius;
      if (_sizeByHumidity) {
        radius = (sensor.humidity ?? 0.0) /
            10; // Scale down for better visualization
      } else {
        radius = ((sensor.pressure ?? 0.0) - 900) /
            40; // Scale pressure from 900-1100 to 0-5
      }

      Color color;
      if (!sensor.isOnline!) {
        color = Colors.grey.withOpacity(0.5);
      } else if (_colorByAnomaly) {
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

      return ScatterSpot(
        index.toDouble(),
        sensor.temperature ?? 0.0,
        // radius: radius,
        // color: color.withOpacity(sensor.isOnline ? 1.0 : 0.5),
        // borderColor: Colors.black,
        // borderWidth: 1,
      );
    }).toList();
  }
}
