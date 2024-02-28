import 'package:bloc/bloc.dart';
import 'package:data_visualization/data/repository/breed_repository.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/domain/model/breed/breed_filter.dart';
import 'package:data_visualization/presentation/util/subscription_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_bloc.freezed.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> with SubscriptionBloc {
  final BreedRepository _breedRepository;

  DashboardBloc(this._breedRepository) : super(const DashboardState()) {
    on<Started>((event, emit) {
      _breedRepository.fetchBreeds();
    });
    on<BreedsChanged>((event, emit) {
      emit(state.copyWith(breeds: event.breeds));
    });
    on<_FilterChanged>((event, emit) {
      emit(state.copyWith(breedFilter: event.filter));
    });


    subscribe(_breedRepository.watchFilteredBreeds(), (breeds) {
      add(DashboardEvent.breedsChanged(breeds));
    });
    subscribe(_breedRepository.watchFilter(), (event) {
      add(DashboardEvent.filterChanged(event));
    });
  }
}
