import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/presentation/common/widgets/charts/breeds_word_cloud.dart';
import 'package:data_visualization/presentation/common/widgets/charts/line_breeds_chart.dart';
import 'package:data_visualization/presentation/common/widgets/charts/scatter_breeds_chart.dart';
import 'package:data_visualization/presentation/common/widgets/charts/top_breeds_chart.dart';
import 'package:data_visualization/presentation/navigation/navigation.dart';
import 'package:data_visualization/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:data_visualization/presentation/style/kit/dimens.dart';
import 'package:data_visualization/presentation/style/kit/gap.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.md),
              child: state.breeds.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: container(
                                  ScatterBreedsChart(
                                    state.breeds,
                                    xAxisType: state.breedFilter.xAxisType,
                                    yAxisType: state.breedFilter.yAxisType,
                                  ),
                                  onPressed: () {
                                    context.navigation.navigateToScatterChart();
                                  },
                                ),
                              ),
                              Gap.md,
                              Expanded(
                                  child: container(TopBreedsChart(state.breeds), onPressed: () {
                                context.navigation.navigateToTopChart();
                              })),
                            ],
                          ),
                        ),
                        Gap.md,
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: container(LineBreedsChart(state.breeds), onPressed: () {
                                context.navigation.navigateToLineChart();
                              })),
                              // Gap.md,
                              // container(BreedsWordCloud(state.breeds)),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget container(Widget child, {void Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(Dimens.md),
      child: Container(
        padding: const EdgeInsets.all(Dimens.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.md),
          border: Border.all(
            color: Colors.black12,
          ),
        ),
        child: child,
      ),
    );
  }
}
