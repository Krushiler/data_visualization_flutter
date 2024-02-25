part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = Started;

  const factory DashboardEvent.breedsChanged(List<Breed> breeds) = BreedsChanged;

  const factory DashboardEvent.filterChanged(BreedFilter filter) = _FilterChanged;
}
