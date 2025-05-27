import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/buttons/glass_button.dart';
import '../../../core/utils/glassmorphism_effects.dart';
import '../../../core/widgets/cards/dashboard_card.dart';
import '../components/widget_palette.dart';

class DashboardEditorScreen extends StatefulWidget {
  const DashboardEditorScreen({Key? key}) : super(key: key);

  @override
  _DashboardEditorScreenState createState() => _DashboardEditorScreenState();
}

class _DashboardEditorScreenState extends State<DashboardEditorScreen> {
  final List<Widget> _dashboardWidgets = [];

  void _addWidget(Widget widget) {
    setState(() {
      _dashboardWidgets.add(DashboardCard(child: widget));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background,
                  AppColors.background.withOpacity(0.8),
                  AppColors.background.withOpacity(0.6),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Dashboard Editor',
                        style: GlassTextStyle.headline,
                      ),
                      const Spacer(),
                      GlassButton(
                        onPressed: () {},
                        child: Text('Save', style: GlassTextStyle.body),
                      ),
                    ],
                  ),
                ),
                // Main content
                Expanded(
                  child: Row(
                    children: [
                      // Widget palette
                      GlassContainer(
                        width: 200,
                        child: WidgetPalette(onAddWidget: _addWidget),
                      ),
                      // Dashboard area
                      Expanded(
                        child: GlassContainer(
                          child: _dashboardWidgets.isEmpty
                              ? Center(
                            child: Text(
                              'Add widgets from the palette',
                              style: GlassTextStyle.body,
                            ),
                          )
                              : GridView.count(
                            crossAxisCount: 2,
                            children: _dashboardWidgets,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}