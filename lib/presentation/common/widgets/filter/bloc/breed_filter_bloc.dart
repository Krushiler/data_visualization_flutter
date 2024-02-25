import 'package:bloc/bloc.dart';
import 'package:data_visualization/data/breed_repository.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/domain/model/breed/breed_filter.dart';
import 'package:data_visualization/presentation/util/subscription_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed_filter_event.dart';

part 'breed_filter_state.dart';

part 'breed_filter_bloc.freezed.dart';

class BreedFilterBloc extends Bloc<BreedFilterEvent, BreedFilterState> with SubscriptionBloc {
  final BreedRepository _breedRepository;

  BreedFilterBloc(this._breedRepository) : super(const BreedFilterState()) {
    on<FilterChanged>((event, emit) {
      _breedRepository.applyFilter(event.breedFilter);
    });

    on<_RemoteFilterChanged>((event, emit) {
      emit(state.copyWith(breedFilter: event.breedFilter));
    });

    on<_BreedsChanged>((event, emit) {
      emit(state.copyWith(breeds: event.breeds));
    });

    subscribe(_breedRepository.watchFilter(), (filter) {
      add(_RemoteFilterChanged(filter));
    });

    subscribe(_breedRepository.watchBreeds(), (event) {
      add(_BreedsChanged(event));
    });
  }
}
