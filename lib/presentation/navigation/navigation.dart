import 'package:data_visualization/presentation/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  final BuildContext context;

  const Navigation(this.context);

  void navigateToDashboard() => context.goNamed(Routes.dashboard.name);

  void navigateToLineChart() => context.goNamed(Routes.lineChart.name);

  void navigateToScatterChart() => context.goNamed(Routes.scatterChart.name);

  void navigateToTopChart() => context.goNamed(Routes.topChart.name);
}

extension NavigationExtension on BuildContext {
  Navigation get navigation => Navigation(this);
}
