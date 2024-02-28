import 'package:data_visualization/domain/model/breed/breed_filter.dart';
import 'package:data_visualization/presentation/common/widgets/charts/scatter_breeds_chart.dart';
import 'package:data_visualization/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:data_visualization/presentation/screens/dashboard/widget/dashboard_bloc_provider.dart';
import 'package:data_visualization/presentation/style/kit/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScatterBreedsScreen extends StatelessWidget {
  const ScatterBreedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardBlocProvider(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final breedFilter = context.watch<BreedFilter>();
          if (state.breeds.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.md),
                child: ScatterBreedsChart(
                  state.breeds,
                  xAxisType: breedFilter.xAxisType,
                  yAxisType: breedFilter.yAxisType,
                  sizeType: breedFilter.mainType,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
