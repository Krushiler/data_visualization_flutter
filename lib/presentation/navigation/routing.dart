import 'package:data_visualization/presentation/navigation/routes.dart';
import 'package:data_visualization/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:data_visualization/presentation/screens/dashboard/screens/line/line_breeds_screen.dart';
import 'package:data_visualization/presentation/screens/dashboard/screens/scatter/scatter_breeds_screen.dart';
import 'package:data_visualization/presentation/screens/dashboard/screens/top/top_breeds_screen.dart';
import 'package:data_visualization/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter _router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        pageBuilder: (context, state, child) => _page(HomeScreen(child: child)),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: Routes.dashboard.name,
            pageBuilder: (context, state) => _page(const DashboardScreen(), name: 'Dashboard'),
          ),
          GoRoute(
            path: '/line-chart',
            name: Routes.lineChart.name,
            pageBuilder: (context, state) => _page(const LineBreedsScreen(), name: 'Line'),
          ),
          GoRoute(
            path: '/scatter-chart',
            name: Routes.scatterChart.name,
            pageBuilder: (context, state) => _page(const ScatterBreedsScreen(), name: 'Scatter'),
          ),
          GoRoute(
            path: '/top-chart',
            name: Routes.topChart.name,
            pageBuilder: (context, state) => _page(const TopBreedsScreen(), name: 'Top'),
          ),
        ],
      ),
    ],
  );

  get router => _router;
}

Page _page(Widget child, {String? name}) {
  return MaterialPage(child: child, name: name);
}
