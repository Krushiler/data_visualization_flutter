import 'package:collection/collection.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/presentation/common/painters/scatter_painter.dart';
import 'package:data_visualization/presentation/style/theme/app_context_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScatterBreedsChart extends StatelessWidget {
  final List<Breed> breeds;
  final BreedRangeType xAxisType;
  final BreedRangeType yAxisType;
  final BreedRangeType sizeType;

  const ScatterBreedsChart(
    this.breeds, {
    super.key,
    required this.xAxisType,
    required this.yAxisType,
    required this.sizeType,
  });

  @override
  Widget build(BuildContext context) {
    return scatter(context);
  }

  Widget scatter(BuildContext context) {
    final minMedian = breeds.minMedianByType(sizeType);
    final maxMedian = breeds.maxMedianByType(sizeType);

    return ScatterChart(
      ScatterChartData(
        borderData: FlBorderData(show: false),
        scatterSpots: [
          for (final breed in breeds)
            ScatterSpot(
              breed.getRange(xAxisType).median,
              breed.getRange(yAxisType).median,
              dotPainter: ScatterPainter(
                color: context.colors.accent.withOpacity(0.5),
                sizeFactor: (breed.getRange(sizeType).median - minMedian) / (maxMedian - minMedian) * 4 + 0.5,
              ),
            ),
        ],
        scatterTouchData: ScatterTouchData(
          touchTooltipData: ScatterTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItems: (ScatterSpot touchedSpots) {
              final touchedBreed = breeds.firstWhereOrNull(
                (element) =>
                    element.getRange(xAxisType).median == touchedSpots.x &&
                    element.getRange(yAxisType).median == touchedSpots.y,
              );
              return ScatterTooltipItem(
                '${touchedBreed?.name}\n\n'
                '${xAxisType.name}: ${touchedBreed?.getRange(xAxisType).median}\n'
                '${yAxisType.name}: ${touchedBreed?.getRange(yAxisType).median}',
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: const SideTitles(showTitles: false),
            axisNameWidget: Text(xAxisType.name),
          ),
          rightTitles: AxisTitles(
            sideTitles: const SideTitles(showTitles: false),
            axisNameWidget: Text(yAxisType.name),
          ),
        ),
        minX: breeds.minMedianByType(xAxisType) - 10,
        maxX: breeds.maxMedianByType(xAxisType) + 10,
        minY: breeds.minMedianByType(yAxisType) - 10,
        maxY: breeds.maxMedianByType(yAxisType) + 10,
      ),
    );
  }
}
