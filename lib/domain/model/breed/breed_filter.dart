import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/domain/model/common/range.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed_filter.freezed.dart';

@freezed
class BreedFilter with _$BreedFilter {
  const BreedFilter._();

  const factory BreedFilter({
    @Default(BreedRangeType.rating) mainType,
    @Default(BreedRangeType.height) xAxisType,
    @Default(BreedRangeType.weight) yAxisType,
    Range<int>? height,
    Range<int>? weight,
    Range<int>? lifeSpan,
    Range<int>? price,
    Range<int>? rating,
  }) = _BreedFilter;

  List<Breed> filter(List<Breed> breeds) {
    return breeds
        .where((breed) =>
            _fitsRange(breed.height, height) &&
            _fitsRange(breed.weight, weight) &&
            _fitsRange(breed.lifeSpan, lifeSpan) &&
            _fitsRange(breed.price, price) &&
            _fitsRange(breed.rating, rating))
        .toList();
  }

  static bool _fitsRange<T extends num>(Range<T> breedRange, Range<T>? range) {
    return range == null || range.fits(breedRange);
  }

  static Range getRange(Breed breed, BreedRangeType type) => breed.getRange(type);
}
