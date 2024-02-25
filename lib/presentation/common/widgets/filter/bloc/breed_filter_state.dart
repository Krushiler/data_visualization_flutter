part of 'breed_filter_bloc.dart';

@freezed
class BreedFilterState with _$BreedFilterState {
  const BreedFilterState._();

  const factory BreedFilterState({
    BreedFilter? breedFilter,
    @Default([]) List<Breed> breeds,
  }) = _BreedFilterState;
}
