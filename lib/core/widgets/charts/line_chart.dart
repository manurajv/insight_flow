import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constants/app_colors.dart';

class LineChartSample extends StatelessWidget {
  const LineChartSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        axisLine: const AxisLine(width: 0),
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      ),
      series: <CartesianSeries<ChartData, String>>[
        LineSeries<ChartData, String>(
          dataSource: [
            ChartData('Jan', 35),
            ChartData('Feb', 28),
            ChartData('Mar', 34),
            ChartData('Apr', 32),
            ChartData('May', 40),
          ],
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: AppColors.secondary,
          width: 2,
          markerSettings: const MarkerSettings(isVisible: true),
        )
      ],
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}