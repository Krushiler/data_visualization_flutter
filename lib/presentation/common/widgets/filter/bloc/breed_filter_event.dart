part of 'breed_filter_bloc.dart';

@freezed
class BreedFilterEvent with _$BreedFilterEvent {
  const factory BreedFilterEvent.filterChanged(BreedFilter breedFilter) = FilterChanged;

  const factory BreedFilterEvent.remoteFilterChanged(BreedFilter breedFilter) = _RemoteFilterChanged;

  const factory BreedFilterEvent.breedsChanged(List<Breed> breeds) = _BreedsChanged;
}
