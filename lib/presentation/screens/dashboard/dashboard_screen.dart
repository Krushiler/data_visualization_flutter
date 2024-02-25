import 'package:data_visualization/presentation/screens/dashboard/widget/dashboard_bloc_provider.dart';
import 'package:data_visualization/presentation/screens/dashboard/widget/dashboard_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardBlocProvider(
      child: DashboardWidget(),
    );
  }
}
