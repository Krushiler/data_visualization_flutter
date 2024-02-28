import 'package:csv/csv.dart';
import 'package:data_visualization/data/storage/breed_filter_storage.dart';
import 'package:data_visualization/data/storage/breeds_storage.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/domain/model/breed/breed_filter.dart';
import 'package:data_visualization/domain/model/common/range.dart';
import 'package:flutter/services.dart';
import 'package:stream_transform/stream_transform.dart';

class BreedRepository {
  final BreedFilterStorage _breedFilterStorage;
  final BreedsStorage _breedsStorage;

  BreedRepository(this._breedFilterStorage, this._breedsStorage) {
    _breedsStorage.watch().listen((value) {
      _breedFilterStorage.put(BreedFilter(
        height: value.heightRange,
        weight: value.weightRange,
        lifeSpan: value.lifeSpanRange,
        price: value.priceRange,
        rating: value.ratingRange,
      ));
    });
  }

  Stream<List<Breed>> watchBreeds() => _breedsStorage.watch();

  Stream<List<Breed>> watchFilteredBreeds() => _breedsStorage.watch().combineLatest(
        _breedFilterStorage.watch(),
        (breeds, filter) => filter.filter(breeds),
      );

  Stream<BreedFilter> watchFilter() => _breedFilterStorage.watch();

  void applyFilter(BreedFilter filter) {
    _breedFilterStorage.put(filter);
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

    _breedsStorage.put(breeds);
  }
}
