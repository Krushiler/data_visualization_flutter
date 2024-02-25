import 'package:data_visualization/presentation/common/widgets/filter/bloc/breed_filter_bloc.dart';
import 'package:data_visualization/presentation/common/widgets/filter/widget/breed_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedFilterView extends StatelessWidget {
  const BreedFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BreedFilterBloc(context.read()),
      child: const BreedFilterWidget(),
    );
  }
}
