import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constants/app_colors.dart';

class PieChartSample extends StatelessWidget {
  const PieChartSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      series: <CircularSeries<ChartData, String>>[
        PieSeries<ChartData, String>(
          dataSource: [
            ChartData('Sales', 35),
            ChartData('Marketing', 28),
            ChartData('Development', 34),
            ChartData('Support', 32),
          ],
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => _getColor(data.x),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  Color _getColor(String category) {
    switch (category) {
      case 'Sales':
        return AppColors.primary;
      case 'Marketing':
        return AppColors.secondary;
      case 'Development':
        return AppColors.success;
      case 'Support':
        return AppColors.warning;
      default:
        return Colors.grey;
    }
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}