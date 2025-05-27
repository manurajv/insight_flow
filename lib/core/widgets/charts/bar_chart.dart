import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constants/app_colors.dart';

class BarChartSample extends StatelessWidget {
  const BarChartSample({Key? key}) : super(key: key);

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
        ColumnSeries<ChartData, String>(
          dataSource: [
            ChartData('Product A', 35),
            ChartData('Product B', 28),
            ChartData('Product C', 34),
            ChartData('Product D', 32),
          ],
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(4),
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