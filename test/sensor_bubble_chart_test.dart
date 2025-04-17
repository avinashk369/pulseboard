import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pulseboard/features/dashboard/data/model/sensor_data.dart';
import 'package:pulseboard/features/dashboard/presentation/provider/bubble_chart_config_provider.dart';
import 'package:pulseboard/features/dashboard/presentation/widget/bubble_chart.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late List<SensorData> mockSensors;
  late ProviderContainer container;

  setUp(() {
    mockSensors = [
      SensorData(
        id: '1',
        name: 'Sensor 1',
        location: 'Line A',
        temperature: 25.0,
        humidity: 50.0,
        pressure: 1013.0,
        anomalyLevel: 0.0,
        isOnline: true,
        timestamp: DateTime.now(),
      ),
      SensorData(
        id: '2',
        name: 'Sensor 2',
        location: 'Line B',
        temperature: 30.0,
        humidity: 60.0,
        pressure: 1020.0,
        anomalyLevel: 25.0,
        isOnline: true,
        timestamp: DateTime.now(),
      ),
    ];

    container = ProviderContainer(overrides: [
      bubbleChartConfigProvider
          .overrideWith((ref) => BubbleChartConfigProvider()),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  Widget createWidgetUnderTest() {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: Scaffold(
          body: SensorBubbleChart(sensors: mockSensors),
        ),
      ),
    );
  }

  group('SensorBubbleChart', () {
    testWidgets('renders correctly with default configuration', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Size by Humidity'), findsOneWidget);
      expect(find.text('Size by Pressure'), findsOneWidget);
      expect(find.byType(ScatterChart), findsOneWidget);
    });

    testWidgets('displays correct number of bubbles', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final scatterChart =
          tester.widget<ScatterChart>(find.byType(ScatterChart));
      final spots = scatterChart.data.scatterSpots;
      expect(spots.length, mockSensors.length);
    });

    testWidgets('shows correct location labels on x-axis', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Line A'), findsOneWidget);
      expect(find.text('Line B'), findsOneWidget);
      expect(find.text('Line C'), findsNothing);
    });
  });

  group('BubbleChartConfigNotifier', () {
    test('initial state is correct', () {
      final notifier = BubbleChartConfigProvider();
      expect(notifier.state.sizeByHumidity, isTrue);
      expect(notifier.state.colorByAnomoly, isTrue);
    });

    test('toggleColorByAnomaly updates state correctly', () {
      final notifier = BubbleChartConfigProvider();

      notifier.toggleColorByAnomoly(false);
      expect(notifier.state.colorByAnomoly, isFalse);
      expect(notifier.state.sizeByHumidity, isTrue);

      notifier.toggleColorByAnomoly(true);
      expect(notifier.state.colorByAnomoly, isTrue);
      expect(notifier.state.sizeByHumidity, isFalse);
    });
  });
}
