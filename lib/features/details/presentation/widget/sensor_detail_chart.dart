import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';

class SensorDetailChart extends StatelessWidget {
  final SensorData sensor;

  const SensorDetailChart({super.key, required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Temperature Trend',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '${spot.y.toInt()}°C',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),
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
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      final hour = 8 + value.toInt();
                      return Text('$hour:00');
                    },
                  ),
                ),
              ),
              minX: 0,
              maxX: 10,
              minY: 0,
              maxY: 100,
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(11, (index) {
                    // Simulate some variation in temperature
                    final variation = (index % 3 == 0)
                        ? -5.0
                        : (index % 3 == 1)
                            ? 0.0
                            : 5.0;
                    return FlSpot(
                      index.toDouble(),
                      (sensor.temperature ?? 0.0) + variation,
                    );
                  }),
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Metrics Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String label;
                    double value;
                    switch (groupIndex) {
                      case 0:
                        label = 'Temperature';
                        value = sensor.temperature ?? 0.0;
                        break;
                      case 1:
                        label = 'Humidity';
                        value = sensor.humidity ?? 0.0;
                        break;
                      case 2:
                        label = 'Pressure';
                        value = sensor.pressure ?? 0.0;
                        break;
                      default:
                        label = '';
                        value = 0;
                    }
                    return BarTooltipItem(
                      '$label\n${value.toStringAsFixed(1)}',
                      const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return const Text('Temp');
                        case 1:
                          return const Text('Humid');
                        case 2:
                          return const Text('Press');
                        default:
                          return const Text('');
                      }
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey),
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: sensor.temperature ?? 0.0,
                      color: _getTemperatureColor(sensor.temperature ?? 0.0),
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: sensor.humidity ?? 0.0,
                      color: _getHumidityColor(sensor.humidity ?? 0.0),
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      toY: ((sensor.pressure ?? 0.0) - 900) /
                          2, // Scale for visualization
                      color: _getPressureColor(sensor.pressure ?? 0.0),
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
