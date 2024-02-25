import 'dart:math';

import 'package:collection/collection.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/presentation/style/kit/dimens.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TopBreedsChart extends StatelessWidget {
  final List<Breed> breeds;

  const TopBreedsChart(this.breeds, {super.key});

  @override
  Widget build(BuildContext context) {
    final filteredBreeds = breeds
        .sorted((a, b) => -a.rating.median.compareTo(b.rating.median))
        .getRange(0, min(10, breeds.length))
        .toList();

    return RotatedBox(
      quarterTurns: 1,
      child: BarChart(
        BarChartData(
          groupsSpace: Dimens.md,
          gridData: const FlGridData(show: false),
          barGroups: [
            for (final (index, breed) in filteredBreeds.indexed)
              BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(toY: breed.rating.median),
                ],
              ),
          ],
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              rotateAngle: -90,
            ),
          ),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 300,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Padding(
                    padding: const EdgeInsets.all(Dimens.sm),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        breeds[value.toInt()].name,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
