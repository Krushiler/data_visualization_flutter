import 'package:data_visualization/di/app_module.dart';
import 'package:data_visualization/domain/model/config/theme_config.dart';
import 'package:data_visualization/presentation/navigation/routing.dart';
import 'package:data_visualization/presentation/style/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppModule(
      child: MaterialApp.router(
        theme: AppTheme(
          ThemeConfig(
            primaryColor: Colors.deepPurple,
            accentColor: Colors.deepOrange,
            isDark: false,
          ),
        ).createTheme(),
        routerConfig: AppRouter().router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
