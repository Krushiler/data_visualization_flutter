import 'package:data_visualization/di/app_module.dart';
import 'package:data_visualization/domain/model/config/theme_config.dart';
import 'package:data_visualization/presentation/navigation/routing.dart';
import 'package:data_visualization/presentation/style/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();

    return AppModule(
      builder: (context) => MaterialApp.router(
        theme: AppTheme(context.watch<ThemeConfig>()).createTheme(),
        routerConfig: router.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
