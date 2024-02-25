import 'package:collection/collection.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineBreedsChart extends StatelessWidget {
  final List<Breed> breeds;

  const LineBreedsChart(this.breeds, {super.key});

  @override
  Widget build(BuildContext context) {
    return lineChart(context);
  }

  Widget lineChart(BuildContext context) {
    final data = [
      breeds.priceRange.median,
      breeds.weightRange.median,
      breeds.heightRange.median,
      breeds.lifeSpanRange.median,
    ];
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => spots.mapIndexed((index, element) {
              return LineTooltipItem(
                element.y.toStringAsFixed(2),
                const TextStyle(),
              );
            }).toList(),
            fitInsideVertically: true,
            fitInsideHorizontally: true,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: data.mapIndexed((index, value) => FlSpot(index.toDouble() + 1, value)).toList(),
            dotData: const FlDotData(),
          ),
        ],
        minX: 0,
        maxX: 5,
        minY: breeds.minMedian - 10,
        maxY: breeds.maxMedian + 10,
        borderData: FlBorderData(border: const Border(bottom: BorderSide(), left: BorderSide())),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: _bottomTitles, drawBelowEverything: true),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'Цена';
              break;
            case 2:
              text = 'Вес';
              break;
            case 3:
              text = 'Рост';
              break;
            case 4:
              text = 'Время жизни';
              break;
          }
          return Text(text);
        },
      );
}
