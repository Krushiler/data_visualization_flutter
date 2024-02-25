import 'package:data_visualization/presentation/style/theme/app_colors.dart';
import 'package:flutter/material.dart';

extension AppContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppColors get colors => theme.extension<AppColors>()!;
}
