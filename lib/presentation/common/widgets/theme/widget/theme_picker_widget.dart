import 'package:data_visualization/presentation/common/widgets/color_chip.dart';
import 'package:data_visualization/presentation/common/widgets/theme/bloc/theme_picker_bloc.dart';
import 'package:data_visualization/presentation/style/kit/gap.dart';
import 'package:data_visualization/presentation/util/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemePickerWidget extends StatelessWidget {
  const ThemePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemePickerBloc, ThemePickerState>(
      builder: (context, state) {
        if (state.theme == null) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          width: 400,
          child: Column(
            children: [
              const Text('Тема'),
              Gap.md,
              Row(
                children: [
                  const SizedBox(width: 150, child: Text('Тёмный режим')),
                  const SizedBox(width: 12),
                  Checkbox(
                    value: state.theme?.isDark,
                    onChanged: (value) {
                      context.read<ThemePickerBloc>().add(
                            ThemePickerEvent.themeChanged(
                              state.theme!.copyWith(
                                isDark: value ?? false,
                              ),
                            ),
                          );
                    },
                  ),
                ],
              ),
              Gap.md,
              Row(
                children: [
                  const SizedBox(width: 150, child: Text('Основной цвет')),
                  Gap.md,
                  ColorChip(
                    color: state.theme!.primaryColor,
                    onColorChanged: (color) {
                      context.read<ThemePickerBloc>().add(
                            ThemePickerEvent.themeChanged(
                              state.theme!.copyWith(
                                primaryColor: MaterialColorGenerator.from(color),
                              ),
                            ),
                          );
                    },
                  ),
                ],
              ),
              Gap.md,
              Row(
                children: [
                  const SizedBox(width: 150, child: Text('Акцентный цвет')),
                  Gap.md,
                  ColorChip(
                    color: state.theme!.accentColor,
                    onColorChanged: (color) {
                      context.read<ThemePickerBloc>().add(
                            ThemePickerEvent.themeChanged(
                              state.theme!.copyWith(
                                accentColor: MaterialColorGenerator.from(color),
                              ),
                            ),
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
