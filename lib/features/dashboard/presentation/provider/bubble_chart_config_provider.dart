import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard/features/dashboard/data/model/bubble_chart_config.dart';

class BubbleChartConfigProvider extends StateNotifier<BubbleChartConfig> {
  BubbleChartConfigProvider() : super(const BubbleChartConfig());

  void toggleSizeByHumidity(bool selected) {
    state = state.copyWith(
      sizeByHumidity: selected,
      sizeByPressure: selected ? false : state.sizeByPressure,
    );
  }

  void toggleSizeByPressure(bool selected) {
    state = state.copyWith(
      sizeByPressure: selected,
      sizeByHumidity: selected ? false : state.sizeByHumidity,
    );
  }

  void toggleColorByAnomoly(bool selected) {
    state = state.copyWith(
      colorByAnomoly: selected,
      sizeByPressure: selected ? false : state.sizeByPressure,
      sizeByHumidity: selected ? false : state.sizeByHumidity,
    );
  }
}

final bubbleChartConfigProvider =
    StateNotifierProvider<BubbleChartConfigProvider, BubbleChartConfig>(
  (ref) => BubbleChartConfigProvider(),
);
