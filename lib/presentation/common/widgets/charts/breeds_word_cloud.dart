import 'dart:math';

import 'package:collection/collection.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:flutter/material.dart';
import 'package:word_cloud/word_cloud.dart';

class BreedsWordCloud extends StatelessWidget {
  final List<Breed> breeds;

  const BreedsWordCloud(this.breeds, {super.key});

  @override
  Widget build(BuildContext context) {
    final words = breeds.map((e) => e.name.split(' ')).flattened.toList();
    final wordsMap = <String, int>{};

    for (final word in words) {
      wordsMap[word] = (wordsMap[word] ?? 0) + 1;
    }

    final wordsData = wordsMap.entries
        .map((entry) => {'word': entry.key, 'value': entry.value})
        .where((element) => element['word'] != '/')
        .sorted((a, b) => -(a['value'] as int).compareTo(b['value'] as int))
        .getRange(0, min(20, wordsMap.length))
        .toList();

    return WordCloudView(
      data: WordCloudData(data: wordsData),
      mintextsize: 10,
      maxtextsize: 50,
      mapwidth: 400,
      mapheight: 200,
    );
  }
}
