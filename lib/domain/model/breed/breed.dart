import 'dart:math';

import 'package:data_visualization/domain/model/breed/breed_filter.dart';
import 'package:data_visualization/domain/model/common/range.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed.freezed.dart';

@freezed
class Breed with _$Breed {
  const Breed._();

  const factory Breed({
    required String name,
    required Range<int> price,
    required Range<int> weight,
    required Range<int> height,
    required Range<int> lifeSpan,
    required Range<int> rating,
  }) = _Breed;



  Range getRange(BreedRangeType type) {
    switch (type) {
      case BreedRangeType.height:
        return height;
      case BreedRangeType.weight:
        return weight;
      case BreedRangeType.lifeSpan:
        return lifeSpan;
      case BreedRangeType.price:
        return price;
      case BreedRangeType.rating:
        return rating;
    }
  }
}

enum BreedRangeType {
  height,
  weight,
  lifeSpan,
  price,
  rating;

  String get name {
    switch (this) {
      case BreedRangeType.height:
        return 'Рост';
      case BreedRangeType.weight:
        return 'Вес';
      case BreedRangeType.lifeSpan:
        return 'Время жизни';
      case BreedRangeType.price:
        return 'Цена';
      case BreedRangeType.rating:
        return 'Рейтинг';
    }
  }
}

extension BreedList on List<Breed> {
  Range<int> get priceRange => Range<int>(
        map((e) => e.price.min).reduce((a, b) => min(a, b)),
        map((e) => e.price.max).reduce((a, b) => max(a, b)),
      );

  Range<int> get weightRange => Range<int>(
        map((e) => e.weight.min).reduce((a, b) => min(a, b)),
        map((e) => e.weight.max).reduce((a, b) => max(a, b)),
      );

  Range<int> get heightRange => Range<int>(
        map((e) => e.height.min).reduce((a, b) => min(a, b)),
        map((e) => e.height.max).reduce((a, b) => max(a, b)),
      );

  Range<int> get lifeSpanRange => Range<int>(
        map((e) => e.lifeSpan.min).reduce((a, b) => min(a, b)),
        map((e) => e.lifeSpan.max).reduce((a, b) => max(a, b)),
      );

  Range<int> get ratingRange => Range<int>(
        map((e) => e.rating.min).reduce((a, b) => min(a, b)),
        map((e) => e.rating.max).reduce((a, b) => max(a, b)),
      );

  List<Range> get ranges => [priceRange, weightRange, heightRange, lifeSpanRange];

  double get minMedian => ranges.map((e) => e.median).reduce((a, b) => min(a, b));

  double get maxMedian => ranges.map((e) => e.median).reduce((a, b) => max(a, b));

  double minMedianByType(BreedRangeType type) {
    return map((e) => BreedFilter.getRange(e, type).median).reduce((a, b) => min(a, b));
  }

  double maxMedianByType(BreedRangeType type) {
    return map((e) => BreedFilter.getRange(e, type).median).reduce((a, b) => max(a, b));
  }

  Range rangeByType(BreedRangeType type) {
    switch (type) {
      case BreedRangeType.height:
        return heightRange;
      case BreedRangeType.weight:
        return weightRange;
      case BreedRangeType.lifeSpan:
        return lifeSpanRange;
      case BreedRangeType.price:
        return priceRange;
      case BreedRangeType.rating:
        return ratingRange;
    }
  }
}
