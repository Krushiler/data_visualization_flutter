import 'package:data_visualization/presentation/common/widgets/theme/bloc/theme_picker_bloc.dart';
import 'package:data_visualization/presentation/common/widgets/theme/widget/theme_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemePickerView extends StatelessWidget {
  const ThemePickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemePickerBloc(context.read()),
      child: const ThemePickerWidget(),
    );
  }
}
