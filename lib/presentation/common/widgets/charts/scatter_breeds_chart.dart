import 'package:collection/collection.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScatterBreedsChart extends StatelessWidget {
  final List<Breed> breeds;
  final BreedRangeType xAxisType;
  final BreedRangeType yAxisType;

  const ScatterBreedsChart(this.breeds, {super.key, required this.xAxisType, required this.yAxisType});

  @override
  Widget build(BuildContext context) {
    return scatter(context);
  }

  Widget scatter(BuildContext context) {
    return ScatterChart(
      ScatterChartData(
        borderData: FlBorderData(show: false),
        scatterSpots: [
          for (final breed in breeds) ScatterSpot(breed.getRange(xAxisType).median, breed.getRange(yAxisType).median),
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
