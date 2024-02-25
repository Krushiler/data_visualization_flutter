import 'package:data_visualization/presentation/common/widgets/charts/line_breeds_chart.dart';
import 'package:data_visualization/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:data_visualization/presentation/screens/dashboard/widget/dashboard_bloc_provider.dart';
import 'package:data_visualization/presentation/style/kit/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LineBreedsScreen extends StatelessWidget {
  const LineBreedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardBlocProvider(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.breeds.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.md),
                child: LineBreedsChart(state.breeds),
              ),
            ),
          );
        },
      ),
    );
  }
}
