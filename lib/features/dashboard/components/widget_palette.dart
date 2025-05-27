import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/glassmorphism_effects.dart';
import '../../../core/widgets/buttons/glass_button.dart';
import '../../../core/widgets/charts/bar_chart.dart';
import '../../../core/widgets/charts/line_chart.dart';
import '../../../core/widgets/charts/pie_chart.dart';

class WidgetPalette extends StatelessWidget {
  final Function(Widget) onAddWidget;

  const WidgetPalette({required this.onAddWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Widgets', style: GlassTextStyle.headline.copyWith(fontSize: 18)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildWidgetItem('Line Chart', Icons.show_chart, () {
                  onAddWidget(const LineChartSample());
                }),
                _buildWidgetItem('Bar Chart', Icons.bar_chart, () {
                  onAddWidget(const BarChartSample());
                }),
                _buildWidgetItem('Pie Chart', Icons.pie_chart, () {
                  onAddWidget(const PieChartSample());
                }),
                _buildWidgetItem('KPI Card', Icons.numbers, () {
                  onAddWidget(_buildKPICard());
                }),
                _buildWidgetItem('Data Table', Icons.table_chart, () {
                  onAddWidget(_buildDataTable());
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetItem(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GlassButton(
        onPressed: onTap,
        width: double.infinity,
        text: '',
        child: Row(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(width: 8),
            Text(title, style: GlassTextStyle.body),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: AppColors.primaryGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Revenue', style: GlassTextStyle.body),
          const SizedBox(height: 8),
          Text('\$12,345',
              style: GlassTextStyle.headline.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text('+12% from last month',
              style: GlassTextStyle.body.copyWith(color: AppColors.success)),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Month')),
          DataColumn(label: Text('Sales')),
          DataColumn(label: Text('Growth')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('January')),
            DataCell(Text('\$3,456')),
            DataCell(Text('+5%')),
          ]),
          DataRow(cells: [
            DataCell(Text('February')),
            DataCell(Text('\$4,123')),
            DataCell(Text('+12%')),
          ]),
          DataRow(cells: [
            DataCell(Text('March')),
            DataCell(Text('\$4,789')),
            DataCell(Text('+8%')),
          ]),
        ],
      ),
    );
  }
}