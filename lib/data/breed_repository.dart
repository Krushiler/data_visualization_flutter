import 'package:csv/csv.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/domain/model/breed/breed_filter.dart';
import 'package:data_visualization/domain/model/common/range.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stream_transform/stream_transform.dart';

class BreedRepository {
  final BehaviorSubject<List<Breed>> _breeds = BehaviorSubject();

  Stream<List<Breed>> watchBreeds() => _breeds.stream;

  Stream<List<Breed>> watchFilteredBreeds() => _breeds.stream.combineLatest(
        _breedFilter.stream,
        (breeds, filter) => filter.filter(breeds),
      );

  final BehaviorSubject<BreedFilter> _breedFilter = BehaviorSubject.seeded(const BreedFilter());

  Stream<BreedFilter> watchFilter() => _breedFilter.stream;

  BreedRepository() {
    _breeds.listen((value) {
      _breedFilter.add(BreedFilter(
        height: value.heightRange,
        weight: value.weightRange,
        lifeSpan: value.lifeSpanRange,
        price: value.priceRange,
        rating: value.ratingRange,
      ));
    });
  }

  void applyFilter(BreedFilter filter) {
    _breedFilter.add(filter);
  }

  Future<void> fetchBreeds() async {
    var csv = await rootBundle.loadString('assets/data/dogs.csv');
    csv = csv.substring(csv.indexOf('\n') + 1);
    final converted = const CsvToListConverter(
      fieldDelimiter: ',',
    ).convert(csv);

    final breeds = <Breed>[];

    for (final row in converted) {
      breeds.add(Breed(
        name: row[0],
        price: Range<int>(row[1], row[2]),
        weight: Range<int>(row[3], row[4]),
        height: Range<int>(row[5], row[6]),
        lifeSpan: Range<int>(row[7], row[8]),
        rating: Range<int>(row[10], row[9]),
      ));
    }

    _breeds.add(breeds);
  }
}
